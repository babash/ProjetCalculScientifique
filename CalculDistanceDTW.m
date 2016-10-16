function [D,g] = CalculDistanceDTW(sequence1, sequence2, distance, contrainte = +inf)
    [hauteur, largeur] = size(sequence1);
    size_1 = largeur + 1;
    [hauteur, largeur] = size(sequence2);
    size_2 = largeur + 1;
    g = zeros(size_1, size_2);
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
            
endfunction