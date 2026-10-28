-- Apply to the starter periodic_table database supplied by CodeRoad.
BEGIN;
ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;
ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;
ALTER TABLE elements ADD UNIQUE(symbol);
ALTER TABLE elements ADD UNIQUE(name);
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
DELETE FROM properties WHERE atomic_number = 1000;
DELETE FROM elements WHERE atomic_number = 1000;
ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number);
CREATE TABLE types (type_id INT PRIMARY KEY, type VARCHAR(30) NOT NULL);
INSERT INTO types VALUES (1, 'metal'), (2, 'metalloid'), (3, 'nonmetal');
ALTER TABLE properties ADD COLUMN type_id INT REFERENCES types(type_id);
UPDATE properties SET type_id = types.type_id FROM types WHERE properties.type = types.type;
ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;
ALTER TABLE properties DROP COLUMN type;
UPDATE elements SET symbol = UPPER(LEFT(symbol, 1)) || SUBSTRING(symbol FROM 2);
ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;
-- Casting through text removes the starter column's fixed numeric scale.
UPDATE properties SET atomic_mass = TRIM(TRAILING '.' FROM TRIM(TRAILING '0' FROM atomic_mass::text))::DECIMAL WHERE atomic_mass::text LIKE '%.%';
INSERT INTO elements(atomic_number, symbol, name) VALUES (9, 'F', 'Fluorine'), (10, 'Ne', 'Neon');
INSERT INTO properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES (9, 18.998, -220, -188.1, 3), (10, 20.18, -248.6, -246.1, 3);
COMMIT;
