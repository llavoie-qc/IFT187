/*
-- =========================================================================== A
-- Composant Evaluation_req.sql
-- -----------------------------------------------------------------------------
Activité : IFT187
Trimestre : 2025-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.3 à 17
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.2.1e
Statut : en vigueur
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Exemples de requêtes portant sur le schéma Evaluation.
Pour plus d’information, voir Evaluation_cre.sql et le module BD100 [mod].
-- =========================================================================== B
*/

--
-- R1 Quels sont les étudiants inscrits en IFT187?
-- (Inscription σ (activité=‘IFT187’)) π {matricule}
SELECT matricule
FROM Inscription
WHERE activite = 'IFT187'
;

--
-- R2 Quels sont les étudiants inscrits à une activité d’informatique à l’automne 2013?
-- (Inscription σ (préfixe(activité,3)=‘IFT’) ⋀ trimestre='20133') π {matricule}
SELECT DISTINCT matricule
FROM Inscription
WHERE SUBSTRING(activite, 1, 3)='IFT'
  AND trimestre = '20133'
;

--
-- R3 Quels étaient les étudiants en situation d’échec au final à l’automne 2012?
-- (Résultat σ (note<60 ⋀ TE=‘FI’ ⋀ trimestre='20123')) π {matricule}
SELECT matricule
FROM Resultat
WHERE note < 60
  AND TE = 'FI'
  AND trimestre = '20123'
;

--
-- R4 - Produire une relevé de notes
-- version 3 sur la base du matricule (ici, 15112354)
-- (((Résultat σ (matricule='15112354'))
--     ρ {activité -> sigle}) ⋈  Activité) π {TE, sigle, titre, trimestre, note}
WITH
  R AS
    (SELECT * FROM Resultat WHERE matricule = '15112354')
  SELECT TE, sigle, titre, trimestre, note
  FROM R JOIN Activite ON (activite = sigle)
;

--
-- R5 Quels étudiants ne sont inscrits à aucune activité en 2013 ?
-- version 1
WITH
  Inscrit2013 AS --  (Résultat σ ('20131'≤trimestre≤'20133')) π {matricule}
  (
    SELECT matricule
    FROM Resultat
    WHERE trimestre BETWEEN '20131' AND '20133'
  ),
  NonInscrit2013 AS -- Étudiant – (Étudiant ⋈ Inscrits2013) π {matricule}
  (
    SELECT *
    FROM Etudiant
    EXCEPT
    SELECT *
    FROM Etudiant JOIN Inscrit2013 USING (matricule)
  )
  SELECT *
  FROM NonInscrit2013
;

--
-- R5 version 1.1
-- Étudiant – (Étudiant ⋈ Inscrits2013) π {matricule}
WITH
  Inscrit2013 AS --  (Résultat σ ('20131'≤trimestre≤'20133')) π {matricule}
    (
      SELECT matricule
      FROM Resultat
      WHERE trimestre BETWEEN '20131' AND '20133'
    )
  SELECT matricule
  FROM Etudiant
EXCEPT
  SELECT matricule
  FROM Inscrit2013
;

--
-- R5 version 2
-- (Étudiant ⋈ (Résultat σ ('20131'≤trimestre≤'20133')) π {matricule})
  SELECT matricule, nom, adresse
  FROM Etudiant
EXCEPT
  SELECT matricule, nom, adresse
  FROM Etudiant
    JOIN
      (
        SELECT matricule
        FROM Resultat
        WHERE ('20131' <= trimestre AND trimestre <= '20133')
      ) AS Inscrit2013
    USING (matricule)
;

--
-- R5 version 3
-- (Étudiant π {matricule}) σ
--   ( (Résultat ρ {matricule -> m}) σ ('20131'≤trimestre≤'20133') ⋀ (matricule=m) ) = ∅
SELECT *
FROM Etudiant
WHERE NOT EXISTS
  (
    SELECT DISTINCT matricule
    FROM Resultat
    WHERE NOT (trimestre < '20131' OR '20133' > trimestre)
      AND Etudiant.matricule = Resultat.matricule
  )
;

--
-- R5 version 4 mauvaise interprétation (PEUT LIVRER DE FAUX RÉSULTATS)
-- Étudiant ⋈ (Résultat σ (trimestre < '20131' ∨ '20133' > trimestre) π {matricule})
SELECT distinct matricule, nom, adresse
FROM Etudiant
  JOIN
    (
      SELECT matricule
      FROM Resultat
      WHERE trimestre < '20131' OR '20133' > trimestre
    ) AS NonInscrit2013
  USING (matricule)
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
NIL

Tâches réalisées :
2015-08-23 (CK01) : Création
  * Requêtes telles que présentées dans SQL_00-Apercu.

Références :
[mod] https://github.com/llavoie-qc/IFT187
-- -----------------------------------------------------------------------------
-- fin de Evaluation_req.sql
-- =========================================================================== Z
*/
