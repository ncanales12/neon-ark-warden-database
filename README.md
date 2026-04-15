# Neon Ark Warden Onboarding Database

Author: Nicolas Canales  
Course: COSC 4301 – Modern Programming

## Overview

This project designs a relational database for the Neon Ark Admin Warden onboarding system. The design supports onboarding, updating, and managing Wardens and their certifications.

The assignment required:

* Designing an Entity Relationship Diagram (ERD)
* Implementing the database structure in SQL
* Enforcing data consistency using constraints
* Providing sample data for testing

* Bonus PostgreSQL feature: a trigger automatically marks certifications as expired when the expiration date is in the past.



## Files

neon\_ark\_erd.png  
ERD diagram showing table relationships and normalization.

neon\_ark\_wardens.sql  
SQL script that:

* Drops existing tables
* Recreates the schema
* Applies constraints
* Inserts sample data (10+ wardens)

The SQL script runs from start to finish without errors.

## Database Concepts Demonstrated

* Primary Keys
* Foreign Keys
* Unique Constraints
* Lookup Tables
* Many-to-Many Relationships
* Normalization

