/*
////
-- =========================================================================== A
-- Herbivorie_cre.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2025-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4 à 17
Responsable : Luc.LAVOIE@USherbrooke.ca
Version : 0.1.2a
Statut : en cours de développpement
Résumé : Création modèle logique du schéma Herbivorie.
-- =========================================================================== A
*/

/*
-- =========================================================================== B
////

Création du modèle logique correspondant à la collecte de données du projet Herbivorie.

////
-- =========================================================================== B
*/

set schema 'Herbivorie' ;

--
-- Description des placettes
--
CREATE DOMAIN Etat_id
  -- Code identifiant uniquement un état d’un plant.
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{1}');

CREATE DOMAIN Description
  -- Description textuelle consignée par l’observateur.
  -- Permet de décrire les codes utilisés ou d’ajouter un commentaire à une observation.
  -- La longueur maximale est un choix discrétionnaire compatible avec les indications reçues.
  TEXT
  CHECK (CHAR_LENGTH (VALUE) BETWEEN 1 AND 60);

CREATE TABLE Etat
  -- Répertoire des états d’un plant.
  -- PRÉDICAT : L’état d’un plant identifié par "etat" correspond à la description "description".
(
  etat        Etat_id     NOT NULL,
  description Description NOT NULL,
  CONSTRAINT Etat_cc0 PRIMARY KEY (etat)
);

CREATE TABLE Peuplement
  -- Répertoire des types de peuplement végétal d’une parcelle.
(
);


CREATE TABLE Taux
  -- Répertoire des codes de couverture communément appelés «taux».
(
);

CREATE TABLE Arbre
  -- Répertoire des variétés d’arbres.
(
);

CREATE TABLE Placette
  -- Description de la placette
(
);

--
-- Description des plants recensés dans les placettes
--

CREATE TABLE Plant
  -- Répertoire des plants de trille et de leur emplacement.
(
);

CREATE TABLE ObsDimension
  -- Répertoire des observations de dimension de plants de trille.
(
);

CREATE TABLE ObsFloraison
  -- Répertoire des observations de floraison de plants de trille.
(
);

CREATE TABLE ObsEtat
  -- Répertoire des observations d’état de plants de trille.
(
);

/*
-- =========================================================================== Z
////
.Contributeurs
  (DAL) Diane.Auberson-Lavoie@USherbrooke.ca
  (LL01) Luc.Lavoie@USherbrooke.ca

.Tâches projetées
* 2022-01-23 LL01. Compléter le schéma
  - Décomposer et temporaliser les observations relatives aux placettes
    (obstruction latérale, couverture au sol, espèces dominantes, etc.).
* 2017-09-19 LL01. Compléter le schéma
  - Compléter les contraintes, en particulier :
    *** la date d’observation d’un plan ne peut être antérieure à son identification ;
    *** la date d’identification d’un plant ne peut être antérieure à celui de sa placette ;
    *** les obstructions latérales observées d’une placette doivent être cohérentes ;
    *** les couvertures au sol observées d’une placette doivent être cohérentes.
* 2017-09-18 LL01. Renommer plus rigoureusement les concepts utilisés par le schéma
  - Plusieurs identificateurs sont inappropriés en regard des concepts véhiculés.
  - Certaines abréviations prêtent à confusion.
  - La constitution d’un dictionnaire de données et l’utilisation d’une terminologie
    rigoureuse sont fortement recommandées.
  - Entre autres exemples : obs -> obstruction latérale, taux -> pourcentage,
    arb -> variété d’arbres, peup, plac, etc.

.Tâches réalisées
* 2025-01-26 LL01. Adaptation au standard de programmation de CoFELI.
  - Mise en forme des commentaires externes en AsciiDoc.
* 2022-01-23 LL01. Épurer le schéma.
  - Déplacer les commentaires généraux dans Herbivorie_def.
  - Déplacer le carnet dans Herbi-ELT_def.
  - Remplacer les textes statiques (CHAR) par des textes dynamiques (TEXT).
  - Adapter les contraintes en conséquence.
  - Compléter certains prédicats.
  - Enrichir certains commentaires.
  - Capitaliser les types prédéfinis.
  - Corriger diverses coquilles.
* 2017-09-20 LL01. Compléter le schéma.
  - Décomposer Placette afin de permettre l’annulabilité de certaines colonnes.
  - Ne mettre que des attributs TEXT dans Carnet et parfaire les validations.
  - Introduire la table Arbre et les clés référentielles appropriées.
* 2017-09-17 LL01. Création
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
-- fin de {CoFELI}/Exemple/Herbivorie/src/Herbivorie_cre.sql
-- =========================================================================== Z
*/
