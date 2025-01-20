/*
-- =========================================================================== A
-- Composant Evaluation_cre.sql
-- -----------------------------------------------------------------------------
Activité : IFT187
Trimestre : 2020-3
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4 à 15
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.2.5e
Statut : en vigueur
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Création du schéma correspondant au modèle de consignation des résultats
d’évaluation des activités pédagogiques de l’Université de Samarcande (UdeS).

Ce modèle décrit est présenté dans BD012 [mod]; il est esquissé ci-après.

Contexte
L’Université de Samarcande (UdeS), fondée en 1927, propose différentes activités
pédagogiques dans plusieurs domaines. Depuis deux ans, le nombre de personnes
étudiantes ne cesse d’augmenter. Afin de mieux répondre à leurs besoins, il est
nécessaire de pouvoir ajuster l’offre de formation aux parcours effectifs de
formation.

Problème
Développer un système (informatisé) permettant de
  * constituer un répertoire des activités proposées ;
  * consigner les admissions à l’UdeS ;
  * consigner les inscriptions aux activités ;
  * consigner les résultats des évaluations (notes) par étudiant, par activité
    et par type d’évaluation.

Vocabulaire et règles applicables
Activité
  * L’UdeS définit une activité; dès lors, elle peut être offerte.
  * L’activité est identifiée par un sigle et caractérisée par un titre.
  * Une activité comporte des évaluations.
Étudiant
  * L’étudiant est identifié par un matricule et caractérisé par un nom et une adresse
    au moment de son admission.
  * Dès lors que l’UdeS admet un étudiant, celui-ci peut s’inscrire à des activités,
    y participer et se présenter aux évaluations de ces activités.
Type d’évaluation
  * L’UdeS autorise un type d’évaluation (TE); dès lors, une activité peut comporter
    une évaluation de ce type.
  * Un TE est identifié par un code et caractérisé par une description.
Inscription
  * Une note est obtenue par un étudiant dans le cadre d’une activité à laquelle il
    est inscrit lors d’une évaluation au cours d’un trimestre.
Résultat
  * Un résultat est identifié par le matricule de l’étudiant, le sigle de l’activité,
    le trimestre et le code de TE; il est caractérisé par une note.

Notes de mise en oeuvre
(a) La relvar Inscription a été ajoutée et le schéma modifié en conséquence
    suite au retour d’analyse des modules TMR_01-Fondements_TD-Evaluation et
    SQL_00-Introduction.
(b) La présente version du composant est issue de quatre itérations
    (_i0, ..., _i3).

Les colles du prof
(a) Comparer les prédicats utilisés dans TMR_01-Fondements_TD-Evaluation avec ceux utilisés ici.
    Décrire la portée de la différence, indiquer la « meilleure » formulation
    et motiver le choix.
(b) Modifier le composant afin de ne permettre que les seuls trimestres
    durant lesquels il y a effectivement eu dispensation de l’enseignement.
    En effet, l’UdeS a notamment du suspendre ses activités lors des grandes
    épidémies et lors des guerres.
-- =========================================================================== B
*/
CREATE DOMAIN SigleCours
  -- Un sigle de cours est composé de trois lettres majuscules suivies de trois chiffres.
  TEXT
  CHECK
  (
    VALUE SIMILAR TO '[A-Z]{3}[0-9]{3}'
  )
;

CREATE DOMAIN Matricule
  -- Un matricule est composé d’exactement huit chiffres.
  TEXT
  CHECK
  (
    VALUE SIMILAR TO '[0-9]{8}'
  )
;

CREATE DOMAIN TypeEval
  -- Un code de type d’évaluation est composé d’exactement deux lettres.
  TEXT
  CHECK
  (
    VALUE SIMILAR TO '[A-Za-z]{2}'
  )
;

CREATE DOMAIN Note
  -- Une note est un entier compris entre 0 et 100 inclusivement.
  SMALLINT
  CHECK (VALUE BETWEEN 0 AND 100)
;

CREATE DOMAIN Trimestre
  -- Les trimestres sont encodés en suffixant le chiffre du trimestre à
  -- une année postérieure à 1927 (année de fondation de l’UdeS).
  -- Chiffre associé au trimestre : hiver -> 1, été -> 2, automne -> 3.
  TEXT
  CHECK
  (
    (VALUE SIMILAR TO '[0-9]{4}[1-3]{1}')
    AND
    (SUBSTR(VALUE, 1, 4) > '1927')
  )
;

CREATE TABLE Activite
  -- L’activité identifiée par le sigle «sigle», décrite par le titre «titre»,
  -- est offerte par l’UdeS.
(
  sigle      SigleCours  NOT NULL,
  titre      Text        NOT NULL,
  CONSTRAINT Activite_cc0 PRIMARY KEY (sigle)
)
;

CREATE TABLE Etudiant
  -- L’étudiant identifié par le matricule «matricule», décrit par le nom est «nom» et
  -- l’adresse est «adresse» est admis à l’UdeS.
(
  matricule  Matricule   NOT NULL,
  nom        Text        NOT NULL,
  adresse    Text        NOT NULL,
  CONSTRAINT Etudiant_cc0 PRIMARY KEY (matricule)
)
;

CREATE TABLE Inscription
  -- L’étudiant dont le matricule est «matricule» est inscrit à l’activité «activite»
  -- au trimestre «trimestre» à l’UdeS.
(
  matricule  Matricule  NOT NULL,
  activite   SigleCours NOT NULL,
  trimestre  Trimestre  NOT NULL,
  CONSTRAINT Inscription_cc0 PRIMARY KEY (matricule, activite, trimestre),
  CONSTRAINT Inscription_cr0 FOREIGN KEY (matricule) REFERENCES Etudiant (matricule),
  CONSTRAINT Inscription_cr1 FOREIGN KEY (activite) REFERENCES Activite (sigle)
)
;

CREATE TABLE TypeEvaluation
  -- Le type d’évaluation identifié par le code «code», décrit par la description
  -- «description» est autorisé à l’UdeS.
(
  code        TypeEval    NOT NULL,
  description Text        NOT NULL,
  CONSTRAINT TypeEvaluation_cc0 PRIMARY KEY (code)
)
;

CREATE TABLE Resultat
  -- Le résultat «note» a été obtenu par l’étudiant identifié par le matricule
  -- est «matricule» lors de l’évaluation «TE» dans le cadre de l’activité «activite»
  -- au trimestre «trimestre».
(
  matricule  Matricule  NOT NULL,
  activite   SigleCours NOT NULL,
  trimestre  Trimestre  NOT NULL,
  TE         TypeEval   NOT NULL,
  note       Note       NOT NULL,
  CONSTRAINT Resultat_cc0 PRIMARY KEY (matricule, activite, trimestre, TE),
  CONSTRAINT Resultat_cr0 FOREIGN KEY (matricule, activite, trimestre) REFERENCES Inscription,
  CONSTRAINT Resultat_cr1 FOREIGN KEY (TE) REFERENCES TypeEvaluation (code)
)
;

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
2018-08-29 (LL01) : Compléter le schéma
  * Renforcer le typage.

Tâches réalisées :
2022-11-14 (LL01) : Retrait des références à Oracle.
  * Oracle n’offrant pas la possibilité de définir de domaines, la mention
    de sa syntaxe non conforme pour les expressions régulières n’est plus
    d'actualité.
2022-05-14 (LL01) : Harmonisation avec TRM_01_TD et SQL_00_Aperçu.
  * utilisation du type Text et ordonnancement des définitions.
2021-10-24 (LL01) : Harmonisation avec BD012 et BD100
  * utilisation du type Text et ordonnancement des définitions.
2020-09-10 (LL01) : Intégration de la documentation du contexte et du problème.
  * en conséquence, correction du vocabulaire et des prédicats.
2018-09-23 (LL01) : Harmonisation.
  * intégration des types SigleCours, Matricule, TypeEval, Note, Trimestre.
  * avec la version 0.3.0 du standard BD190 (voir [mod]).
2018-01-23 (CK01) : Harmonisation.
  * avec la version 0.2.2 du standard BD190 (voir [mod]).
2015-08-28 (LL01) : Reformulation des prédicats.
  * séparation du prédicat en deux parties : règle métier et entête.
2015-08-28 (CK01) : Harmonisation.
  * avec les modules BD012 et BD100 (voir [mod]);
  * avec la version 0.2.0 du standard BD190 (voir [mod]).
2013-09-03 (LL01) : Création
  * CREATE TABLE Activite, TypeEvaluation, Etudiant, Resultat.

Références :
[mod] http://info.usherbrooke.ca/llavoie/enseignement/Modules/
-- -----------------------------------------------------------------------------
-- Fin de Evaluation_cre.sql
-- =========================================================================== Z
*/
