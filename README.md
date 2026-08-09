# ElderCare Management System

**A T-SQL database project to manage residents, rooms, staff, medical records, medications, billing and visits for a residential eldercare facility.**

This repository contains the database schema and sample data for an ElderCare Management System implemented in T-SQL for Microsoft SQL Server (or compatible T-SQL engines).

---

## Features
- Relational schema for Rooms, Residents, Staff, Medical Records, Medications, Visits and Bills
- Referential integrity with sensible ON DELETE rules
- Sample data to exercise the schema and queries
- Simple example queries for exploring the dataset

## Stack
- Language: T-SQL (Microsoft SQL Server Transact-SQL)
- Tested with: T-SQL scripts (created for SQL Server / sqlcmd / SSMS)

## Repository layout
```
ElderCare management system.docx   - Project documentation / report (binary)
README.md                          - This file
SQLQuery1.sql                      - Schema: database + table DDL
SQLQuery2.sql                      - Sample data inserts
SQLQuery3.sql                      - Example SELECT / test query
myer.png                           - Image used in the project
```

## Schema overview
The database is created as ElderCare_management. Main tables and important columns:

- Room
  - id (PK, identity)
  - room_no (unique)
  - capacity
  - type (VARCHAR: 'single' or 'double')

- Resident
  - id_R (PK, identity)
  - Fname, Lname
  - DOB, gender, admission_date
  - room_id (FK -> Room.id) — ON DELETE SET NULL
  - contact, notes
  - Full_name (computed column)

- Staff
  - id (PK, identity)
  - Fname, Lname, role (Doctor / Nurse / Admin), phone, hire_date

- Medical_Record
  - id (PK, identity)
  - resident_id (FK -> Resident.id_R) — ON DELETE CASCADE
  - record_date, diagnosis, treatment
  - doctor_id (FK -> Staff.id) — ON DELETE SET NULL

- Medication
  - id (PK, identity)
  - resident_id (FK -> Resident.id_R) — ON DELETE CASCADE
  - med_name, dose, frequency, start_date, end_date

- Visit
  - id (PK, identity)
  - resident_id (FK -> Resident.id_R) — ON DELETE CASCADE
  - visitor_name, relation, visit_datetime, notes

- Bill
  - id (PK, identity)
  - resident_id (FK -> Resident.id_R) — ON DELETE CASCADE
  - bill_date, amount, description, paid (BIT)

## Quick start — create the database and load sample data
Prerequisites: an instance of Microsoft SQL Server (or a T-SQL compatible server) and a client such as sqlcmd or SQL Server Management Studio (SSMS).

1. Clone the repository:

   git clone https://github.com/nadin54/Eldercare_management_system.git
   cd Eldercare_management_system

2. Run the schema script (creates database and tables):

   Using sqlcmd (replace <server>, <user>, <password> if needed):

   sqlcmd -S <server> -U <user> -P <password> -i SQLQuery1.sql

   Or open SQLQuery1.sql in SSMS and execute.

3. Load sample data:

   sqlcmd -S <server> -U <user> -P <password> -i SQLQuery2.sql

4. Run the example query (SQLQuery3.sql) to verify data:

   sqlcmd -S <server> -U <user> -P <password> -i SQLQuery3.sql

## Example queries
- List residents with room information:

```sql
USE ElderCare_management;
SELECT r.id_R, r.Full_name, r.DOB, r.gender, rm.room_no, rm.type
FROM Resident r
LEFT JOIN Room rm ON r.room_id = rm.id;
```

- Get active medications for a resident (replace ? with resident id):

```sql
USE ElderCare_management;
SELECT med.med_name, med.dose, med.frequency, med.start_date, med.end_date
FROM Medication med
WHERE med.resident_id = ?;
```

- Recent medical records with attending doctor:

```sql
USE ElderCare_management;
SELECT m.record_date, m.diagnosis, m.treatment, s.Fname + ' ' + s.Lname AS doctor
FROM Medical_Record m
LEFT JOIN Staff s ON m.doctor_id = s.id
ORDER BY m.record_date DESC;
```

## Files of interest
- SQLQuery1.sql — schema DDL. Review constraints and computed columns here.
- SQLQuery2.sql — sample INSERT statements for Rooms, Residents, Staff, Medical_Record, Medication, Visit, Bill.
- SQLQuery3.sql — simple SELECT used for testing.
- ElderCare management system.docx — project report / documentation (may include additional design notes).

## Suggested next steps / improvements
- Add a LICENSE file (e.g. MIT) to make reuse and contributions explicit.
- Add a CONTRIBUTING.md with guidelines for PRs and issues.
- Add automated checks (formatting or a lightweight CI workflow that validates SQL syntax) in .github/workflows.
- Provide a ER diagram (PNG or SVG) and an entity description file in docs/ for easier onboarding.
- Consider converting sample data scripts into idempotent scripts (use IF NOT EXISTS / MERGE) so they can be re-run safely.

## Contact / author
Repository owner: @nadin54 (GitHub)

---

If you’d like, I can commit this improved README.md to the repository now, add a LICENSE, or create a docs/ folder with an ER diagram and more examples.