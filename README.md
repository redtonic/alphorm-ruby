# Alphorm La Formation Ruby
## Taskman

Vous trouverez ici le projet fil rouge développé durant la formation "Le langage ruby" sur le site [Alphorm](http://alphorm.com)

## Comment télécharger le projet?

Vous pouvez installer git en utilisant cette commande:

Sous ubuntu:

    apt-get install git

Sous mac:

La méthode la plus simple est d'installer le gestionnaire de paquet "homebrew" disponible [ici](http://brew.sh/)

    brew install git

Ensuite, il vous suffit de lancer cette commande:

    git clone git@github.com:redtonic/alphorm-ruby.git

Et voilà! Facile non?

## Téléchargement d'une version spécifique

À la fin de chaque vidéo, j'ai mis en place une version du projet.
Cela vous permet de récupérer le projet à un état initial avant les modifications relatives à la vidéo.

Vous pouvez télécharger une version spécifique en utilisant cette commande:

  git checkout tags/XXX

### Liste des versions:

Pour acceder aux sources d'avant chaque vidéo, utilisez cette commande:

| video | tag | commande|
|-------|:---:|---------|
| Boucles et conditions | 2.1 | git checkout tags/2.1 |
| Les tableaux | 2.2 | git checkout tags/2.2 |
| Les hashes | 2.3 | git checkout tags/2.3 |
| Les fonctions | 2.4 | git checkout tags/2.4 |
| Le fonctionnel | 2.5 | git checkout tags/2.5 |
| Les modules | 2.6 | git checkout tags/2.6 |
| Les classes (I) | 2.7 | git checkout tags/2.7 |
| Les classes (II) | 2.8 | git checkout tags/2.8 |
| Installer et utiliser des gems | 3.1 | git checkout tags/3.1 |
| Éclater le code dans plusieurs fichiers | 3.2 | git checkout tags/3.2 |
| Utilisation du Bundler | 3.3 | git checkout tags/3.3 |
| La réfléxion du langage | 3.4 | git checkout tags/3.4 |
| Les DSL | 3.5 | git checkout tags/3.5 |
| Réouverture de classes et monkey patching | 3.6 | git checkout tags/3.6 |

## Fork du projet

Comme vous le voyez, nous n'avons pas fini notre projet. Tout simplement car mon but était de vous apprendre des nouvelles choses, et de les mettre en pratique une fois pour chaque élément. Le faire pour chaque fonctionnalité du projet n'aurait pas été très drôle (et les vidéos auraient été très longues...).

Donc à vous de jouer! Forkez le projet: Crée un nouveau projet sur github qui hérite de celui-ci, modifiez/améliorez le projet!
Tenez moi au courant en me mailant yacine@redtonic.net, et les meilleures versions verront leur liens ici dans ce Readme!

Idées d'améliorations:
- Utilisez une base de donnée SQLite pour stocker vos taches
- Creer un site web avec [Sinatra](http://www.sinatrarb.com) pour afficher/modifier vos taches.

