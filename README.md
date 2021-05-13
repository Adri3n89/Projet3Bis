# Projet3Bis

* Vue : Affichage de la console - Fonction "print console" des infos à afficher
* Controleur : Récupération des valeurs saisies dans la console et appels des méthodes de ton manager

Reprend :
* les managers existants car l'algo est déjà la. Mututalise les méthodes createPlayers pour en avoir une seule
* la hiérarchisations des fichiers/classes que tu avais
* Garde les delegates sur les controlers

Garde les classes et models que tu avais

### Aide : 
* Créer une classe Character avec deux propriétés : points de vie et points d’attaque. Ajouter une fonction present() afin d’afficher, via la fonction print() les caractéristiques d’un personnage
* Créer une classe Warrior qui va hériter de personnage et qui va modifier les points de vie et les points d’attaque de la classe mère
* Créer une classe Magus qui va hériter de personnage et qui va modifier les points de vie et les points d’attaque de la classe mère
* Enrichir la fonction present() de la classe Character, dans les classes filles Magus et Warrior pour indiquer le type du personnage
* Créer une nouvelle fonction sur la classe Character, qui prend en paramètre un autre Character, et qui va retourner le personnage le plus fort des deux (par exemple, le personnage qui a le plus de points d’attaque, si identique, le personnage qui a le plus de points de vie, si identique, le premier personnage)
* Créer une nouvelle fonction sur la classe Character, appelée actionOn, qui prend en paramètre un autre Character et qui va aller déduire des points de vie de ce personnage, les points d’attaque du personnage qui appelle la fonction. (par exemple, pour A.actionOn(B) : B.lifePoint ayant 10 à la fin de la fonction B aura plus que 5 dans lifePoint si A a 5 points d’attaque)
* Créer une nouvelle classe de type Priest qui hérite de la classe Character et qui va modifier le comportement la fonction actionOn pour ne plus attaquer, mais soigner avec les points d’attaque (par exemple, pour A.actionOn(B) : B.lifePoint ayant 10 à la fin de la fonction B aura 15 dans lifePoint si A a 5 points d’attaque et que A est un prêtre
