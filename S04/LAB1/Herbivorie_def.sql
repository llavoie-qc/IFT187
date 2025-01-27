/*
////
-- =========================================================================== A
-- Herbivorie_def.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2025-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4 à 17
Responsable : Luc.LAVOIE@USherbrooke.ca
Version : 0.1.0b
Statut : applicable
Résumé : Création du schéma Herbivorie pour la collecte des données de terrain du projet Herbivorie.
-- =========================================================================== A
*/

/*
-- =========================================================================== B
////

Création du schéma correspondant devant accueillir le modèle logique proposé
pour la collecte des données de terrain du projet Herbivorie.
L’esquisse initiale du modèle logique est la suivante :

    Etat (etat, description)
      cle {etat};
    Peuplement (peuplement, description)
      cle {peuplement};
    Arbre (arbre, description)
      cle {arbre};
    Taux {tCat, tMin, tMax}
      cle {tCat}
    Placette {placette, peuplement,
      obs_F1, obs_F2, obs_C1, obs_C2, obs_T1, obs_T2,
      graminees, mousses, fougeres,
      arb_P1, arb_P2, arb_P3,
      date, note}
      clé {placette}
      ref {obs_F1} -> Taux {tCat}
      ref {obs_F2} -> Taux {tCat}
      ref {obs_C1} -> Taux {tCat}
      ref {obs_C2} -> Taux {tCat}
      ref {obs_T1} -> Taux {tCat}
      ref {obs_T2} -> Taux {tCat}
      ref {graminees} -> Taux {tCat}
      ref {mousses} -> Taux {tCat}
      ref {fougeres} -> Taux {tCat}
      ref {arb_P1} -> Arbre {arbre}
      ref {arb_P2} -> Arbre {arbre}
      ref {arb_P2} -> Arbre {arbre};
    Plant {id, placette, parcelle, date, note}
      cle {id}
      ref id -> Plant
      ref placette -> Placette;
    Observation {id, largeur, longueur, floraison, etat, date, note}
      clé {id, date}
      ref id -> Plant
      ref etat -> Etat;

.Précisions
 a. Obstruction latérale : prend en compte les obstructions sur une distance de
    10 m, à 1 m et à 2 m de hauteur.
 b. Floraison : vrai ssi le plant porte une fleur (qu'elle soit ouverte ou pas)
    ou un fruit ; permet de déterminer si un plant est (potentiellement)
    reproducteur ou pas.
 c. Une parcelle est une subdivision de la placette, identifiée par une
    lettre suivie d’un chiffre.
 d. Les conventions relatives aux codes (plants, placettes, parcelles, etc.) sont
    celles qui nous ont été communiquées au 2017-09-17.
 e. On présume qu’aucune donnée n’a été consignée antérieurement au 20 décembre 1582,
    ce qui légitime l’usage exclusif du calendrier grégorien.
 f. Pour plus de détails, voir Herbivorie_EPP.pdf

.Notes de mise en oeuvre
 a. Les descriptions ont été arbitrairement limitées à 60 caractères.
 b. Les observations sont décomposées en trois tables afin de permettre un
    meilleur traitement des données manquantes.

////
-- =========================================================================== B
*/

--
-- Définition du schéma
--

drop schema if exists "Herbivorie" cascade ;
create schema "Herbivorie" ;
set schema 'Herbivorie' ;

/*
-- =========================================================================== Z
////
.Contributeurs
  (DAL) Diane.Auberson-Lavoie@USherbrooke.ca
  (LL01) Luc.Lavoie@USherbrooke.ca

.Tâches réalisées
* 2025-01-26 LL01. Adaptation au standard de programmation de CoFELI.
  - Mise en forme des commentaires externes en AsciiDoc.
* 2025-01-26 LL01. Création impérative du schéma avec destruction de l’éventuel schéma pré-existant.
  - En sus, vérification de compatibilité avec les versions 16 et 17.
* 2022-01-23 LL01. Création par extraction de Herbivorie_def
  - Création du schéma de base.
  - Validation minimale du carnet d’observations (voir test0).
  - Importation des observations intègres (voir ini).

.Références
* {CoFELI}/Exemple/Herbivorie/pub/Herbivorie_EPP.pdf

////
.Adresse, droits d’auteur et copyright
  Groupe Metis
  Département d’informatique
  Faculté des sciences
  Université de Sherbrooke
  Sherbrooke (Québec)  J1K 2R1
  Canada
  http://info.usherbrooke.ca/llavoie/
  [CC-BY-NC-4.0 (http://creativecommons.org/licenses/by-nc/4.0)]

-- -----------------------------------------------------------------------------
-- fin de {CoFELI}/Exemple/Herbivorie/src/Herbivorie_def.sql
-- =========================================================================== Z
*/
