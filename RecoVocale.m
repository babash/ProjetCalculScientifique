% Reconnaissance vocale par DTW

vocabulaire={'arretetoi', 'atterrissage', 'avance', 'decollage', 'droite', 'etatdurgence', 'faisunflip', 'gauche', 'plusbas', 'plushaut', 'recule', 'tournedroite', 'tournegauche'};
chemin='corpus/dronevolant_nonbruite/' ;
nbmots=length(vocabulaire) ;

% Lecture des fichiers audio
% ref
locuteur = 'M01' ;
for mot=1:nbmots
    nomfichier = [ chemin, locuteur, '_', vocabulaire{mot}, '.wav' ] ;
    REF{mot} = parametrisation(nomfichier); 
endfor

hypotheses = {'M02', 'M03'} ;
%hypotheses={'M02','M03','M04', 'M05','M06','M07','M08', 'M09', 'M10', 'M11', 'M12', 'M13'};
%hypotheses={'F02'};
%hypotheses={'F02','F03','F04', 'F05'};
nbhypotheses = length(hypotheses);

%On souhaite comparé pour chaque mot dit par le locuteur M1, tous les mots dit par tous les autres locuteurs.
%Par conséquant on utilise une matrice de trois dimensions, nbhypotheses étant le nombre d'autre locuteurs.
%La case (mot1, mot2, u) de MatriceConfusion contient alors la distance calculée entre mot1 et mot2. Dis respectivement
%par les locuteurs M1 et u.
MatriceConfusion=zeros(nbmots, nbmots, nbhypotheses);

%Suite à quelque test, nou avons choisi de fixé arbitrairement à 12 le seuil pour lequel 
%on considère un mot comme reconnu.
seuil = 12;
%Nous avons besoin de compter le nombre de mot reconnu pour pouvoir établir le Taux de Reconnaissance
nb_reconnu = 0;


for nohypothese = 1:nbhypotheses
    hypothese = hypotheses{nohypothese};
    for mot=1:nbmots
        %On calcul pour chaque mot on calcul la matrice de paramétrisation
        nomfichier = [ chemin, hypothese, '_', vocabulaire{mot}, '.wav' ] ;
        HYP{mot} = parametrisation(nomfichier);
        
        %Arbitrairement on fixe min à 100. Sa valeur ne compte pas à partir du moment 
        %qu'elle est strictement supérieur au seuil.
        %min va nous permettre de trouver la plus petite distance calculé entre "mot" et tous les mots,
        %et ainsi trouver celui qui "match" le mieux avec.
        min = 100;
        
        for mot_compare = 1:nbmots
          %On calcul la distance entre mot et mot_compare. Et on stocke le résultat dans 
          %la case correspondante dans la Matrice de Confusion.
          %Ici mot_comparé va itérer tous les mots.
          [D, g] = CalculDistanceDTW(REF{mot_compare}, HYP{mot}, "distance_vect");
          MatriceConfusion(mot, mot_compare, nohypothese) = D;
          %On considère que seul le mot ayant obtenu le plus petit score est considéré.
          %Ainsi, on stocke le plus petit score obtenu.
          if (min > D)
            min = D;
          endif
        endfor
        
        if (min < seuil)
          %Si le résultat est strictement inférieur à seuil, alors le mots est considéré comme reconnu.
          nb_reconnu += 1;
        endif
    endfor
endfor

%vocabulaire
MatriceConfusion
tauxreco = nb_reconnu / (nbhypotheses*nbmots); % calculez ici le taux de reconnaissance à partir de la matrice de confusion 
disp(['Taux de reconnaissance : ',num2str(tauxreco*100), '%']);