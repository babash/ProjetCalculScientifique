function d=distance_vect(sequence1, sequence2, i, j)
  d = 0;
  taille = length(sequence1(:,1));
  for cmp = 1:taille
    d = d + mpower(sequence1(cmp, i) - sequence2(cmp, j), 2);
  endfor
  d = sqrt(d);
end