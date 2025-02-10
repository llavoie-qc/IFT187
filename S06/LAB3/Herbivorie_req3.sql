/*
///
-- =========================================================================== A
-- Herbivorie_req3.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2025-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4 à 17
Responsable : Luc.LAVOIE@USherbrooke.ca
Version : 0.2.0c
Statut : solutionnaire préliminaire
Résumé : Groupe de requêtes applicables au schéma Herbivorie.
-- =========================================================================== A
*/

/*
-- =========================================================================== B
////
Quelques requêtes de groupement, de quantification et d'ordonnancement.

Notes de mise en oeuvre
(a) aucune.
///
-- =========================================================================== B
*/

--
-- Spécification du schéma
--
SET SCHEMA 'Herbivorie' ;

-- X01.
-- Calculer le nombre de plants par placette.
-- Donner le peuplement et l’identifiant de la placette puis le nombre de plants.
-- Trier selon le peuplement, puis l’identifiant.
-- -- v1
WITH N as (
    SELECT placette, count (*) AS nombre_de_plants
    FROM Plant
    GROUP BY placette
    )
SELECT peup, placette, nombre_de_plants
FROM N JOIN Placette ON (placette = plac)
ORDER BY peup, placette
;
-- -- v2
SELECT peup, placette, count (*) AS nombre_de_plants
FROM Plant JOIN Placette ON (placette = plac)
GROUP BY placette, peup
ORDER BY peup, placette
;
-- -- v3
SELECT MAX(peup), placette, count (*) AS nombre_de_plants
FROM Plant JOIN Placette ON (placette = plac)
GROUP BY placette
ORDER BY MAX(peup), placette
;


-- X02.
-- Sur la base de la date d’observation, calculer le tableau du nombre d’observations par mois.
-- Présenter le résultat de façon appropriée.


-- X03.
-- Quel est le mois comportant le plus d’observations ?
-- Présenter le résultat de façon appropriée.


-- X04.
-- Quels sont les plants dont l’état n’a jamais été observé ?
-- Présenter le résultat de façon appropriée.


-- X05.
-- Quels sont les plants ayant plus de trois observations de dimension et dont
-- la largeur est toujours plus grande que la longueur ?
-- Présenter le résultat de façon appropriée.


-- X06.
-- Quelles sont les parcelles (d’une placette) dont tous les plants ont été observés trois fois ?
-- Présenter le résultat de façon appropriée.


-- X07.
-- Déterminer les plants dont le nombre d’observations est supérieur à un écart-type
-- au-dessus de la moyenne du nombre d’observations par plant.
-- Présenter le résultat de façon appropriée.


-- X08.
-- Quelles sont les trois paires de parcelles dont le nombre de fleurs est le plus proche ?
-- Pour chacune des paires, donner les deux dénombrements.
-- Présenter le résultat de façon appropriée.


/*
-- =========================================================================== Z
////
.Contributeurs :
  (CK01) Christina.Khnaisser@USherbrooke.ca
  (LL01) Luc.Lavoie@USherbrooke.ca

.Tâches projetées :
* ...

.Tâches réalisées :
* 2025-02-05 LL01. Revue sommaire
  - Coquilles et ponctuation.
* 2017-09-24 LL01. Création
  - Version initiale.

.Références
* [EPP] {CoFELI}/Exemple/Herbivorie/pub/Herbivorie_EPP.pdf
* [SML] {CoFELI}/Exemple/Herbivorie/pub/Herbivorie_SML.pdf

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
-- fin de {CoFELI}/Exemple/Herbivorie/src/Herbivorie_req3.sql
-- =========================================================================== Z
*/
