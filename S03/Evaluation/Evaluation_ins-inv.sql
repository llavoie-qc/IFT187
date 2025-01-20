/*
-- =========================================================================== A
-- Composant Evaluation_ins-inv.sql
-- -----------------------------------------------------------------------------
Activité : IFT187
Trimestre : 2020-3
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4 à 14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.1.0e
Statut : en vigueur
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Exemples de données INVALIDES pour le schéma Evaluation.

Pour plus d’information, voir Evaluation_cre.sql et le module BD012 [mod].
-- =========================================================================== B
*/

--
-- TypeEvaluation : données INVALIDES
--
INSERT INTO TypeEvaluation VALUES
  ('tev', 'trois lettres - ECHEC ATTENDU');
INSERT INTO TypeEvaluation VALUES
  ('i8', 'chiffres refusés - ECHEC ATTENDU');

--
-- Activite : données INVALIDES
--
INSERT INTO Activite VALUES
    ('IG8401', 'Gestion de projets - sigle mal formé');
INSERT INTO Activite VALUES
    ('GMQ1N3', 'Géopositionnement - sigle mal formé');

--
-- Etudiant : données INVALIDES
--
INSERT INTO Etudiant VALUES
    ('A0132', 'Sergeï', 'Chandler - matricule mal formé');
INSERT INTO Etudiant VALUES
    ('10132', 'Paul', 'Montréal - matricule mal formé');

--
-- Inscription : données INVALIDES
--
INSERT INTO Inscription VALUES
    ('15113879', 'IFT159', '20123');            -- matricule/étudiant inconnu
INSERT INTO Inscription VALUES
    ('15113870', 'IFT163', '20123');            -- sigle/activité inconnue
INSERT INTO Inscription VALUES
    ('15113870', 'IFT159', '19003');            -- année antérieure au minimum
INSERT INTO Inscription VALUES
    ('15113870', 'IFT159', '20124');            -- il n'y a pas de 4e trimestre

--
-- Resultat : données INVALIDES
--
INSERT INTO Resultat VALUES
    ('15113150', 'GMQ103', '20123', 'FI', 52); -- étudiant non inscrit à l’activité
INSERT INTO Resultat VALUES
    ('15112354', 'GMQ103', '20133', 'FI', 52); -- étudiant non inscrit à l’activité à ce trimestre
INSERT INTO Resultat VALUES
    ('15113150', 'IFT159', '20133', 'XX', 52); -- type d’évaluation inconnu
INSERT INTO Resultat VALUES
    ('15113150', 'IFT159', '20133', 'FI', 101); -- note au-delà de 100
INSERT INTO Resultat VALUES
    ('15113150', 'IFT159', '20133', 'FI', -1); -- note en-deçà de 0

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
  [CC BY-4.0 (http://creativecommons.org/licenses/by/4.0)]

Tâches projetées :
NIL

Tâches réalisées :
2013-09-03 (LL01) : Création de cas de tests minimaux
  * un test par contrainte

Références :
[mod] http://info.usherbrooke.ca/llavoie/enseignement/Modules/

-- -----------------------------------------------------------------------------
-- fin de Evaluation_ins-inv.sql
-- =========================================================================== Z
*/
