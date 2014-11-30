%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                           Programming assignment 3                           %
%                                 meanshift.m                                  %
%                                                                              %
%                             by Nicolas Jeannerod                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% data: d x n
% n vecteurs colonne de dimensions d.

% r
% Le rayon de la d-sphere.

% labels: 1 x n
% Pour chaque vecteur de l'entrée [data], l'indice du pic correspondant.

% peaks: d x k
% Les k différents pics trouvés. Ce sont des vecteurs de taille d.

function [labels, peaks] = meanshift (data, r)

  % On récupère les dimensions du problème.
  [d n] = size (data);
  
  % On initialise [labels] et [peaks].
  % Un label non-attribué est égal à 0. Un label attribué se trouve entre 1 et
  % [k], avec [k] le nombre de lignes de [peaks].
  labels = zeros (1, n);
  peaks = [];
  k = 0;

  for idx = 1:n
      
    % On trouve le pic correspondant à idx.
    peak = findpeak (data, idx, r);

    % Il y a un petit cas particulier quand c'est le premier pic. On ne
    % recherche pas dans les pics déjà existants dans ce cas, et on enregistre
    % tout de suite la valeur.
    if (k == 0)

       k = 1;
       labels (idx) = k; % ou labels (1) = 1
       peaks = [peaks peak]; % ou peaks = [peak]

    else
	
      % On cherche le pic le plus proche dans les peaks déjà existants :
      [_, i] = min (ml_sqrDist (peaks, peak));
      v = peaks (:, i);
      
      % S'il est proche, on garde celui là. Sinon, on ajoute le nouveau.
      if (norm (v-peak) < r/2)
	labels (idx) = i;
      else
	k = k + 1;
	labels (idx) = k;
	peaks = [peaks peak];
      endif

    endif

  endfor

endfunction
