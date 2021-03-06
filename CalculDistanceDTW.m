function [D,g] = CalculDistanceDTW(sequence1, sequence2, distance, contrainte = +inf)
    %On prepare la taille de notre tableau a deux dimensions. 
    %Etant donné que nous devons rajouter une ligne et une colonne pour faire nos calculs,
    %Les dimensions de notre tableau sont donc la longueur de nos de deux matrices +1.
    [hauteur, largeur] = size(sequence1);
    size_1 = largeur + 1;
    [hauteur, largeur] = size(sequence2);
    size_2 = largeur + 1;
    %Creation du tableau g
    g = zeros(size_1, size_2);
    
    %Pour pouvoir stocker pour chaque case le chemin parcouru,
    %nous créons deux tableaux (un pour l'abscisse, l'autre pour l'ordonné).
    %Ces deux tableaux permettent de retrouver l'indice de la case précédente.
    %Ils sont modélisés par un tableau à trois dimensions.
    %Les deux premières dimensions sont les dimensions du tableau sur lequel on travail.
    %La troisième (et dernière) dimension permet la gestion des deux tableaux.
    %Celle-ci est donc de taille 2.
    %Ainsi, si l'on souhaite connaitre les coordonnées de la case (x, y) de notre tableau g :
    %Il faut regarder les cases de coordonnées (x, y,  1) pour l'ordonnée et (x, y, 2) pour l'abscisse
    case_prec = zeros(size_1, size_2, 2);
    
    %On initialise les cases des cotés gauche et haut de notre matrice à +inf
    %Ceci permet de s'assurer que qu'aucune case ne prendra pour case précédentes ces cases de calculs.
    %Et aussi de ne pas sortir des dimensions du tableau.
    for i = 2 : size_1
        g(i, 1) = +inf;
    endfor
    for j = 2 : size_2
        g(1, j) = +inf;
    endfor
    
    %Coefficiant initialisé à 1. A de changer si besoin.
    w1 = 1;
    w2 = 1;
    w3 = 1;
    
    %Pour chaque case nous allons calculer sa distance, ainsi que sa case précédente.
    for i = 2 : size_1
        for j = 2 : size_2
            %On ne traite pas les cases trop éloignées de la diagonale. Contrainte fixée par l'utilisateur
            if(abs(i - j) <= contrainte)
              d = feval(distance, sequence1, sequence2, i-1, j-1);
              
              %On stocke la distance de la case (i, j) pour chacun de ses voisins [haut, haut gauche, gauche] dans vecteur
              %Chacun d'entre eux pouvant etre la case precedente à (i, j)
              haut = w1 * d + g(i-1, j);
              haut_gauche = w2 * d + g(i-1, j-1);
              gauche = w3 * d + g(i, j-1);
              vecteur = [haut, haut_gauche, gauche];
              
              %La distance à (i, j) devant etre la plus petite possible, on prends le min de vecteur.
              g(i, j) = min(vecteur);
              
              %On cherche ici quelle était la case précédente à (i, j) en testant chaque valeur
              %A distance égale, on préfère la diagonale, donc elle est en premier dans le if
              %A distance égale en la case en haut, et celle de gauche, on choisit arbitrairement la case du haut.
              if(g(i, j) == haut_gauche)
                case_prec(i, j, 1) = i-1;
                case_prec(i, j, 2) = j-1;
              elseif g(i, j) == haut
                case_prec(i, j, 1) = i-1;
                case_prec(i, j, 2) = j;
              else
                case_prec(i, j, 1) = i;
                case_prec(i, j, 2) = j-1;
              endif
            else
              %Si la case est trop éloigné de la diagonale, on lui attribut comme valeur +inf
              %De cette manière elle ne pourra pas ^etre utilisée comme case précédente.
              g(i, j) = +inf;
            endif
        endfor
    endfor
    %La distance D est égale à la distance calculée de la dernière case divisée par la somme de la taille
    %des deux sequences
    D = g(size_1, size_2)/(size_1+size_2-2);
    
    %Pour afficher la matrice en cases couleurs, décommentez la ligne suivante :
    %imagesc(g);
    
    %Pour le débugage : décommentez pour afficher :
    %D
    %g
    %case_prec
            
endfunction