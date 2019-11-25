# training_git
Introduction to git using Rtidytuesday scripts as an example. 


# New Zealand Bird of the Year

This week's data is from the [New Zealand Forest and Bird Orginization](https://www.forestandbird.org.nz/) courtesy of [Dragonfly Data Science](https://www.dragonfly.co.nz/news/2019-11-12-boty.html) by way of [Nathan Moore](https://twitter.com/nmoorenz).

Full details around voting can be found at the [Bird of the Year site](https://www.birdoftheyear.org.nz/voting).

I have uploaded the raw data and the clean data, was a quick `dplyr::pivot_longer()` call!

Full details around voting are below - please note that votes are ranked 1-5 (1 is best, 5 is worst), and the voters do not need to submit all 5 votes.

> This year, voting is based on the instant runoff (IRV) voting system, which is similar to the system you might have seen in local elections. When you vote, you can rank up to five of your favourite birds, with #1 indicating your favourite bird, #2 indicating your second favourite bird, and so on. It’s no problem if you want to vote for less than five birds.

> How the winner is decided

> In the IRV voting system, the first preferences of all the votes cast are tallied in a first round of counting. If no bird has more than half of the votes, new rounds of counting are held until one bird has a majority.

> In each of these rounds the bird with the lowest number of votes is eliminated and the next ranked choice of those who voted for that bird are added to the totals of the remaining birds.

> This process continues until one bird has a majority of votes and is crowned Bird of the Year.


# Data Dictionary

## `nz_bird`

|variable  |class     |description |
|:---------|:---------|:-----------|
|date      | date    | Date of vote (ISO 8601) |
|hour      |double    | Hour of vote (numeric)|
|vote_rank |character | Vote rank, 1-5, where 1 is highest, and 5 is lowest |
|bird_breed |character | Bird breed |


# Phase 1 clonez moi

```
git clone https://github.com/ednaMontpellier/training_git.git
```

# Phase 2 un projet à tour de role

Chacun son tour, vous ajouterez une feature qui vous a été confié parmis celle-ci

* 1) Change barplot colors by the provided palette 
* 2) Change x axis angle
* 3) Add contouring in barblot
* 4) Rename title to be more explicit: "Best ranked bird in New Zealand"
* 5) Add a caption: "Data source: Rtidytuesday' 
* 6) Change theme to classic
* 7) Add the number of observations on top on each bar
* 8) Change the caption font to italic
* 9) Change the order of birds by sorted abundance in x axis
* 10) Change title size to 18

Les codes de base ainsi que la correction complète sont dans le dossier [copy_me](copy_me) donc vous pouvez simplement copier/coller la partie du code source de ces scripts correspondant a votre tache. Le but de ce TP est d'utiliser `git` (pas de passer trop de temps sur la programmation R donc)

## Premier tour

Chacun son tour vous utiliserez les commandes git principales. [feature 1-5]

```
git pull
git add
git commit
git push
```

Ces commandes sont à taper dans le terminal dans le répertoire du dossier git. A noter que Rstudio intègre Git et permet d'effecter ces taches de façon très simple en click-bouton. Il est toutefois important de bien comprendre les actions effectuées par chacune des étapes, qu'elles soient effectuées manuellement ou à travers Rstudio (ou Atom, autre gestionnaire de script intégrant Git)

## Deuxieme tour

On refait un tour pour vérifier que tout le monde a bien compris (en ajoutant une modification). [features 6-10]

# Phase 3 (si on va aussi loin) travail en parallele

Notion de branches. 

```
git branch
git checkout
git add
git commit
git rebase
git checkout
git pull
```

Chaque personne a une feature a programmer sur un script personnel qu'il enregistre sur sa propre branche. Quand tout le monde a terminé de travailler. On merge les branches de chacun.

Encore une fois les solutions sont dans [copy_me](copy_me) ne perdez pas trop de temps à coder en R, le but c'est de pratiquer `git`.

* feature a
* feature b
* ...

## premier tour

Tout le monde programme sa feature sur sa branche en même temps. On tente le merge de la mort à la fin du tour.

## deuxieme tour

On recommence, cette fois ci en demandant des modifications ou de nouvelles features à chaque personne à faire sur une nouvelle branche.