%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                           Programming assignment 3                           %
%                                findpeak_opt.m                                %
%                                                                              %
%                             by Nicolas Jeannerod                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% data: d x n
% n vecteurs colonne de dimension d, les points sur lesquels ont cherche.

% idx
% L'indice du point pour lequel on veut trouver le pic voisin. Pour des raisons
% de simplicité du code, un argument de taille d x 1 peut être accepté, auquel
% cas, c'est le point lui même, et il remplace data (:, idx).

% r
% Le rayon de la sphere.

% c
% Le paramètre de boost de la vitesse de l'algorithme, qui ajoute tous les
% points à moins de r/c d'une moyenne à cpts.

% peak: d x 1
% Le pic trouvé.

% cpts: 1 x n
% Les points à lier directement au pic

function [peak, cpts] = findpeak_opt (data, idx, r, c)

  % On récupère les dimensions du problème : [d] la dimension de l'espace et [n]
  % le nombre de points.
  [d n] = size (data);

  % On récupère le point concerné. On teste pour ça si c'est un point, ou juste
  % un id. Si c'est un id, il faut aussi initialiser cpts à un vecteur de 0.
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
    % On ajoute tous les points à distance < r du pic trouvé. (vecteur *ligne*)
    cpts = (ml_sqrDist (data, moy) < r * r)';
  else
    [peak, cpts] = findpeak_opt (data, moy, r, c);
    % On ajoute tous les points à distance < r / c de la moyenne trouvée.
    cpts = (cpts + (ml_sqrDist (data, moy) < ((r*r)/(c*c)))') > 0;
  endif

endfunction
