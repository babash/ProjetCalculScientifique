% Reconnaissance vocale par DTW

vocabulaire={'arretetoi', 'atterrissage', 'avance', 'decollage', 'droite', 'etatdurgence', 'faisunflip', 'gauche', 'plusbas', 'plushaut', 'recule', 'tournedroite', 'tournegauche'};
chemin='../corpus/dronevolant_nonbruite/' ;
nbmots=length(vocabulaire) ;

% Lecture des fichiers audio
% ref
locuteur = 'M01' ;
for mot=1:nbmots
    nomfichier = [ chemin, locuteur, '_', vocabulaire{mot}, '.wav' ] ;
    REF{mot} = parametrisation(nomfichier);
endfor

% hyp
%hypotheses={'M02'};
%hypotheses={'M02','M03','M04', 'M05','M06','M07','M08', 'M09', 'M10', 'M11', 'M12', 'M13'};
hypotheses={'M02','M03','M04', 'M05','M06'};
%hypotheses={'F02'};
%hypotheses={'F02','F03','F04', 'F05'};
nbhypotheses=length(hypotheses);
MatriceConfusion=zeros(nbmots,nbhypotheses);

for nolocuteur = 1:nbhypotheses
    locuteurhyp = hypotheses{nolocuteur};
    for mot=1:nbmots
        nomfichier = [ chemin, locuteurhyp, '_', vocabulaire{mot}, '.wav' ] ;
        HYP{mot} = parametrisation(nomfichier);
        % calcul des distances et remplissage de la matrice de confusion
        [d,]=CalculDistanceDTW(REF{nolocuteur},HYP{mot},"distance_vect");
        MatriceConfusion(nolocuteur,mot)=d;
    endfor
endfor
%vocabulaire
disp(MatriceConfusion);
tauxreco = 1-d; % calculez ici le taux de reconnaissance à partir de la matrice de confusion
disp(['Taux de reconnaissance : ',num2str(tauxreco*100), '%']);
