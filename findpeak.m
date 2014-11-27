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

% r: 1 x 1
% Le rayon de la sphere.

% peak: d x 1
% Le pic trouvé.

function peak = findpeak (data, idx, r)

  % On récupère les dimensions du problème : [d] la dimension de l'espace et [n]
  % le nombre de points.
  [d n] = size (data);

  % On récupère le point concerné.
  % C'est le centre de la sphère.
  p = data (:, idx);

  % On écrit la condition d'appartenance à la sphere
  % Il s'agit de dire que la distance entre [p] et le point est inférieur à [r].
  % On récupère ici une matrice [sphere: 1 x n] indictrice de l'appartenance à
  % la sphere de rayon [r] et de centre [p].
  rel = data - repmat (p, 1, n);
  sphere = sqrt (sum (rel .^ 2)) < r;

  % NOTE À MOI-MÊME: S'agit-il de faire la moyenne des vecteurs ou des indices ?
  % La moyenne des indices me semble stupide, il n'ont pas de sens physique.
  % Mais je ne peux pas m'empêcher de me poser la question.

  % On fait alors la moyenne sur toute la sphere des points à l'intérieur.
  % Pour ça, on filtre sur data les vecteurs concernés par la sphere, puis on
  % en calcule le vecteur moyen.
  n_sphere = sum (sphere);
  data_sphere = data .* repmat (sphere, d, 1);
  moy = sum (data_sphere')' / n_sphere;

  % On cherche le vecteur le plus proche du vecteur moyen trouvé.
  rel = data - repmat (moy, 1, n);
  [_, i] = min (sqrt (sum (rel .^ 2)));
  v = data (:, i);

  % Deux cas se distinguent : Si la distance entre [p] et [v], le vecteur qu'on
  % vient de trouver est inférieure à [eps = .1], on s'arrête ici. Sinon, on
  % continue en partant du vecteur [v] qu'on vient de trouver.
  if (norm (v-p) < .1)
    peak = v;
  else
    peak = findpeak (data, i, r);
  endif

endfunction
