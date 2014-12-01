%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                           Programming assignment 3                           %
%                             segment_meanshift.m                              %
%                                                                              %
%                             by Nicolas Jeannerod                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% I: m x n x 3
% Une image RGB.

% r
% Le rayon de la sphere pour le meanshift.

% c
% L'attraction pour le meanshift.

% segIm: m x n
% Les labels des différents clusters.

% peakIm: m x n x 3
% Une image RGB représentant les couleurs de pics.

function [segIm, peakIm] = segment_meanshift (I, r, c)
	 
  % On récupère la taille de l'image, pour pouvoir reshape à la fin.
  [m n _] = size (I);

  % On préfère travailler sur des vecteurs que sur des images. Et pour
  % utiliser les distances euclidiennes, on travaille dans l'espace de Luv.
  I_rs = reshape (I, [], 3)';
  I_luv = rgb2luv (I_rs);

  % On utilise meanshift sur les données qu'on vient de recevoir
  [labels, peaks] = meanshift_opt (I_luv, r, c);
  
  % On reshape les labels pour obtenir segIm.
  segIm = reshape (labels, m, n);

  % On remplace les labels par les couleurs des pics.
  peaks_rgb = luv2rgb (peaks);
  peaks_rs = [ peaks_rgb(1,:)(labels) ;
	       peaks_rgb(2,:)(labels) ;
	       peaks_rgb(3,:)(labels) ];

  % On rashape le résultat pour obtenir peakIm.
  peakIm = reshape (peaks_rs', m, n, 3);

endfunction
