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

MatriceConfusion=zeros(nbmots, nbmots, nbhypotheses);

seuil = 12;
nb_reconnu = 0;

for nohypothese = 1:nbhypotheses
    hypothese = hypotheses{nohypothese};
    for mot=1:nbmots
        nomfichier = [ chemin, hypothese, '_', vocabulaire{mot}, '.wav' ] ;
        HYP{mot} = parametrisation(nomfichier);
        min = 100;
        
        for mot_compare = 1:nbmots
          [D, g] = CalculDistanceDTW(REF{mot_compare}, HYP{mot}, "distance_vect");
          MatriceConfusion(mot, mot_compare, nohypothese) = D;
          if (min > D)
            min = D;
          endif
        endfor
        
        if (min != -1 && min < 12)
          nb_reconnu += 1;
        endif
    endfor
endfor

%vocabulaire
MatriceConfusion
tauxreco = nb_reconnu / (nbhypotheses*nbmots); % calculez ici le taux de reconnaissance à partir de la matrice de confusion 
disp(['Taux de reconnaissance : ',num2str(tauxreco*100), '%']);