/*
////
-- =========================================================================== A
-- Herbivorie_del.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2025-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4 à 17
Responsable : Luc.LAVOIE@USherbrooke.ca
Version : 0.1.1a
Statut : applicable
Résumé : Suppression des données des tables du schéma.
-- =========================================================================== A
*/

/*
-- =========================================================================== B
////

Suppression des données des tables du schéma, à l'exception de celles des
carnets d’observation.

.Notes de mise en oeuvre
a. Aucune.

////
-- =========================================================================== B
*/

set schema 'Herbivorie' ;

DELETE FROM ObsDimension ;
DELETE FROM ObsFloraison ;
DELETE FROM ObsEtat ;
DELETE FROM Plant ;
DELETE FROM Placette ;
DELETE FROM Etat ;
DELETE FROM Taux ;
DELETE FROM Peuplement ;
DELETE FROM Arbre ;

/*
-- =========================================================================== Z
////
.Contributeurs
  (DAL) Diane.Auberson-Lavoie@USherbrooke.ca
  (LL01) Luc.Lavoie@USherbrooke.ca

.Tâches projetées
* 2022-01-30 LL01. Évolution
  - Maintenir le script au fil de l’évolution de Herbivorie_cre.sql

.Tâches réalisées
* 2025-01-26 LL01. Adaptation au standard de programmation de CoFELI.
  - Mise en forme des commentaires externes en AsciiDoc.
* 2017-09-17 LL01. Création
  - Version initiale.

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
-- fin de {CoFELI}/Exemple/Herbivorie/src/Herbivorie_del.sql
-- =========================================================================== Z
*/
