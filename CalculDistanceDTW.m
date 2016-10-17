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
    for i = 2 : size_1
        g(i, 1) = +inf;
    endfor
    for j = 2 : size_2
        g(1, j) = +inf;
    endfor
    w1 = 1;
    w2 = 1;
    w3 = 1;
    
    for i = 2 : size_1
        for j = 2 : size_2
            if(abs(i - j) <= contrainte)
              d = feval(distance, sequence1, sequence2, i-1, j-1);
              
              haut = w1 * d + g(i-1, j);
              haut_gauche = w2 * d + g(i-1, j-1);
              gauche = w3 * d + g(i, j-1);
              vecteur = [haut, haut_gauche, gauche];
              
              g(i, j) = min(vecteur);
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
              g(i, j) = +inf;
            endif
        endfor
    endfor
    D = g(size_1, size_2)/(size_1+size_2);
    %imagesc(g);
    %D
    g
    case_prec
            
endfunction