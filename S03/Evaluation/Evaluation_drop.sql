/*
-- =========================================================================== A
-- Composant Evaluation_drop.sql
-- -----------------------------------------------------------------------------
Activité : IFT187
Trimestre : 2020-3
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4 à 14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.1.1e
Statut : en vigueur
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Suppression des tables du schéma correspondant au modèle de consignation des résultats
d’évaluation des activités pédagogiques de l’Université de Samarcande (UdeS).

Pour plus d’information, voir Evaluation_cre.sql

Notes de mise en oeuvre
(a) aucune.
-- =========================================================================== B
*/

DROP TABLE Activite CASCADE ;
DROP TABLE Etudiant CASCADE ;
DROP TABLE Inscription CASCADE ;
DROP TABLE TypeEvaluation CASCADE ;
DROP TABLE Resultat CASCADE ;

DROP DOMAIN SigleCours ;
DROP DOMAIN Matricule ;
DROP DOMAIN TypeEval ;
DROP DOMAIN Note ;
DROP DOMAIN Trimestre ;

  /*
-- =========================================================================== Z
Contributeurs :
  (CK01) Christina.Khnaisser@USherbrooke.ca,
  (LL01) Luc.Lavoie@USherbrooke.ca

Adresse, droits d’auteur et copyright :
  Groupe Metis
  Département d’informatique
  Faculté des sciences
  Université de Sherbrooke
  Sherbrooke (Québec)  J1K 2R1
  Canada
  http://info.usherbrooke.ca/llavoie/
  [CC-BY-NC-4.0 (http://creativecommons.org/licenses/by-nc/4.0)]

Tâches projetées :
NIL

Tâches réalisées :
2020-09-10 (LL01) : Suppression
  * DROP TABLE Inscription.
2018-09-01 (LL01) : Suppression
  * DROP DOMAIN SiglecCours, Matricule, TypeEval, Note, Trimestre.
2013-09-03 (LL01) : Suppression
  * DROP TABLE Activite, TypeEvaluation, Etudiant, Resultat.

Références :
[mod] http://info.usherbrooke.ca/llavoie/enseignement/Modules/
-- -----------------------------------------------------------------------------
-- fin de Evaluation_drop.sql
-- =========================================================================== Z
*/
