/*
////
-- =========================================================================== A
-- Herbivorie_test0.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2025-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4 à 17
Responsable : Luc.LAVOIE@USherbrooke.ca
Version : 0.1.1a
Statut : en cours de développement
Résumé : Test minimaliste d’insertion de données invalides.
-- =========================================================================== A
*/

/*
-- =========================================================================== B
////

Test minimaliste d'insertion de données invalides.

////
-- =========================================================================== B
*/

set schema 'Herbivorie' ;

INSERT INTO Etat VALUES -- état redondant
  ('O', 'vivante');
INSERT INTO Etat VALUES -- état erroné
  ('$', 'vivante');

INSERT INTO Peuplement VALUES -- valeur de l’attribut peup trop courte
  ('ERH', 'érablière à hêtre');
INSERT INTO Peuplement VALUES -- valeur de l’attribut peup trop longue
  ('ERHET', 'érablière à hêtre');
INSERT INTO Peuplement VALUES -- valeur de l’attribut description trop courte
  ('XXSS', '');
INSERT INTO Peuplement VALUES -- valeur de l’attribut description trop longue
  ('XXLL', '123456789012345678901234567890123456789012345678901234567890x');

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
-- fin de {CoFELI}/Exemple/Herbivorie/src/Herbivorie_test0.sql
-- =========================================================================== Z
*/
