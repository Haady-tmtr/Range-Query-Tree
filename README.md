# Range-Query-Tree
Projet L2S4 du module de programmation fonctionnelle en Ocaml.

Réalisé en groupe :

THEAULT Thomas

NICOLESSI Nathan

TIEMTORE Mohamed Haady


##

Se référer au README.md dans le dossier squelette pour les commandes à utiliser pour un éventuel test.

## Description

L’objectif de ce projet est de concevoir une structure de données représentant un tableau de n
entiers sous forme d’arbre binaire et permettant de répondre efficacement à une requête donnée sur ce tableau,
comme par exemple calculer la somme contenue dans un sous-tableau, la plus grande somme contenue dans un
sous-tableau ou encore connaître le nombre de zéros dans un sous-tableau.

Dans l’arbre binaire, chaque nœud correspond à un intervalle du tableau et stocke une information permettant
de répondre facilement à une requête donnée. Ces informations peuvent être de diverses formes mais auront
toujours le point commun suivant : les nœuds contiendront dans tous les cas la valeur des bornes
gauche et droite des intervalles qu’ils représentent. La racine correspond ainsi à l’intervalle [0 . . . n − 1]
du tableau et les feuilles aux intervalles [i . . . i] pour 0 ⩽ i ⩽ n − 1. L’arbre est ensuite construit récursivement
en combinant les valeurs des deux nœuds enfants pour obtenir le nœud parent.
