
function [D,g]=CalculDistanceDTW(sequence1, sequence2, distance, contrainte=+inf)

    [a,b]=size(sequence1);
    nblignes=b+1;
    [a,b]=size(sequence2);
    nbcolonnes=b+1;
    g={zeros(nblignes,nbcolonnes),zeros(nblignes,nbcolonnes),zeros(nblignes,nbcolonnes)};
    w0=1;
    w1=1;
    w2=1;
    for i = 2:nbcolonnes
        g{1}(1,i)=+inf;
    endfor
    for i = 2:nblignes
        g{1}(i,1)=+inf;
    endfor
    for i = 2:nblignes
        for j = 2:nbcolonnes
          if(abs(i-j)<=contrainte)
            d=feval(distance,sequence1, sequence2 , i-1, j-1);
            cursor=[( w0 * d + g{1}( i-1 , j ) ) , ...
                ( w1 * d + g{1}( i-1 ,j-1 ) ) , ...
                ( w2 * d + g{1}( i , j-1 ) ) ];
            g{1}(i,j)=min(cursor);
            switch g{1}(i,j)
              case cursor(1)
                g{2}(i,j)=i-1;
                g{3}(i,j)=j;
              case cursor(2)
                g{2}(i,j)=i-1;
                g{3}(i,j)=j-1;
              case cursor(3)
                g{2}(i,j)=i;
                g{3}(i,j)=j-1;
            endswitch
            else
            g{1}(i,j)=+inf;
            endif
        endfor
    endfor
    ##g
    D=g{1}(i,j)/(nblignes+nbcolonnes);
    ##feval("AfficheChemins",g,nblignes,nbcolonnes);
endfunction