<TeXmacs|1.0.7.18>

<style|generic>

<\body>
  \;

  \;

  \;

  \;

  \;

  \;

  \;

  Benchmark :

  <\verbatim-code>
    % benchmark.m

    \;

    load two_clusters.mat;

    \;

    for i = 1:100

    \ \ _ = meanshift (data, 2);

    endfor
  </verbatim-code>

  Je le temps en secondes obtenu en lançant <verbatim|time octave -q
  benchmark.m>. Ceci va exécuter <verbatim|100> fois l'algorithme
  <verbatim|meanshift>, et renvoyer le temps que cela a pris.

  <tabular*|<tformat|<table|<row|<cell|Optimisations>|<cell|Mesure
  1>|<cell|Mesure 2>|<cell|Mesure 3>>|<row|<cell|/>|<cell|3m24.752s>|<cell|3m27.032s>|<cell|3m26.376s>>|<row|<cell|Mean>|<cell|3m26.264s>|<cell|3m24.720s>|<cell|3m25.040s>>|<row|<cell|ml_sqrDist>|<cell|1m58.932s>|<cell|1m58.464s>|<cell|1m58.404s>>|<row|<cell|First
  bassin optimization>|<cell|0m12.068s>|<cell|0m12.036s>|<cell|0m12.036s>>|<row|<cell|Second
  bassin optimization, c = 4>|<cell|1m1.224s>|<cell|1m0.440s>|<cell|0m59.892s>>|<row|<cell|Second
  bassin optimization, c = 2>|<cell|0m33.508s>|<cell|0m32.472s>|<cell|0m33.372s<em|>>>|<row|<cell|Second
  bassin optimization, c = 1>|<cell|.>|<cell|.>|<cell|.>>>>>

  \;

  \;

  Pour <verbatim|testdata1.mat>, le bon <verbatim|r> semble être <math|3>.

  \;

  \;
</body>

<\initial>
  <\collection>
    <associate|language|french>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
  </collection>
</references>