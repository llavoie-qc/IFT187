/*
-- =========================================================================== A
-- Composant Evaluation_ins-val.sql
-- -----------------------------------------------------------------------------
Activité : IFT187
Trimestre : 2018-3
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.3 à 14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.1.0e
Statut : en vigueur
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Exemples de données valides pour le schéma correspondant  au modèle de consignation des résultats
d’évaluation des activités pédagogiques de l’Université de Samarcande (UdeS).

Pour plus d’information, voir Evaluation_cre.sql et le module BD012 [mod].

Les colles du prof
(a) Une des directives de BD190 n'a pas été suivie. Laquelle ? Quelle peut en
    être la conséquence ?
-- =========================================================================== B
*/

--
-- Activite : données valides
--
INSERT INTO Activite VALUES
  ('IFT159', 'Analyse et programmation');
INSERT INTO Activite VALUES
  ('IFT187', 'Éléments de bases de données');
INSERT INTO Activite VALUES
  ('IMN117', 'Acquisition des médias numériques');
INSERT INTO Activite VALUES
  ('IGE401', 'Gestion de projets');
INSERT INTO Activite VALUES
  ('GMQ103', 'Géopositionnement');

--
-- Etudiant : données invalides
--
INSERT INTO Etudiant VALUES
  ('15113150', 'Paul', 'ᐳᕕᕐᓂᑐᖅ');
INSERT INTO Etudiant VALUES
  ('15112354', 'Éliane', 'Blanc-Sablon');
INSERT INTO Etudiant VALUES
  ('15113870', 'Mohamed', 'Tadoussac');
INSERT INTO Etudiant VALUES
  ('15110132', 'Sergeï', 'Chandler');

--
-- Inscription : données valides
--
INSERT INTO Inscription VALUES
  ('15113150', 'IFT187', '20133');
INSERT INTO Inscription VALUES
  ('15112354', 'IFT187', '20123');
INSERT INTO Inscription VALUES
  ('15113150', 'IFT159', '20133');
INSERT INTO Inscription VALUES
  ('15112354', 'GMQ103', '20123');
INSERT INTO Inscription VALUES
  ('15110132', 'IMN117', '20123');
INSERT INTO Inscription VALUES
  ('15110132', 'IFT187', '20133');
INSERT INTO Inscription VALUES
  ('15112354', 'IFT159', '20123');
INSERT INTO Inscription VALUES
  ('15110132', 'IFT159', '20133');

--
-- TypeEvaluation : données valides
--
INSERT INTO TypeEvaluation VALUES
  ('FI', 'Examen final');
INSERT INTO TypeEvaluation VALUES
  ('IN', 'Examen intra');
INSERT INTO TypeEvaluation VALUES
  ('TP', 'Travail pratique');
INSERT INTO TypeEvaluation VALUES
  ('PR', 'Projet');

--
-- Resultat : données valides
--
INSERT INTO Resultat
  (matricule, activite, trimestre, TE, note)
VALUES
  ('15113150', 'IFT187', '20133', 'TP', 80);

INSERT INTO Resultat
  (matricule, activite, trimestre, TE, note)
VALUES
  ('15112354', 'IFT187', '20123', 'FI', 78),
  ('15113150', 'IFT159', '20133', 'TP', 75),
  ('15112354', 'GMQ103', '20123', 'FI', 85),
  ('15110132', 'IMN117', '20123', 'IN', 90),
  ('15110132', 'IFT187', '20133', 'IN', 45),
  ('15112354', 'IFT159', '20123', 'FI', 52);

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
  [CC BY-4.0 (http://creativecommons.org/licenses/by-/4.0)]

Tâches projetées :
NIL

Tâches réalisées :
2013-09-03 (LL01) : Initialisation
  * Insertion des données de l’exemple fourni dans BD012.

Références :
[mod] http://info.usherbrooke.ca/llavoie/enseignement/Modules/
-- -----------------------------------------------------------------------------
-- fin de Evaluation_ins-val.sql
-- =========================================================================== Z
*/
