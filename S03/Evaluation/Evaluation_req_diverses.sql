/*
-- =========================================================================== A
-- Composant Evaluation_req_diverses.sql
-- -----------------------------------------------------------------------------
Activité : IFT187
Trimestre : 2020-3
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.3 à 14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.1.0e
Statut : en vigueur
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Exemples supplémentaires de requêtes portant sur le schéma Evaluation.
-- =========================================================================== B
*/

-- Quels sont les étudiants qui n’ont aucune évaluation à ce jour ?
-- Étudiants_sans_résutats
SELECT *
FROM Etudiant
WHERE NOT EXISTS
  (
    SELECT 1
    FROM Resultat
    WHERE Etudiant.matricule = Resultat.matricule
  )
;

-- Quelles sont les activités n’ayant aucun étudiant ?
-- Activités-sans-étudiants
SELECT *
FROM activite
WHERE NOT EXISTS
  (
  SELECT 'toto'
  FROM resultat
  WHERE resultat.activite = activite.sigle
  )
;

-- Activités-sans-étudiants (bis)
SELECT activite   -- est-ce ISO ?
FROM activite
WHERE NOT EXISTS
  (
  SELECT 'toto'
  FROM resultat
  WHERE resultat.activite = activite.sigle
  )
;

-- Quels sont les étudiants sans résultats en 2013 ?
-- Étudiants
SELECT *
FROM Etudiant
WHERE NOT EXISTS
  (
  SELECT matricule
  FROM Resultat
  WHERE Etudiant.matricule = Resultat.matricule
    AND NOT (trimestre<'20131' OR '20133'>trimestre)
  )
;

SELECT *
FROM Etudiant
WHERE NOT EXISTS
  (
  SELECT matricule
  FROM Resultat
  WHERE Etudiant.matricule = Resultat.matricule
    AND NOT (trimestre between '20131' and '20133')
  )
;

SELECT *
FROM Etudiant
WHERE NOT EXISTS
  (
  SELECT matricule
  FROM Resultat
  WHERE Etudiant.matricule = Resultat.matricule
    AND (trimestre between '20131' and '20133')
  )
;

select *
from Etudiant
where 60 <= all (select note from Resultat where Etudiant.matricule = Resultat.matricule)
;

select
from resultat
group by matricule
having 60 <= min(note)
;

-- Solution stricte
WITH
  NbA (matricule, nbAct) AS
    (
      SELECT matricule, COUNT(*) AS nbAct
      FROM Resultat
      GROUP BY matricule
      )
SELECT matricule, nom, adresse, COALESCE(nbAct,0) AS nbAct
FROM Etudiant LEFT JOIN NbA USING(matricule)
ORDER BY matricule ;

-- solution compacte, mais est-elle bonne ? Pourquoi ?
SELECT matricule, nom, adresse, COUNT(*) AS nbAct
FROM Etudiant LEFT JOIN Resultat USING(matricule)
GROUP BY matricule
ORDER BY matricule ;

-- solution compacte, mais est-elle bonne ? Pourquoi ?
SELECT matricule, nom, adresse, COUNT(activite) AS nbAct
FROM Etudiant LEFT JOIN Resultat USING(matricule)
GROUP BY matricule
ORDER BY matricule ;

-- solution compacte, mais étonnante ? Pourquoi ?
SELECT matricule, MAX(nom) as nom, MAX(adresse) as adresse, COUNT(activite) AS nbAct
FROM Etudiant LEFT JOIN Resultat USING(matricule)
GROUP BY matricule
ORDER BY matricule ;

-- solution compacte, mais étonnante ? Pourquoi ?
SELECT matricule, nom, adresse, COUNT(activite) AS nbAct
FROM Etudiant LEFT JOIN Resultat USING(matricule)
GROUP BY matricule, nom, adresse
ORDER BY matricule ;


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
2015-08-23 (CK01) : Création
  * Proposition initiale.

Références :
[mod] http://info.usherbrooke.ca/llavoie/enseignement/Modules/
-- -----------------------------------------------------------------------------
-- fin de Evaluation_req_diverses.sql
-- =========================================================================== Z
*/
