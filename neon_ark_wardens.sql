-- Neon Ark Admin Warden Onboarding Database
-- This script builds the database from scratch
-- It includes tables, constraints, and sample data

-- ========================================
-- DROP TABLES
-- Drop child tables first to avoid foreign key errors
-- ========================================

DROP TABLE IF EXISTS warden_certifications;
DROP TABLE IF EXISTS certifications;
DROP TABLE IF EXISTS wardens;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS employment_statuses;
DROP TABLE IF EXISTS clearance_levels;
DROP TABLE IF EXISTS identifier_types;


-- ========================================
-- CREATE TABLE: roles
-- Stores the official Warden role types
-- ========================================

CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL
);

-- ========================================
-- CREATE TABLE: employment_statuses
-- Stores allowed employment states
-- ========================================

CREATE TABLE employment_statuses (
    employment_status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(50) UNIQUE NOT NULL
);

-- ========================================
-- CREATE TABLE: clearance_levels
-- Stores allowed clearance levels
-- ========================================

CREATE TABLE clearance_levels (
    clearance_level_id SERIAL PRIMARY KEY,
    clearance_name VARCHAR(50) UNIQUE NOT NULL
);

-- ========================================
-- CREATE TABLE: identifier_types
-- Stores allowed identifier types
-- Example: Badge, Passport, Visa
-- ========================================

CREATE TABLE identifier_types (
    identifier_type_id SERIAL PRIMARY KEY,
    identifier_type_name VARCHAR(50) UNIQUE NOT NULL
);

-- ========================================
-- CREATE TABLE: wardens
-- Stores core Warden information
-- ========================================

CREATE TABLE wardens (
    warden_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    email VARCHAR(150) UNIQUE NOT NULL,

    identifier_type_id INTEGER NOT NULL,
    identifier_value VARCHAR(100) NOT NULL,

    role_id INTEGER NOT NULL,
    employment_status_id INTEGER NOT NULL,
    clearance_level_id INTEGER NOT NULL,

    start_date DATE NOT NULL,
    end_date DATE,

    CONSTRAINT fk_identifier_type
        FOREIGN KEY (identifier_type_id)
        REFERENCES identifier_types(identifier_type_id),

    CONSTRAINT fk_role
        FOREIGN KEY (role_id)
        REFERENCES roles(role_id),

    CONSTRAINT fk_employment_status
        FOREIGN KEY (employment_status_id)
        REFERENCES employment_statuses(employment_status_id),

    CONSTRAINT fk_clearance_level
        FOREIGN KEY (clearance_level_id)
        REFERENCES clearance_levels(clearance_level_id),

    CONSTRAINT unique_identifier
        UNIQUE (identifier_type_id, identifier_value)
);

-- ========================================
-- CREATE TABLE: certifications
-- Stores the list of possible certifications
-- ========================================

CREATE TABLE certifications (
    certification_id SERIAL PRIMARY KEY,
    certification_name VARCHAR(150) UNIQUE NOT NULL
);

-- ========================================
-- CREATE TABLE: warden_certifications
-- Tracks which certifications each warden has
-- ========================================

CREATE TABLE warden_certifications (
    warden_certification_id SERIAL PRIMARY KEY,
    warden_id INTEGER NOT NULL,
    certification_id INTEGER NOT NULL,

    date_earned DATE NOT NULL,
    expiration_date DATE,

    is_expired BOOLEAN DEFAULT FALSE,

    CONSTRAINT fk_warden
        FOREIGN KEY (warden_id)
        REFERENCES wardens(warden_id),

    CONSTRAINT fk_certification
        FOREIGN KEY (certification_id)
        REFERENCES certifications(certification_id)
);


-- ========================================
-- INSERT LOOKUP DATA
-- These values keep the system consistent
-- ========================================

INSERT INTO roles (role_name) VALUES
('Admin'),
('Field'),
('Rift'),
('Trainer'),
('Astral');

INSERT INTO employment_statuses (status_name) VALUES
('Active'),
('OnLeave'),
('Terminated');

INSERT INTO clearance_levels (clearance_name) VALUES
('Alpha'),
('Omega'),
('Eclipse');

INSERT INTO identifier_types (identifier_type_name) VALUES
('Badge'),
('Passport'),
('Visa');

INSERT INTO certifications (certification_name) VALUES
('Rift Containment'),
('Astral Navigation'),
('Emergency Response'),
('Creature Handling'),
('Dimensional Safety');


-- ========================================
-- INSERT SAMPLE WARDENS
-- At least 10 wardens required for testing
-- ========================================

INSERT INTO wardens (
first_name,
last_name,
email,
identifier_type_id,
identifier_value,
role_id,
employment_status_id,
clearance_level_id,
start_date,
end_date
) VALUES
('Lena','Korr','lena.korr@neonark.test',1,'B1001',2,1,1,'2023-01-10',NULL),
('Darius','Vale','darius.vale@neonark.test',1,'B1002',3,1,2,'2023-02-05',NULL),
('Mira','Sol','mira.sol@neonark.test',2,'P8891',4,1,1,'2023-03-12',NULL),
('Kai','Renn','kai.renn@neonark.test',3,'V4432',5,1,3,'2023-04-18',NULL),
('Arin','Tao','arin.tao@neonark.test',1,'B1003',2,2,2,'2023-05-22',NULL),
('Sera','Nyx','sera.nyx@neonark.test',2,'P9981',3,1,1,'2023-06-14',NULL),
('Jon','Cade','jon.cade@neonark.test',1,'B1004',4,1,2,'2023-07-03',NULL),
('Lyra','Zen','lyra.zen@neonark.test',3,'V5501',5,1,3,'2023-08-11',NULL),
('Theo','Mar','theo.mar@neonark.test',1,'B1005',2,3,1,'2023-09-07','2024-01-01'),
('Rhea','Volt','rhea.volt@neonark.test',2,'P7700',3,1,2,'2023-10-09',NULL);

-- ========================================
-- INSERT SAMPLE CERTIFICATION RECORDS
-- Demonstrates relationships between wardens and certifications
-- ========================================

INSERT INTO warden_certifications (
warden_id,
certification_id,
date_earned,
expiration_date,
is_expired
) VALUES
(1,1,'2023-02-01','2026-02-01',FALSE),
(2,2,'2023-03-15','2026-03-15',FALSE),
(3,3,'2023-04-10',NULL,FALSE),
(4,4,'2023-05-20','2025-05-20',FALSE),
(5,5,'2023-06-11',NULL,FALSE),
(6,1,'2023-07-05','2026-07-05',FALSE),
(7,2,'2023-08-08','2026-08-08',FALSE),
(8,3,'2023-09-12',NULL,FALSE);





