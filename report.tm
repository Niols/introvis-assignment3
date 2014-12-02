<TeXmacs|1.0.7.18>

<style|generic>

<\body>
  <doc-data|<doc-title|Introduction to computer
  vision>|<doc-author|<author-data|<author-name|Nicolas
  Jeannerod>>>|<doc-date|1 décembre 2014>|<doc-subtitle|Mean-shift>>

  \;

  J'ai codé l'algorithme <verbatim|mean-shift> en <verbatim|Octave> (encore
  une fois, je n'ai pas testé la compatibilité <verbatim|Matlab>) selon les
  instructions trouvés dans le <verbatim|.pdf> joint à votre mail.

  Je me suis attaché à faire de nombreuses mesures de l'efficacité en temps
  de l'algorithme.

  \;

  <section|Basic implementation>

  Cette partie était assez facile, puisqu'il n'y avait pas vraiment de
  réflexion à fournir.

  J'ai choisi de coder <verbatim|findpeak> récursivement, et de ne pas y
  mettre de boucle. Je trouvais le code plus propre comme ça. Je ne sais pas
  si l'efficacité est au rendez-vous, il faudrait tester ça. À mon avis, les
  performances doivent être médiocres, car je vois mal <verbatim|Octave>
  faire de l'optimisation de fonctions récursives. Pour la rendre récursive,
  il a fallu lui permettre d'accepter un <verbatim|id> de point <em|ou> un
  point directement. Ce n'est pas très propre, et j'aurais préféré le faire
  avec des arguments optionnels.

  Le codage de <verbatim|meanshift> s'est fait sans encombres, et les
  résultats ont été concluants : sur <verbatim|two_clusters.mat>, je trouve
  des résultats extrêmement proches de ceux de l'énoncé.

  L'état des scripts à ce moment là se trouve dans le dossier <verbatim|1/>.

  \;

  <section|Optimizations>

  J'ai suivi ici l'évolution de l'efficacité de mon script avec de nombreuses
  mesures. Le principe de ces mesures est simplement de lancer <verbatim|100>
  fois l'algorithme sur <verbatim|two_clusters.mat>, pour ne pas prendre en
  considération le temps de chargement d'<verbatim|Octave>, ou des données de
  <verbatim|two_clusters.mat>. J'ai fait ceci de nombreuses fois, et je vous
  met ici les résultats.

  \;

  <big-table|<tabular*|<tformat|<cwith|6|8|1|1|cell-row-span|3>|<cwith|1|-1|1|-1|cell-valign|c>|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|<strong|Optimisations>>|<cell|>|<cell|<strong|Temps
  (s)>>>|<row|<cell|/>|<cell|>|<cell|206.05<htab|5mm>>>|<row|<cell|Mean>|<cell|>|<cell|205.34>>|<row|<cell|ml_sqrDist>|<cell|>|<cell|118.60>>|<row|<cell|First
  bassin optimization>|<cell|>|<cell|12.05>>|<row|<cell|Second bassin
  optimization>|<cell|<math|c=3>>|<cell|60.51>>|<row|<cell|>|<cell|<math|c=2>>|<cell|33.12>>|<row|<cell|>|<cell|<math|c=1>>|<cell|>>>>>|Gain
  de temps des optimisations>

  \;

  Quelques remarques sur ces temps :

  Tout d'abord, je suis content de voir que mon script de la partie
  <verbatim|1/> était déjà assez propre au niveau des boucles, puisque la
  modification du calcul de la moyenne ne me fait presque rien gagner. En
  revanche, le calcul des distances euclidiennes aurait pu être meilleur. Je
  pense en particulier au choix de passer toute la matrice à la racine
  carrée, alors que je pourrais passer au carré le scalaire avec lequel on la
  compare.

  On peut trouver les scripts produits à ce stade dans <verbatim|2.1/>.

  La première optimisation en utilisant les bassins d'abstraction est
  vraiment très efficace. Bien sur, il faut penser à ne pas exécuter la
  boucle <verbatim|for> quand la valeur a déjà été calculée. La deuxième
  optimisation me parait moins efficace, ce qui me laisse à penser que j'ai
  fait une erreur dans son code, ou un mauvais choix. J'ai tout de même
  travaillé pour la suite avec cette optimisation là.

  On peut trouver les scripts produits à ce stade dans <verbatim|2.2/>, et
  dans la racine du dossier.

  \;

  <section|Image segmentation>

  Malgré quelques difficultés à utiliser correctement <verbatim|rgb2luv> et
  <verbatim|luv2rgb>, cette partie s'est revelée assez rapide, le code de la
  fonction <verbatim|segment_meanshift> n'étant qu'une légère surcouche à
  <verbatim|meanshift>.

  Pour les résultats, tous se trouvent dans le dossier <verbatim|results/>.
  Pour les <verbatim|testdata*.mat>, le <verbatim|r> choisi est <verbatim|3>
  (et <verbatim|c> est égal à <verbatim|4> comme demandé), même si ce n'est
  pas forcément très satisfaisant pour le troisième jeu de données.

  Les images produites pas <verbatim|segment_meanshift> se trouvent dans
  <verbatim|results/images/>. Elles sont toutes nommées de la même façon :
  <verbatim|\<less\>nom-original\<gtr\>_r\<less\>r\<gtr\>_c\<less\>c\<gtr\>.png>
  où <verbatim|\<less\>nom-original\<gtr\>> est le nom de l'image avant
  traitement (<verbatim|hat>, <verbatim|man>, <verbatim|sheep>,
  <verbatim|star>), <verbatim|\<less\>r\<gtr\>> est la valeur de
  <verbatim|r>, <verbatim|\<less\>c\<gtr\>> est la valeur de <verbatim|c>.

  <big-table|<tabular*|<tformat|<table|<row|<cell|>|<cell|r>|<cell|5>|<cell|10>|<cell|20>>|<row|<cell|c>|<cell|>|<cell|>|<cell|>|<cell|>>|<row|<cell|1>|<cell|>|<cell|14.180>|<cell|1.788>|<cell|0.612>>|<row|<cell|2>|<cell|>|<cell|102.296>|<cell|18.660>|<cell|3.312>>|<row|<cell|4>|<cell|>|<cell|457.280>|<cell|101.840>|<cell|62.724>>>>>|Temps
  d'exécution de <verbatim|segment_meanshift> sur <verbatim|hat.png>>

  J'ai fait des mesures du temps passé à faire ce calcul en fonction de
  <verbatim|r> et <verbatim|c>. J'affiche ici les résultats pour
  <verbatim|hat.png> et <verbatim|man.png>. On constate que l'action des
  paramètres joue vraiment violemment sur le temps de calcul. Cependant, la
  qualité s'en ressent beaucoup. Pour <verbatim|sheep> par exemple, une
  grande valeur de <verbatim|r> ne laisse même plus apparaitre les moutons
  sur l'image.

  <big-table|<tabular*|<tformat|<table|<row|<cell|>|<cell|r>|<cell|5>|<cell|10>|<cell|20>>|<row|<cell|c>|<cell|>|<cell|>|<cell|>|<cell|>>|<row|<cell|1>|<cell|>|<cell|30.832>|<cell|4.636>|<cell|0.716>>|<row|<cell|2>|<cell|>|<cell|151.928>|<cell|33.068>|<cell|4.348>>|<row|<cell|4>|<cell|>|<cell|477.420>|<cell|151.712>|<cell|19.592>>>>>|Temps
  d'exécution de <verbatim|segment_meanshift> sur <verbatim|man.png>>

  \;

  Voilà. C'était bien, mais c'est fini.
</body>

<\initial>
  <\collection>
    <associate|language|french>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
    <associate|auto-2|<tuple|2|?>>
    <associate|auto-3|<tuple|1|?>>
    <associate|auto-4|<tuple|3|?>>
    <associate|auto-5|<tuple|2|?>>
    <associate|auto-6|<tuple|3|?>>
  </collection>
</references>