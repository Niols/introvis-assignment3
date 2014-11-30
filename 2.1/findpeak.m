%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                           Programming assignment 3                           %
%                                  findpeak.m                                  %
%                                                                              %
%                             by Nicolas Jeannerod                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% data: d x n
% n vecteurs colonne de dimension d, les points sur lesquels ont cherche.

% idx: 1 x 1
% L'indice du point pour lequel on veut trouver le pic voisin.
% Pour les besoins du problème, idx peut aussi accepter d x 1, auquel cas il est
% le point lui même. Mais ce n'est pas utilisable depuis l'extérieur

% r: 1 x 1
% Le rayon de la sphere.

% peak: d x 1
% Le pic trouvé.

function peak = findpeak (data, idx, r)

  % On récupère les dimensions du problème : [d] la dimension de l'espace et [n]
  % le nombre de points.
  [d n] = size (data);

  % On récupère le point concerné. On teste pour ça si c'est un point, ou juste
  % un id.
  if (d == size (idx, 1))
    p = idx;
  else
    p = data (:, idx);
  endif

  % On écrit la condition d'appartenance à la sphere
  % Il s'agit de dire que la distance entre [p] et le point est inférieur à [r].
  % On récupère ici une matrice [sphere: 1 x n] indictrice de l'appartenance à
  % la sphere de rayon [r] et de centre [p].
  sphere = ml_sqrDist (data, p) < r * r;

  % NOTE À MOI-MÊME: S'agit-il de faire la moyenne des vecteurs ou des indices ?
  % La moyenne des indices me semble stupide, il n'ont pas de sens physique.
  % Mais je ne peux pas m'empêcher de me poser la question.

  % On fait alors la moyenne sur toute la sphere des points à l'intérieur.
  % Pour ça, on filtre sur data les vecteurs concernés par la sphere, puis on
  % en calcule le vecteur moyen.
  data_sphere = data (:, sphere == 1);
  moy = mean (data_sphere, 2);

  % Deux cas se distinguent : Si la distance entre [p] et [moy] est inférieure
  % à [eps = .01], on s'arrête ici. Sinon, on continue en partant du vecteur
  % [moy] qu'on vient de trouver.
  if (norm (moy-p) < .01)
    peak = moy;
  else
    peak = findpeak (data, moy, r);
  endif

endfunction
