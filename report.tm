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

  Je donne un centième du temps obtenu en lançant <verbatim|time octave -q
  benchmark.m>.

  <tabular*|<tformat|<table|<row|<cell|Optimisations>|<cell|Mesure
  1>|<cell|Mesure 2>|<cell|Mesure 3>>|<row|<cell|/>|<cell|18.9817>|<cell|18.8935>|<cell|17.495>>>>>

  \;

  <tabular*|<tformat|<table|<row|<cell|Partie>|<cell|2>|<cell|2.1>|<cell|2.2>>|<row|<cell|Temps
  (s)>|<cell|18.9817>|<cell|>|<cell|>>>>>

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