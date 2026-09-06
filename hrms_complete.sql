Create database HRMS;
Use HRMS;


CREATE TABLE Role (
    role_id   INT           PRIMARY KEY,
    role_name VARCHAR(50)   NOT NULL
);

CREATE TABLE Permission (
    permission_id   INT           PRIMARY KEY,
    permission_name VARCHAR(100)  NOT NULL
);

CREATE TABLE Role_Permission (
    role_id       INT  NOT NULL,
    permission_id INT  NOT NULL,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id)       REFERENCES Role(role_id),
    FOREIGN KEY (permission_id) REFERENCES Permission(permission_id)
);

CREATE TABLE Department (
    dept_id   INT           PRIMARY KEY,
    dept_name VARCHAR(100)  NOT NULL,
    location  VARCHAR(100)
);

CREATE TABLE Designation (
    designation_id  INT           PRIMARY KEY,
    dept_id         INT           NOT NULL,
    job_title       VARCHAR(100)  NOT NULL,
    seniority_level VARCHAR(50),
    min_salary      DECIMAL(12,2),
    max_salary      DECIMAL(12,2),
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Employee (
    employee_id       INT           PRIMARY KEY,
    dept_id           INT,
    designation_id    INT,
    emp_name          VARCHAR(100)  NOT NULL,
    email             VARCHAR(150)  NOT NULL UNIQUE,
    date_of_birth     DATE,
    address           VARCHAR(255),
    hire_date         DATE          NOT NULL,
    employment_status VARCHAR(30)   DEFAULT 'Active',
    age               INT,
    FOREIGN KEY (dept_id)        REFERENCES Department(dept_id),
    FOREIGN KEY (designation_id) REFERENCES Designation(designation_id)
);

CREATE TABLE Employee_Email (
    email_id    INT           PRIMARY KEY,
    employee_id INT           NOT NULL,
    email       VARCHAR(150)  NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Employee_Phone (
    phone_id    INT          PRIMARY KEY,
    employee_id INT          NOT NULL,
    phone       VARCHAR(20)  NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Users (
    user_id       INT           PRIMARY KEY,
    employee_id   INT           NOT NULL UNIQUE,
    role_id       INT           NOT NULL,
    username      VARCHAR(80)   NOT NULL UNIQUE,
    password_hash VARCHAR(255)  NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (role_id)     REFERENCES Role(role_id)
);

CREATE TABLE Attendance (
    attendance_id  INT          PRIMARY KEY,
    employee_id    INT          NOT NULL,
    date           DATE         NOT NULL,
    check_in_time  TIME,
    check_out_time TIME,
    status         VARCHAR(20)  DEFAULT 'Present',
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Leave (
    leave_id        INT           PRIMARY KEY,
    employee_id     INT           NOT NULL,
    leave_type      VARCHAR(50)   NOT NULL,
    start_date      DATE          NOT NULL,
    end_date        DATE          NOT NULL,
    reason          VARCHAR(255),
    approved_status VARCHAR(20)   DEFAULT 'Pending',
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Performance (
    performance_id    INT           PRIMARY KEY,
    employee_id       INT           NOT NULL,
    rating            DECIMAL(3,1),
    review_start_time DATE,
    review_end_time   DATE,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Comments (
    comment_id     INT           PRIMARY KEY,
    performance_id INT           NOT NULL,
    employee_id    INT           NOT NULL,
    comment        VARCHAR(500),
    FOREIGN KEY (performance_id) REFERENCES Performance(performance_id),
    FOREIGN KEY (employee_id)    REFERENCES Employee(employee_id)
);

CREATE TABLE Training (
    training_id    INT           PRIMARY KEY,
    performance_id INT,
    employee_id    INT           NOT NULL,
    training_title VARCHAR(150)  NOT NULL,
    trainer_name   VARCHAR(100),
    start_date     DATE,
    end_date       DATE,
    description    VARCHAR(500),
    FOREIGN KEY (performance_id) REFERENCES Performance(performance_id),
    FOREIGN KEY (employee_id)    REFERENCES Employee(employee_id)
);

CREATE TABLE Payroll (
    payroll_id       INT           PRIMARY KEY,
    employee_id      INT           NOT NULL,
    payroll_month    VARCHAR(20)   NOT NULL,
    basic_salary     DECIMAL(12,2) NOT NULL,
    total_deductions DECIMAL(12,2) DEFAULT 0,
    net_salary       DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Salary_Slip (
    slip_id         INT          PRIMARY KEY,
    payroll_id      INT          NOT NULL,
    employee_id     INT          NOT NULL,
    generation_date DATE,
    slip_month      VARCHAR(20),
    net_salary      DECIMAL(12,2),
    FOREIGN KEY (payroll_id)  REFERENCES Payroll(payroll_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Deduction (
    deduction_id   INT           PRIMARY KEY,
    type           VARCHAR(80)   NOT NULL,
    description    VARCHAR(255)
);

CREATE TABLE Payroll_Deduction (
    payroll_id   INT           NOT NULL,
    deduction_id INT           NOT NULL,
    amount       DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (payroll_id, deduction_id),
    FOREIGN KEY (payroll_id)  REFERENCES Payroll(payroll_id),
    FOREIGN KEY (deduction_id) REFERENCES Deduction(deduction_id)
);

CREATE TABLE Allowance (
    allowance_id   INT           PRIMARY KEY,
    type           VARCHAR(80)   NOT NULL,
    description    VARCHAR(255)
);

CREATE TABLE Payroll_Allowance (
    payroll_id   INT           NOT NULL,
    allowance_id INT           NOT NULL,
    amount       DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (payroll_id, allowance_id),
    FOREIGN KEY (payroll_id)  REFERENCES Payroll(payroll_id),
    FOREIGN KEY (allowance_id) REFERENCES Allowance(allowance_id)
);

CREATE TABLE Skills (
    skill_id   INT           PRIMARY KEY,
    skill_name VARCHAR(100)  NOT NULL
);

CREATE TABLE Job_Posting (
    job_id         INT           PRIMARY KEY,
    designation_id INT,
    dept_id        INT,
    date_posted    DATE,
    exp_required   INT,
    min_salary     DECIMAL(12,2),
    max_salary     DECIMAL(12,2),
    job_title      VARCHAR(100),
    description    VARCHAR(500),
    status         VARCHAR(30)   DEFAULT 'Open',
    FOREIGN KEY (designation_id) REFERENCES Designation(designation_id),
    FOREIGN KEY (dept_id)        REFERENCES Department(dept_id)
);

CREATE TABLE JobPosting_Skill (
    job_id    INT NOT NULL,
    skill_id  INT NOT NULL,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id)  REFERENCES Job_Posting(job_id),
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id)
);

CREATE TABLE Candidate (
    candidate_id        INT           PRIMARY KEY,
    job_id              INT,
    candidate_firstname VARCHAR(80)   NOT NULL,
    candidate_lastname  VARCHAR(80)   NOT NULL,
    experience_years    INT,
    app_status          VARCHAR(30)   DEFAULT 'Applied',
    resume              VARCHAR(255),
    FOREIGN KEY (job_id) REFERENCES Job_Posting(job_id)
);

CREATE TABLE Candidate_Email (
    candidate_id INT          NOT NULL,
    email        VARCHAR(150) NOT NULL,
    PRIMARY KEY (candidate_id, email),
    FOREIGN KEY (candidate_id) REFERENCES Candidate(candidate_id)
);

CREATE TABLE Candidate_Phone (
    candidate_id INT         NOT NULL,
    phone        VARCHAR(20) NOT NULL,
    PRIMARY KEY (candidate_id, phone),
    FOREIGN KEY (candidate_id) REFERENCES Candidate(candidate_id)
);

CREATE TABLE Recruitment (
    recruitment_id INT          PRIMARY KEY,
    job_id         INT          NOT NULL,
    candidate_id   INT          NOT NULL,
    app_date       DATE,
    status         VARCHAR(30)  DEFAULT 'In Review',
    FOREIGN KEY (job_id)      REFERENCES Job_Posting(job_id),
    FOREIGN KEY (candidate_id) REFERENCES Candidate(candidate_id)
);

CREATE TABLE Interview (
    interview_id      INT           PRIMARY KEY,
    job_id            INT           NOT NULL,
    candidate_id      INT           NOT NULL,
    interviewer_id    INT,
    interview_date    DATE,
    interviewer_name  VARCHAR(100),
    result            VARCHAR(30),
    remarks           VARCHAR(500),
    FOREIGN KEY (job_id)         REFERENCES Job_Posting(job_id),
    FOREIGN KEY (candidate_id)   REFERENCES Candidate(candidate_id),
    FOREIGN KEY (interviewer_id) REFERENCES Employee(employee_id)
);


-- SECTION 2 : ALTER TABLE STATEMENTS


-- Add manager reference to Department (self-referencing Employee)
ALTER TABLE Department
    ADD manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id);

-- Add managed_by to Employee (department head)
ALTER TABLE Employee
    ADD managed_by INT,
    FOREIGN KEY (managed_by) REFERENCES Employee(employee_id);

-- Add app_date to Candidate
ALTER TABLE Candidate
    ADD app_date DATE;

-- Add has_interview flag to Candidate
ALTER TABLE Candidate
    ADD has_interview BIT DEFAULT 0;

-- Add response/notes to Performance
ALTER TABLE Performance
    ADD response VARCHAR(255);

-- Add targeted_by column on Recruitment
ALTER TABLE Recruitment
    ADD targeted_by INT,
    FOREIGN KEY (targeted_by) REFERENCES Employee(employee_id);


-- SECTION 3 : INSERT DATA — MASTER TABLES (20-30 records each)


-- ─── Role (10 records) ───────────────────────────────────────
INSERT INTO Role (role_id, role_name) VALUES
(1,  'Admin'),
(2,  'HR Manager'),
(3,  'Payroll Officer'),
(4,  'Recruiter'),
(5,  'Employee'),
(6,  'Department Manager'),
(7,  'Trainer'),
(8,  'Interviewer'),
(9,  'Finance Manager'),
(10, 'Auditor'),
(11, 'Compliance Officer'),
(12, 'IT Support'),
(13, 'Security Officer'),
(14, 'Data Analyst'),
(15, 'Business Analyst'),
(16, 'Project Manager'),
(17, 'Legal Counsel'),
(18, 'Procurement Officer'),
(19, 'Quality Assurance'),
(20, 'Operations Manager');

-- ─── Permission (15 records) ─────────────────────────────────
INSERT INTO Permission (permission_id, permission_name) VALUES
(1,  'View Employee'),
(2,  'Edit Employee'),
(3,  'Delete Employee'),
(4,  'View Payroll'),
(5,  'Edit Payroll'),
(6,  'View Reports'),
(7,  'Manage Recruitment'),
(8,  'Manage Training'),
(9,  'View Attendance'),
(10, 'Approve Leave'),
(16, 'Manage Security'),
(17, 'View Audit Logs'),
(18, 'Manage Budget'),
(19, 'Approve Recruitment'),
(20, 'Manage Assets'),
(11, 'Post Job'),
(12, 'Manage Interviews'),
(13, 'View Salary Slips'),
(14, 'Manage Designations'),
(15, 'Full Access');

-- ─── Role_Permission (25 records) ────────────────────────────
INSERT INTO Role_Permission (role_id, permission_id) VALUES
(1,15),
(2,1),(2,2),(2,7),(2,8),(2,10),(2,12),
(3,4),(3,5),(3,13),
(4,7),(4,11),(4,12),
(5,1),(5,9),(5,13),
(6,1),(6,9),(6,10),
(7,8),
(8,12),
(9,4),(9,5),(9,6),
(10,6),
(11, 1),(11, 4),(11, 6),(11, 14),
(12, 1),(12, 9),
(13, 1),(13, 16),(13, 17),
(14, 1),(14, 4),(14, 6),(14, 13),
(15, 1),(15, 2),(15, 6),(15, 14),
(16, 1),(16, 6),(16, 8),(16, 10),
(17, 1),(17, 14),
(18, 1),(18, 2),(18, 9),
(19, 1),(19, 6),
(20, 1),(20, 6),(20, 9),(20, 10);

-- ─── Department (10 records) ─────────────────────────────────
INSERT INTO Department (dept_id, dept_name, location) VALUES
(1,  'Human Resources',        'Lahore'),
(2,  'Finance',                'Karachi'),
(3,  'Information Technology', 'Islamabad'),
(4,  'Marketing',              'Lahore'),
(5,  'Operations',             'Faisalabad'),
(6,  'Sales',                  'Multan'),
(7,  'Research & Development', 'Islamabad'),
(8,  'Customer Support',       'Karachi'),
(9,  'Legal',                  'Lahore'),
(10, 'Administration',         'Lahore'),
(11, 'Quality Assurance', 'Lahore'),
(12, 'Security', 'Islamabad'),
(13, 'Procurement', 'Karachi'),
(14, 'Public Relations', 'Lahore'),
(15, 'Corporate Strategy', 'Islamabad'),
(16, 'Internal Audit', 'Karachi'),
(17, 'Facilities Management', 'Lahore'),
(18, 'Learning & Development', 'Islamabad'),
(19, 'Compensation & Benefits', 'Karachi'),
(20, 'Diversity & Inclusion', 'Lahore');

-- ─── Designation (20 records) ────────────────────────────────
INSERT INTO Designation (designation_id, dept_id, job_title, seniority_level, min_salary, max_salary) VALUES
(1,  1,  'HR Executive',            'Junior',  40000,  60000),
(2,  1,  'HR Manager',              'Senior',  80000, 120000),
(3,  2,  'Accountant',              'Junior',  45000,  70000),
(4,  2,  'Finance Manager',         'Senior',  90000, 140000),
(5,  3,  'Software Engineer',       'Mid',     70000, 110000),
(6,  3,  'Senior Software Engineer','Senior', 110000, 160000),
(7,  3,  'Team Lead',               'Lead',   130000, 180000),
(8,  4,  'Marketing Executive',     'Junior',  40000,  65000),
(9,  4,  'Marketing Manager',       'Senior',  85000, 130000),
(10, 5,  'Operations Officer',      'Mid',     55000,  85000),
(11, 6,  'Sales Executive',         'Junior',  35000,  60000),
(12, 7,  'Research Analyst',        'Mid',     65000, 100000),
(13, 8,  'Support Agent',           'Junior',  30000,  50000),
(14, 9,  'Legal Advisor',           'Senior', 100000, 160000),
(15, 10, 'Admin Officer',           'Mid',     45000,  75000),
(16, 3,  'QA Engineer',             'Mid',     60000,  95000),
(17, 3,  'DevOps Engineer',         'Mid',     75000, 115000),
(18, 2,  'Tax Consultant',          'Senior',  85000, 125000),
(19, 1,  'Recruitment Specialist',  'Mid',     50000,  80000),
(20, 5,  'Logistics Coordinator',   'Junior',  38000,  58000);

-- ─── Skills (15 records) ─────────────────────────────────────
INSERT INTO Skills (skill_id, skill_name) VALUES
(1,  'Python'),
(2,  'Java'),
(3,  'SQL'),
(4,  'Project Management'),
(5,  'Communication'),
(6,  'Data Analysis'),
(7,  'JavaScript'),
(8,  'React'),
(9,  'Node.js'),
(10, 'AWS'),
(11, 'Docker'),
(12, 'Linux'),
(13, 'Excel'),
(14, 'Accounting'),
(15, 'Marketing Analytics'),
(16, 'C++'),
(17, 'Ruby on Rails'),
(18, 'Tableau'),
(19, 'Power BI'),
(20, 'SAP'),
(21, 'Oracle'),
(22, 'Leadership'),
(23, 'Negotiation'),
(24, 'Critical Thinking'),
(25, 'Problem Solving');

-- ─── Deduction (5 records) ───────────────────────────────────
INSERT INTO Deduction (deduction_id, type, description) VALUES
(1, 'Income Tax',      'Monthly income tax deduction'),
(2, 'Provident Fund',  'Employee provident fund'),
(3, 'Health Insurance','Health insurance premium'),
(4, 'Loan Recovery',   'Monthly loan installment'),
(5, 'Absence Penalty', 'Deduction for unapproved absence'),
(6, 'Union Dues', 'Monthly union membership fee'),
(7, 'Charity Donation', 'Employee voluntary donation'),
(8, 'Meal Deduction', 'Cafeteria meal charges'),
(9, 'Parking Fee', 'Monthly parking space rental'),
(10, 'Uniform Cost', 'Company uniform amortization');

-- ─── Allowance (5 records) ───────────────────────────────────
INSERT INTO Allowance (allowance_id, type, description) VALUES
(1, 'House Rent',       'Monthly house rent allowance'),
(2, 'Medical',          'Monthly medical allowance'),
(3, 'Fuel',             'Fuel / transport allowance'),
(4, 'Utility',          'Utility bills allowance'),
(5, 'Performance Bonus','Quarterly performance bonus'),
(6, 'Conveyance', 'Daily commute allowance'),
(7, 'Child Education', 'Education assistance for children'),
(8, 'Special Skills', 'Allowance for niche technical skills'),
(9, 'Shift Allowance', 'Night shift premium'),
(10, 'Remote Work Stipend', 'Internet and home office expenses');

-- ─── Employee (25 records) ───────────────────────────────────
INSERT INTO Employee (employee_id, dept_id, designation_id, emp_name, email, date_of_birth, address, hire_date, employment_status, age) VALUES
(1,  1,  2,  'Aisha Malik',    'aisha.malik@hrms.pk',      '1985-03-12', '12 Garden Town, Lahore',        '2015-01-10', 'Active', 39),
(2,  3,  5,  'Usman Ali',      'usman.ali@hrms.pk',        '1990-07-22', '45 F-7, Islamabad',             '2017-06-01', 'Active', 34),
(3,  2,  3,  'Sara Khan',      'sara.khan@hrms.pk',        '1992-11-05', '9 Clifton, Karachi',            '2018-03-15', 'Active', 32),
(4,  4,  8,  'Bilal Ahmed',    'bilal.ahmed@hrms.pk',      '1988-01-30', '77 Model Town, Lahore',         '2016-09-20', 'Active', 36),
(5,  3,  6,  'Hina Yousaf',    'hina.yousaf@hrms.pk',      '1987-05-18', '34 G-9, Islamabad',             '2014-04-05', 'Active', 37),
(6,  5,  10, 'Tariq Mehmood',  'tariq.mehmood@hrms.pk',    '1991-09-09', '22 Susan Road, Faisalabad',     '2019-02-11', 'Active', 33),
(7,  1,  1,  'Nadia Hussain',  'nadia.hussain@hrms.pk',    '1993-04-25', '55 Gulberg, Lahore',            '2020-07-01', 'Active', 31),
(8,  3,  7,  'Zain Raza',      'zain.raza@hrms.pk',        '1984-12-15', '11 E-7, Islamabad',             '2012-11-20', 'Active', 39),
(9,  6,  11, 'Rabia Farooq',   'rabia.farooq@hrms.pk',     '1995-06-07', '88 Nishtar Road, Multan',       '2021-01-15', 'Active', 29),
(10, 7,  12, 'Kamran Shah',    'kamran.shah@hrms.pk',      '1989-02-28', '19 Blue Area, Islamabad',       '2016-06-30', 'Active', 35),
(11, 8,  13, 'Fatima Noor',    'fatima.noor@hrms.pk',      '1996-08-14', '4 PECHS, Karachi',              '2022-03-01', 'Active', 28),
(12, 9,  14, 'Ali Hassan',     'ali.hassan@hrms.pk',       '1980-10-03', '67 Canal Road, Lahore',         '2010-05-15', 'Active', 44),
(13, 10, 15, 'Sana Qadir',     'sana.qadir@hrms.pk',       '1994-03-19', '30 Shadman, Lahore',            '2019-08-10', 'Active', 30),
(14, 3,  16, 'Imran Butt',     'imran.butt@hrms.pk',       '1991-07-11', '14 I-8, Islamabad',             '2018-12-01', 'Active', 33),
(15, 3,  17, 'Maham Iqbal',    'maham.iqbal@hrms.pk',      '1993-01-23', '5 Sector G, Islamabad',         '2020-04-15', 'Active', 31),
(16, 2,  4,  'Hamza Siddiqui', 'hamza.siddiqui@hrms.pk',   '1983-06-30', '23 Clifton, Karachi',           '2011-09-01', 'Active', 41),
(17, 4,  9,  'Amna Sheikh',    'amna.sheikh@hrms.pk',      '1986-11-17', '91 Gulshan, Lahore',            '2013-03-20', 'Active', 38),
(18, 2,  18, 'Owais Rana',     'owais.rana@hrms.pk',       '1982-04-08', '7 Bath Island, Karachi',        '2009-07-12', 'Active', 42),
(19, 1,  19, 'Zara Anwar',     'zara.anwar@hrms.pk',       '1997-09-29', '62 DHA, Lahore',                '2022-09-01', 'Active', 27),
(20, 5,  20, 'Shoaib Mir',     'shoaib.mir@hrms.pk',       '1990-12-05', '18 Peoples Colony, Faisalabad', '2017-11-10', 'Active', 34),
(21, 6,  11, 'Iqra Zaman',     'iqra.zaman@hrms.pk',       '1998-02-14', '44 Shah Rukn-e-Alam, Multan',   '2023-01-05', 'Active', 26),
(22, 8,  13, 'Asad Nawaz',     'asad.nawaz@hrms.pk',       '1995-05-20', '16 North Nazimabad, Karachi',   '2021-07-20', 'Active', 29),
(23, 7,  12, 'Maryam Zahid',   'maryam.zahid@hrms.pk',     '1992-08-03', '3 F-10, Islamabad',             '2018-10-01', 'Active', 32),
(24, 3,  5,  'Faisal Qureshi', 'faisal.qureshi@hrms.pk',   '1994-11-11', '29 G-8, Islamabad',             '2020-01-20', 'Active', 30),
(25, 1,  2,  'Lubna Riaz',     'lubna.riaz@hrms.pk',       '1981-07-27', '50 Johar Town, Lahore',         '2008-06-01', 'Active', 43);



-- ─── Employee_Email (10 records) ─────────────────────────────
INSERT INTO Employee_Email (email_id, employee_id, email) VALUES
(1,  1,  'aisha.personal@gmail.com'),
(2,  2,  'usman.work@outlook.com'),
(3,  3,  'sara.private@yahoo.com'),
(4,  4,  'bilal.personal@gmail.com'),
(5,  5,  'hina.alt@gmail.com'),
(6,  8,  'zain.raza.alt@outlook.com'),
(7,  12, 'ali.hassan.legal@gmail.com'),
(8,  16, 'hamza.fin@yahoo.com'),
(9,  25, 'lubna.hr@outlook.com'),
(10, 18, 'owais.tax@gmail.com'),
(11, 2, 'usman.alternate@gmail.com'),
(12, 3, 'sara.khan.personal@outlook.com'),
(13, 5, 'hina.work@yahoo.com'),
(14, 8, 'zain.personal@gmail.com'),
(15, 10, 'kamran.alt@outlook.com'),
(16, 14, 'imran.email@gmail.com'),
(17, 15, 'maham.secondary@yahoo.com'),
(18, 17, 'amna.personal@gmail.com'),
(19, 19, 'zara.alt@outlook.com'),
(20, 20, 'shoaib.work@gmail.com');

-- ─── Employee_Phone (15 records) ─────────────────────────────
INSERT INTO Employee_Phone (phone_id, employee_id, phone) VALUES
(1,  1,  '0300-1234567'),
(2,  2,  '0311-2345678'),
(3,  3,  '0321-3456789'),
(4,  4,  '0331-4567890'),
(5,  5,  '0341-5678901'),
(6,  6,  '0351-6789012'),
(7,  7,  '0361-7890123'),
(8,  8,  '0371-8901234'),
(9,  9,  '0381-9012345'),
(10, 10, '0301-0123456'),
(11, 11, '0303-1122334'),
(12, 12, '0313-2233445'),
(13, 13, '0323-3344556'),
(14, 14, '0333-4455667'),
(15, 15, '0343-5566778'),
(16, 16, '0353-6677889'),
(17, 17, '0363-7788990'),
(18, 18, '0373-8899001'),
(19, 19, '0383-9900112'),
(20, 20, '0393-0011223'),
(21, 21, '0304-1122334'),
(22, 22, '0314-2233445'),
(23, 23, '0324-3344556'),
(24, 24, '0334-4455667'),
(25, 25, '0344-5566778');

-- ─── Users (20 records) ──────────────────────────────────────
INSERT INTO Users (user_id, employee_id, role_id, username, password_hash) VALUES
(1,  1,  2,  'aisha.malik',    'hash_am_001'),
(2,  2,  5,  'usman.ali',      'hash_ua_002'),
(3,  3,  3,  'sara.khan',      'hash_sk_003'),
(4,  4,  5,  'bilal.ahmed',    'hash_ba_004'),
(5,  5,  6,  'hina.yousaf',    'hash_hy_005'),
(6,  6,  5,  'tariq.mehmood',  'hash_tm_006'),
(7,  7,  5,  'nadia.hussain',  'hash_nh_007'),
(8,  8,  6,  'zain.raza',      'hash_zr_008'),
(9,  9,  5,  'rabia.farooq',   'hash_rf_009'),
(10, 10, 5,  'kamran.shah',    'hash_ks_010'),
(11, 11, 5,  'fatima.noor',    'hash_fn_011'),
(12, 12, 9,  'ali.hassan',     'hash_ah_012'),
(13, 13, 5,  'sana.qadir',     'hash_sq_013'),
(14, 16, 4,  'hamza.siddiqui', 'hash_hs_014'),
(15, 25, 1,  'lubna.riaz',     'hash_lr_015'),
(16, 19, 4,  'zara.anwar',     'hash_za_016'),
(17, 18, 9,  'owais.rana',     'hash_or_017'),
(18, 17, 6,  'amna.sheikh',    'hash_as_018'),
(19, 14, 5,  'imran.butt',     'hash_ib_019'),
(20, 15, 5,  'maham.iqbal',    'hash_mi_020');

-- ─── Job_Posting (25 records) ────────────────────────────────
INSERT INTO Job_Posting (job_id, designation_id, dept_id, date_posted, exp_required, min_salary, max_salary, job_title, description, status) VALUES
(1,  5,  3, '2024-01-10', 2, 70000,  110000, 'Software Engineer',        'Backend development in Python/Django',          'Closed'),
(2,  6,  3, '2024-01-15', 4, 110000, 160000, 'Senior Software Engineer', 'Full-stack development leadership',             'Closed'),
(3,  8,  4, '2024-02-01', 1, 40000,   65000, 'Marketing Executive',      'Social media and content marketing',            'Closed'),
(4,  1,  1, '2024-02-20', 0, 40000,   60000, 'HR Executive',             'Assist HR Manager in recruitment & compliance', 'Closed'),
(5,  11, 6, '2024-03-05', 1, 35000,   60000, 'Sales Executive',          'Field sales and client acquisition',            'Closed'),
(6,  16, 3, '2024-03-12', 2, 60000,   95000, 'QA Engineer',              'Manual and automated testing',                  'Closed'),
(7,  17, 3, '2024-04-01', 3, 75000,  115000, 'DevOps Engineer',          'CI/CD pipelines and cloud infrastructure',      'Closed'),
(8,  12, 7, '2024-04-15', 3, 65000,  100000, 'Research Analyst',         'Market and data research',                      'Open'),
(9,  13, 8, '2024-05-01', 0, 30000,   50000, 'Support Agent',            'Customer query resolution via phone/email',     'Open'),
(10, 3,  2, '2024-05-10', 2, 45000,   70000, 'Accountant',               'Monthly financial reconciliation',              'Open'),
(11, 15, 10,'2024-05-20', 1, 45000,   75000, 'Admin Officer',            'Office management and admin tasks',             'Open'),
(12, 20, 5, '2024-06-01', 0, 38000,   58000, 'Logistics Coordinator',    'Supply chain and logistics coordination',       'Open'),
(13, 19, 1, '2024-06-10', 2, 50000,   80000, 'Recruitment Specialist',   'End-to-end recruitment cycle management',       'Open'),
(14, 14, 9, '2024-07-01', 5, 100000, 160000, 'Legal Advisor',            'Corporate legal advisory and compliance',       'Open'),
(15, 9,  4, '2024-07-15', 5, 85000,  130000, 'Marketing Manager',        'Lead marketing campaigns and brand strategy',   'Open'),
(16, 5,  3, '2024-08-01', 2, 70000,  110000, 'Software Engineer',        'React/Node.js developer',                       'Open'),
(17, 6,  3, '2024-08-10', 5, 110000, 160000, 'Senior Software Engineer', 'Microservices architecture experience required', 'Open'),
(18, 3,  2, '2024-08-20', 3, 45000,   70000, 'Accountant',               'Tax and audit specialist',                      'Open'),
(19, 10, 5, '2024-09-01', 2, 55000,   85000, 'Operations Officer',       'Process improvement and operations oversight',  'Open'),
(20, 11, 6, '2024-09-10', 1, 35000,   60000, 'Sales Executive',          'Inside sales and CRM management',               'Open'),
(21, 18, 2, '2024-09-20', 4, 85000,  125000, 'Tax Consultant',           'Corporate tax filing and planning',             'Open'),
(22, 7,  3, '2024-10-01', 6, 130000, 180000, 'Team Lead',                'Technical team leadership and sprint planning', 'Open'),
(23, 4,  2, '2024-10-15', 7, 90000,  140000, 'Finance Manager',          'Financial planning, budgeting, and reporting',  'Open'),
(24, 2,  1, '2024-11-01', 5, 80000,  120000, 'HR Manager',               'Oversee all HR functions and policies',         'Open'),
(25, 16, 3, '2024-11-15', 2, 60000,   95000, 'QA Engineer',              'Selenium/Cypress automation testing',           'Open');

-- ─── JobPosting_Skill ─────────────────────────────────────────
INSERT INTO JobPosting_Skill (job_id, skill_id) VALUES
(1,1),(1,3),(1,2),
(2,1),(2,7),(2,8),(2,9),
(3,5),(3,15),
(4,5),
(5,5),
(6,3),(6,2),
(7,10),(7,11),(7,12),
(8,6),(8,13),
(9,5),
(10,14),(10,13),
(11,5),(11,13),
(12,4),
(13,5),(13,4),
(14,5),
(15,15),(15,4),
(16,7),(16,8),(16,9),
(17,7),(17,10),
(18,14),
(19,4),
(20,5),
(21,14),
(22,1),(22,4),
(23,14),(23,13),
(24,5),(24,4),
(25,2),(25,3);

-- ============================================================
-- SECTION 4 : INSERT DATA — DETAIL TABLES (50-70 Records Each)
-- ============================================================

-- ─── Candidate (60 records) ──────────────────────────────────
INSERT INTO Candidate (candidate_id, job_id, candidate_firstname, candidate_lastname, experience_years, app_status, resume) VALUES
(1,1,'Ahmed','Raza',3,'Hired','cv_ahmed_raza.pdf'),
(2,1,'Sobia','Tariq',2,'Rejected','cv_sobia_tariq.pdf'),
(3,1,'Junaid','Malik',4,'Rejected','cv_junaid_malik.pdf'),
(4,2,'Farrukh','Bashir',5,'Hired','cv_farrukh_bashir.pdf'),
(5,2,'Kinza','Awan',4,'Rejected','cv_kinza_awan.pdf'),
(6,3,'Omer','Shafiq',1,'Hired','cv_omer_shafiq.pdf'),
(7,3,'Hajra','Chaudhry',2,'Rejected','cv_hajra_ch.pdf'),
(8,4,'Anum','Saeed',0,'Hired','cv_anum_saeed.pdf'),
(9,4,'Taha','Nawaz',1,'Rejected','cv_taha_nawaz.pdf'),
(10,5,'Rimsha','Javed',1,'Hired','cv_rimsha_javed.pdf'),
(11,5,'Waqas','Gill',2,'Rejected','cv_waqas_gill.pdf'),
(12,6,'Noreen','Baig',2,'Hired','cv_noreen_baig.pdf'),
(13,6,'Shahid','Iqbal',3,'Rejected','cv_shahid_iqbal.pdf'),
(14,7,'Rida','Nasir',3,'Hired','cv_rida_nasir.pdf'),
(15,7,'Talha','Zuberi',4,'Rejected','cv_talha_zuberi.pdf'),
(16,8,'Asma','Pirzada',3,'Applied','cv_asma_pirzada.pdf'),
(17,8,'Danish','Rao',4,'Applied','cv_danish_rao.pdf'),
(18,9,'Misbah','Qadri',0,'Shortlisted','cv_misbah_q.pdf'),
(19,9,'Fauzia','Latif',1,'Shortlisted','cv_fauzia_l.pdf'),
(20,10,'Naveed','Chishti',2,'Applied','cv_naveed_c.pdf'),
(21,10,'Sadia','Mehmood',3,'Applied','cv_sadia_m.pdf'),
(22,11,'Waleed','Hameed',1,'Applied','cv_waleed_h.pdf'),
(23,12,'Lubna','Arshad',0,'Applied','cv_lubna_a.pdf'),
(24,13,'Saif','Ullah',2,'Shortlisted','cv_saif_u.pdf'),
(25,13,'Huma','Batool',3,'Applied','cv_huma_b.pdf'),
(26,14,'Irfan','Karim',6,'Shortlisted','cv_irfan_k.pdf'),
(27,15,'Zobia','Aziz',5,'Applied','cv_zobia_az.pdf'),
(28,16,'Hamid','Sultan',2,'Applied','cv_hamid_s.pdf'),
(29,16,'Iqra','Bashir',3,'Applied','cv_iqra_b.pdf'),
(30,17,'Rizwan','Haider',5,'Shortlisted','cv_rizwan_h.pdf'),
(31,17,'Samia','Naqvi',6,'Applied','cv_samia_n.pdf'),
(32,18,'Tahir','Rashid',3,'Applied','cv_tahir_r.pdf'),
(33,19,'Abida','Choudhry',2,'Applied','cv_abida_ch.pdf'),
(34,20,'Naseer','Bhatti',1,'Applied','cv_naseer_b.pdf'),
(35,21,'Gulnaz','Shah',4,'Shortlisted','cv_gulnaz_s.pdf'),
(36,22,'Furqan','Amjad',7,'Applied','cv_furqan_a.pdf'),
(37,23,'Samra','Butt',8,'Applied','cv_samra_bt.pdf'),
(38,24,'Kashif','Nisar',5,'Shortlisted','cv_kashif_n.pdf'),
(39,25,'Nida','Rehman',2,'Applied','cv_nida_r.pdf'),
(40,25,'Adil','Farhan',3,'Applied','cv_adil_f.pdf'),
(41,1,'Komal','Iqbal',2,'Rejected','cv_komal_iq.pdf'),
(42,2,'Basit','Waheed',5,'Rejected','cv_basit_w.pdf'),
(43,6,'Nawal','Ahmed',2,'Rejected','cv_nawal_a.pdf'),
(44,7,'Umar','Farooq',3,'Rejected','cv_umar_f.pdf'),
(45,5,'Amreen','Siddiq',1,'Rejected','cv_amreen_s.pdf'),
(46,4,'Bilqees','Qamar',0,'Rejected','cv_bilqees_q.pdf'),
(47,3,'Jawad','Mirza',2,'Rejected','cv_jawad_m.pdf'),
(48,1,'Areeba','Sultan',2,'Rejected','cv_areeba_s.pdf'),
(49,8,'Farrukh','Qadeer',0,'Shortlisted','cv_farrukh_q.pdf'),
(50,9,'Shabana','Riaz',0,'Shortlisted','cv_shabana_r.pdf'),
(51,13,'Noman','Akhtar',2,'Applied','cv_noman_a.pdf'),
(52,14,'Adeela','Memon',5,'Applied','cv_adeela_m.pdf'),
(53,16,'Saad','Pervaiz',2,'Applied','cv_saad_p.pdf'),
(54,22,'Raoof','Abbasi',6,'Applied','cv_raoof_ab.pdf'),
(55,23,'Neelum','Khattak',7,'Applied','cv_neelum_k.pdf'),
(56,24,'Tariq','Jamil',5,'Applied','cv_tariq_j.pdf'),
(57,20,'Shahzad','Faridi',1,'Applied','cv_shahzad_f.pdf'),
(58,19,'Riffat','Anwar',2,'Applied','cv_riffat_a.pdf'),
(59,21,'Shaheen','Rana',4,'Applied','cv_shaheen_r.pdf'),
(60,15,'Mona','Jawaid',5,'Applied','cv_mona_j.pdf');
-- ─── Candidate_Email (17 records) ────────────────────────────
INSERT INTO Candidate_Email (candidate_id, email) VALUES
(1,  'ahmed.raza@gmail.com'),
(2,  'sobia.tariq@outlook.com'),
(3,  'junaid.malik@yahoo.com'),
(4,  'farrukh.b@gmail.com'),
(5,  'kinza.awan@gmail.com'),
(6,  'omer.shafiq@yahoo.com'),
(8,  'anum.saeed@gmail.com'),
(10, 'rimsha.javed@gmail.com'),
(12, 'noreen.baig@outlook.com'),
(14, 'rida.nasir@gmail.com'),
(16, 'asma.pirzada@gmail.com'),
(18, 'misbah.q@yahoo.com'),
(24, 'saif.ullah@gmail.com'),
(26, 'irfan.karim@outlook.com'),
(30, 'rizwan.haider@gmail.com'),
(35, 'gulnaz.shah@gmail.com'),
(38, 'kashif.nisar@yahoo.com');

-- ─── Candidate_Phone (16 records) ────────────────────────────
INSERT INTO Candidate_Phone (candidate_id, phone) VALUES
(1,  '0312-1111111'),
(2,  '0322-2222222'),
(4,  '0332-3333333'),
(5,  '0342-4444444'),
(6,  '0352-5555555'),
(8,  '0362-6666666'),
(10, '0372-7777777'),
(12, '0382-8888888'),
(14, '0392-9999999'),
(16, '0302-0001111'),
(18, '0312-0002222'),
(24, '0322-0003333'),
(26, '0332-0004444'),
(30, '0342-0005555'),
(35, '0352-0006666'),
(38, '0362-0007777');

-- ─── Recruitment (60 records) ────────────────────────────────
INSERT INTO Recruitment (recruitment_id, job_id, candidate_id, app_date, status) VALUES
(1,  1,  1,  '2024-01-20', 'Hired'),
(2,  1,  2,  '2024-01-22', 'Rejected'),
(3,  1,  3,  '2024-01-25', 'Rejected'),
(4,  1,  41, '2024-01-28', 'Rejected'),
(5,  1,  48, '2024-02-01', 'Rejected'),
(6,  2,  4,  '2024-01-20', 'Hired'),
(7,  2,  5,  '2024-01-23', 'Rejected'),
(8,  2,  42, '2024-01-30', 'Rejected'),
(9,  3,  6,  '2024-02-05', 'Hired'),
(10, 3,  7,  '2024-02-07', 'Rejected'),
(11, 3,  47, '2024-02-10', 'Rejected'),
(12, 4,  8,  '2024-02-25', 'Hired'),
(13, 4,  9,  '2024-02-27', 'Rejected'),
(14, 4,  46, '2024-03-01', 'Rejected'),
(15, 5,  10, '2024-03-10', 'Hired'),
(16, 5,  11, '2024-03-12', 'Rejected'),
(17, 5,  45, '2024-03-14', 'Rejected'),
(18, 6,  12, '2024-03-18', 'Hired'),
(19, 6,  13, '2024-03-20', 'Rejected'),
(20, 6,  43, '2024-03-22', 'Rejected'),
(21, 7,  14, '2024-04-07', 'Hired'),
(22, 7,  15, '2024-04-09', 'Rejected'),
(23, 7,  44, '2024-04-11', 'Rejected'),
(24, 8,  16, '2024-04-20', 'In Review'),
(25, 8,  17, '2024-04-22', 'In Review'),
(26, 9,  18, '2024-05-05', 'Shortlisted'),
(27, 9,  19, '2024-05-06', 'In Review'),
(28, 9,  50, '2024-05-08', 'Shortlisted'),
(29, 10, 20, '2024-05-15', 'In Review'),
(30, 10, 21, '2024-05-17', 'In Review'),
(31, 11, 22, '2024-05-22', 'In Review'),
(32, 12, 23, '2024-06-05', 'In Review'),
(33, 13, 24, '2024-06-14', 'Shortlisted'),
(34, 13, 25, '2024-06-15', 'In Review'),
(35, 13, 51, '2024-06-18', 'In Review'),
(36, 14, 26, '2024-07-05', 'Shortlisted'),
(37, 14, 52, '2024-07-07', 'In Review'),
(38, 15, 27, '2024-07-18', 'In Review'),
(39, 15, 60, '2024-07-20', 'In Review'),
(40, 16, 28, '2024-08-07', 'In Review'),
(41, 16, 29, '2024-08-09', 'In Review'),
(42, 16, 53, '2024-08-11', 'In Review'),
(43, 17, 30, '2024-08-13', 'Shortlisted'),
(44, 17, 31, '2024-08-15', 'In Review'),
(45, 18, 32, '2024-08-24', 'In Review'),
(46, 19, 33, '2024-09-05', 'In Review'),
(47, 19, 58, '2024-09-03', 'In Review'),
(48, 20, 34, '2024-09-14', 'In Review'),
(49, 20, 57, '2024-09-16', 'In Review'),
(50, 21, 35, '2024-09-24', 'Shortlisted'),
(51, 21, 59, '2024-09-26', 'In Review'),
(52, 22, 36, '2024-10-05', 'In Review'),
(53, 22, 54, '2024-10-07', 'In Review'),
(54, 23, 37, '2024-10-18', 'In Review'),
(55, 23, 55, '2024-10-20', 'In Review'),
(56, 24, 38, '2024-11-05', 'Shortlisted'),
(57, 24, 56, '2024-11-08', 'In Review'),
(58, 25, 39, '2024-11-19', 'In Review'),
(59, 25, 40, '2024-11-20', 'In Review'),
(60, 4,  49, '2024-04-28', 'Shortlisted');

-- ─── Interview (55 records) ───────────────────────────────────
INSERT INTO Interview (interview_id, job_id, candidate_id, interviewer_id, interview_date, interviewer_name, result, remarks) VALUES
(1,  1,  1,  8,  '2024-01-30', 'Zain Raza',      'Pass',    'Strong Python and system design skills'),
(2,  1,  2,  5,  '2024-01-31', 'Hina Yousaf',    'Fail',    'Weak problem-solving skills'),
(3,  2,  4,  8,  '2024-01-28', 'Zain Raza',      'Pass',    'Excellent full-stack experience'),
(4,  2,  5,  5,  '2024-01-29', 'Hina Yousaf',    'Fail',    'Insufficient senior-level knowledge'),
(5,  3,  6,  17, '2024-02-12', 'Amna Sheikh',    'Pass',    'Good communication and creativity'),
(6,  4,  8,  1,  '2024-03-03', 'Aisha Malik',    'Pass',    'Eager to learn, good attitude'),
(7,  4,  9,  1,  '2024-03-04', 'Aisha Malik',    'Fail',    'Limited HR knowledge'),
(8,  5,  10, 17, '2024-03-17', 'Amna Sheikh',    'Pass',    'Target-driven personality'),
(9,  6,  12, 14, '2024-03-25', 'Imran Butt',     'Pass',    'Solid automation testing background'),
(10, 6,  13, 14, '2024-03-26', 'Imran Butt',     'Fail',    'Manual testing only, no automation'),
(11, 7,  14, 15, '2024-04-14', 'Maham Iqbal',    'Pass',    'Excellent DevOps and AWS expertise'),
(12, 7,  15, 15, '2024-04-15', 'Maham Iqbal',    'Fail',    'Limited cloud experience'),
(13, 4,  49, 1,  '2024-05-05', 'Aisha Malik',    'Pass',    'Good administrative skills'),
(14, 9,  18, 1,  '2024-05-20', 'Aisha Malik',    'Pending', 'First round completed'),
(15, 9,  50, 1,  '2024-05-22', 'Aisha Malik',    'Pending', 'Awaiting second round'),
(16, 13, 24, 1,  '2024-06-28', 'Aisha Malik',    'Pending', 'HR round completed'),
(17, 14, 26, 12, '2024-07-15', 'Ali Hassan',     'Pending', 'Legal case study assigned'),
(18, 17, 30, 8,  '2024-08-20', 'Zain Raza',      'Pending', 'Technical round in progress'),
(19, 21, 35, 18, '2024-10-01', 'Owais Rana',     'Pending', 'Tax scenario discussed'),
(20, 24, 38, 1,  '2024-11-12', 'Aisha Malik',    'Pending', 'Culture fit round done'),
(21, 1,  3,  8,  '2024-02-01', 'Zain Raza',      'Fail',    'Did not attempt coding test'),
(22, 2,  42, 5,  '2024-02-03', 'Hina Yousaf',    'Fail',    'Communication gap'),
(23, 3,  47, 17, '2024-02-14', 'Amna Sheikh',    'Fail',    'No portfolio'),
(24, 5,  11, 17, '2024-03-19', 'Amna Sheikh',    'Fail',    'No field experience'),
(25, 6,  43, 14, '2024-03-28', 'Imran Butt',     'Fail',    'Did not know testing tools'),
(26, 7,  44, 15, '2024-04-17', 'Maham Iqbal',    'Fail',    'No CI/CD knowledge'),
(27, 7,  15, 8,  '2024-04-18', 'Zain Raza',      'Fail',    'Second round failed'),
(28, 2,  5,  8,  '2024-01-31', 'Zain Raza',      'Fail',    'Second round not performed well'),
(29, 24, 56, 25, '2024-11-14', 'Lubna Riaz',     'Pending', 'Technical HR competency test'),
(30, 22, 36, 8,  '2024-10-12', 'Zain Raza',      'Pending', 'Architecture design round'),
(31, 14, 52, 12, '2024-07-17', 'Ali Hassan',     'Pending', 'Awaiting panel interview'),
(32, 15, 27, 17, '2024-07-24', 'Amna Sheikh',    'Pending', 'Strategy presentation'),
(33, 23, 37, 16, '2024-10-24', 'Hamza Siddiqui', 'Pending', 'Financial modelling test'),
(34, 18, 32, 3,  '2024-09-01', 'Sara Khan',      'Pending', 'Audit case study'),
(35, 16, 28, 5,  '2024-08-15', 'Hina Yousaf',    'Pending', 'Coding challenge assigned'),
(36, 16, 29, 5,  '2024-08-16', 'Hina Yousaf',    'Pending', 'Awaiting results'),
(37, 10, 20, 3,  '2024-05-25', 'Sara Khan',      'Pending', 'Accounting aptitude test'),
(38, 12, 23, 6,  '2024-06-12', 'Tariq Mehmood',  'Pending', 'Logistics scenario test'),
(39, 11, 22, 13, '2024-05-30', 'Sana Qadir',     'Pending', 'Admin tasks walkthrough'),
(40, 13, 51, 19, '2024-06-25', 'Zara Anwar',     'Pending', 'Recruitment simulation'),
(41, 20, 34, 9,  '2024-09-20', 'Rabia Farooq',   'Pending', 'Sales pitch exercise'),
(42, 25, 39, 14, '2024-11-25', 'Imran Butt',     'Pending', 'Automation task'),
(43, 25, 40, 14, '2024-11-26', 'Imran Butt',     'Pending', 'Coding exercise assigned'),
(44, 17, 31, 8,  '2024-08-22', 'Zain Raza',      'Pending', 'Technical screening'),
(45, 19, 58, 6,  '2024-09-10', 'Tariq Mehmood',  'Pending', 'Ops case study'),
(46, 19, 33, 6,  '2024-09-12', 'Tariq Mehmood',  'Pending', 'Process improvement exercise'),
(47, 21, 59, 18, '2024-10-03', 'Owais Rana',     'Pending', 'Tax law quiz'),
(48, 8,  16, 10, '2024-05-01', 'Kamran Shah',    'Pending', 'Research task assigned'),
(49, 8,  17, 10, '2024-05-03', 'Kamran Shah',    'Pending', 'Data analysis challenge'),
(50, 15, 60, 17, '2024-07-26', 'Amna Sheikh',    'Pending', 'Marketing plan presentation'),
(51, 22, 54, 8,  '2024-10-14', 'Zain Raza',      'Pending', 'System design round'),
(52, 23, 55, 16, '2024-10-26', 'Hamza Siddiqui', 'Pending', 'Financial planning exercise'),
(53, 13, 25, 19, '2024-06-20', 'Zara Anwar',     'Pending', 'HR scenario test'),
(54, 20, 57, 9,  '2024-09-22', 'Rabia Farooq',   'Pending', 'CRM demo'),
(55, 10, 21, 3,  '2024-05-28', 'Sara Khan',      'Pending', 'Bookkeeping practical');

-- ─── Attendance (65 records) ─────────────────────────────────
INSERT INTO Attendance (attendance_id, employee_id, date, check_in_time, check_out_time, status) VALUES
(1,  1,  '2024-11-01', '09:02:00', '18:01:00', 'Present'),
(2,  2,  '2024-11-01', '08:55:00', '17:58:00', 'Present'),
(3,  3,  '2024-11-01', '09:10:00', '18:05:00', 'Present'),
(4,  4,  '2024-11-01', NULL,        NULL,       'Absent'),
(5,  5,  '2024-11-01', '09:00:00', '18:00:00', 'Present'),
(6,  6,  '2024-11-01', '09:15:00', '17:50:00', 'Present'),
(7,  7,  '2024-11-01', '09:30:00', '18:30:00', 'Late'),
(8,  8,  '2024-11-01', '08:45:00', '17:45:00', 'Present'),
(9,  9,  '2024-11-01', NULL,        NULL,       'Leave'),
(10, 10, '2024-11-01', '09:05:00', '18:10:00', 'Present'),
(11, 1,  '2024-11-04', '09:00:00', '18:00:00', 'Present'),
(12, 2,  '2024-11-04', '09:08:00', '17:55:00', 'Present'),
(13, 3,  '2024-11-04', NULL,        NULL,       'Leave'),
(14, 4,  '2024-11-04', '09:00:00', '18:05:00', 'Present'),
(15, 5,  '2024-11-04', '09:02:00', '18:02:00', 'Present'),
(16, 11, '2024-11-01', '09:00:00', '17:00:00', 'Present'),
(17, 12, '2024-11-01', '09:30:00', '18:30:00', 'Late'),
(18, 13, '2024-11-01', '09:00:00', '17:00:00', 'Present'),
(19, 14, '2024-11-01', '09:00:00', '18:00:00', 'Present'),
(20, 15, '2024-11-01', '09:05:00', '17:58:00', 'Present'),
(21, 16, '2024-11-01', '09:00:00', '18:00:00', 'Present'),
(22, 17, '2024-11-01', NULL,        NULL,       'Absent'),
(23, 18, '2024-11-01', '10:00:00', '19:00:00', 'Late'),
(24, 19, '2024-11-01', '09:00:00', '17:00:00', 'Present'),
(25, 20, '2024-11-01', '09:15:00', '18:10:00', 'Present'),
(26, 1,  '2024-11-05', '09:01:00', '18:00:00', 'Present'),
(27, 2,  '2024-11-05', '08:58:00', '17:56:00', 'Present'),
(28, 6,  '2024-11-05', NULL,        NULL,       'Absent'),
(29, 7,  '2024-11-05', '09:00:00', '17:00:00', 'Present'),
(30, 8,  '2024-11-05', '09:00:00', '18:00:00', 'Present'),
(31, 21, '2024-11-01', '09:20:00', '17:05:00', 'Present'),
(32, 22, '2024-11-01', '09:00:00', '18:00:00', 'Present'),
(33, 23, '2024-11-01', '09:00:00', '18:10:00', 'Present'),
(34, 24, '2024-11-01', '09:05:00', '17:55:00', 'Present'),
(35, 25, '2024-11-01', '09:00:00', '18:00:00', 'Present'),
(36, 1,  '2024-11-06', '09:00:00', '18:00:00', 'Present'),
(37, 2,  '2024-11-06', '09:00:00', '18:00:00', 'Present'),
(38, 3,  '2024-11-06', '09:00:00', '18:00:00', 'Present'),
(39, 4,  '2024-11-06', '09:10:00', '18:10:00', 'Present'),
(40, 5,  '2024-11-06', NULL,        NULL,       'Leave'),
(41, 10, '2024-11-04', '09:02:00', '18:02:00', 'Present'),
(42, 11, '2024-11-04', '09:00:00', '17:00:00', 'Present'),
(43, 12, '2024-11-04', '09:25:00', '18:25:00', 'Late'),
(44, 16, '2024-11-04', '09:00:00', '18:00:00', 'Present'),
(45, 18, '2024-11-04', '09:00:00', '18:00:00', 'Present'),
(46, 1,  '2024-11-07', '09:00:00', '18:00:00', 'Present'),
(47, 2,  '2024-11-07', '09:10:00', '18:10:00', 'Present'),
(48, 5,  '2024-11-07', '09:00:00', '18:00:00', 'Present'),
(49, 13, '2024-11-04', '09:00:00', '17:00:00', 'Present'),
(50, 14, '2024-11-04', '09:05:00', '18:00:00', 'Present'),
(51, 19, '2024-11-04', '09:00:00', '17:00:00', 'Present'),
(52, 20, '2024-11-04', '09:10:00', '17:55:00', 'Present'),
(53, 21, '2024-11-04', '09:00:00', '17:00:00', 'Present'),
(54, 24, '2024-11-04', '09:00:00', '18:00:00', 'Present'),
(55, 25, '2024-11-04', '09:00:00', '18:00:00', 'Present'),
(56, 6,  '2024-11-04', '09:15:00', '18:05:00', 'Present'),
(57, 7,  '2024-11-04', '09:00:00', '18:00:00', 'Present'),
(58, 9,  '2024-11-04', '09:00:00', '17:00:00', 'Present'),
(59, 15, '2024-11-04', '09:00:00', '18:00:00', 'Present'),
(60, 17, '2024-11-04', '09:00:00', '18:00:00', 'Present'),
(61, 1,  '2024-11-08', '09:00:00', '18:00:00', 'Present'),
(62, 2,  '2024-11-08', NULL,        NULL,       'Leave'),
(63, 8,  '2024-11-08', '09:00:00', '18:00:00', 'Present'),
(64, 16, '2024-11-08', '09:30:00', '18:30:00', 'Late'),
(65, 22, '2024-11-08', '09:00:00', '18:00:00', 'Present');

-- ─── Leave (55 records) ──────────────────────────────────────
INSERT INTO Leave (leave_id, employee_id, leave_type, start_date, end_date, reason, approved_status) VALUES
(1,1,'Annual','2024-08-05','2024-08-09','Family vacation','Approved'),
(2,2,'Sick','2024-07-10','2024-07-11','Fever and flu','Approved'),
(3,3,'Annual','2024-09-01','2024-09-03','Personal errands','Approved'),
(4,4,'Casual','2024-11-01','2024-11-01','Personal work','Approved'),
(5,5,'Annual','2024-10-14','2024-10-18','Vacation','Approved'),
(6,6,'Sick','2024-11-05','2024-11-05','Stomach ache','Approved'),
(7,7,'Casual','2024-06-20','2024-06-20','Utility appointment','Pending'),
(8,8,'Annual','2024-12-23','2024-12-27','End of year break','Pending'),
(9,9,'Annual','2024-11-01','2024-11-02','Travel','Approved'),
(10,10,'Sick','2024-04-03','2024-04-04','Headache','Approved'),
(11,11,'Casual','2024-05-15','2024-05-15','Personal errand','Approved'),
(12,12,'Annual','2024-07-22','2024-07-26','Family trip','Approved'),
(13,13,'Sick','2024-03-11','2024-03-11','Cold','Approved'),
(14,14,'Annual','2024-06-03','2024-06-07','Vacation','Approved'),
(15,15,'Casual','2024-08-19','2024-08-19','Bank work','Approved'),
(16,16,'Annual','2024-09-09','2024-09-13','Holiday','Approved'),
(17,17,'Sick','2024-11-01','2024-11-01','Fever','Approved'),
(18,18,'Casual','2024-10-01','2024-10-01','Personal errand','Approved'),
(19,19,'Annual','2024-07-15','2024-07-19','Family wedding','Approved'),
(20,20,'Sick','2024-04-22','2024-04-22','Headache','Approved'),
(21,1,'Sick','2024-03-05','2024-03-06','Back pain','Approved'),
(22,2,'Annual','2024-05-27','2024-05-31','Trip','Approved'),
(23,3,'Casual','2024-11-04','2024-11-04','Utility bills','Approved'),
(24,4,'Annual','2024-06-10','2024-06-14','Holiday','Approved'),
(25,5,'Sick','2024-02-08','2024-02-08','Flu','Approved'),
(26,21,'Casual','2024-10-10','2024-10-10','Appointment','Pending'),
(27,22,'Annual','2024-12-16','2024-12-20','Year-end break','Pending'),
(28,23,'Sick','2024-04-30','2024-04-30','Food poisoning','Approved'),
(29,24,'Casual','2024-07-08','2024-07-08','Personal matter','Approved'),
(30,25,'Annual','2024-08-26','2024-08-30','Family trip','Approved'),
(31,6,'Annual','2024-12-02','2024-12-06','Vacation','Pending'),
(32,7,'Sick','2024-09-16','2024-09-17','Cold','Approved'),
(33,8,'Casual','2024-10-28','2024-10-28','Personal','Approved'),
(34,9,'Sick','2024-05-13','2024-05-13','Migraine','Approved'),
(35,10,'Annual','2024-11-18','2024-11-22','Holiday','Pending'),
(36,11,'Annual','2024-12-09','2024-12-13','Year-end break','Pending'),
(37,12,'Casual','2024-09-23','2024-09-23','Bank appointment','Approved'),
(38,13,'Annual','2024-10-07','2024-10-11','Vacation','Approved'),
(39,14,'Sick','2024-11-12','2024-11-13','Flu','Approved'),
(40,15,'Annual','2024-12-02','2024-12-06','Trip','Pending'),
(41,16,'Casual','2024-11-25','2024-11-25','Personal','Pending'),
(42,17,'Annual','2024-10-21','2024-10-25','Vacation','Approved'),
(43,18,'Annual','2024-11-04','2024-11-08','Holiday','Approved'),
(44,19,'Sick','2024-09-03','2024-09-03','Fever','Approved'),
(45,20,'Annual','2024-10-28','2024-11-01','Eid break','Approved'),
(46,21,'Sick','2024-08-12','2024-08-12','Toothache','Approved'),
(47,22,'Casual','2024-07-01','2024-07-01','Personal matter','Approved'),
(48,23,'Annual','2024-08-19','2024-08-23','Family trip','Approved'),
(49,24,'Sick','2024-06-17','2024-06-17','Headache','Approved'),
(50,25,'Casual','2024-05-06','2024-05-06','Bank work','Approved'),
(51,1,'Annual','2024-12-23','2024-12-27','Year-end holiday','Pending'),
(52,2,'Casual','2024-11-07','2024-11-07','Personal','Approved'),
(53,3,'Sick','2024-12-02','2024-12-02','Fever','Pending'),
(54,5,'Annual','2024-11-06','2024-11-06','Short leave','Approved'),
(55,4,'Casual','2024-11-18','2024-11-18','Personal errand','Pending');
-- ─── Performance (30 records) ────────────────────────────────
INSERT INTO Performance (performance_id, employee_id, rating, review_start_time, review_end_time) VALUES
(1,1,4.5,'2024-01-01','2024-03-31'),
(2,2,4.0,'2024-01-01','2024-03-31'),
(3,3,3.5,'2024-01-01','2024-03-31'),
(4,4,4.2,'2024-01-01','2024-03-31'),
(5,5,4.8,'2024-01-01','2024-03-31'),
(6,6,3.8,'2024-01-01','2024-03-31'),
(7,7,3.2,'2024-01-01','2024-03-31'),
(8,8,4.9,'2024-01-01','2024-03-31'),
(9,9,3.6,'2024-01-01','2024-03-31'),
(10,10,4.1,'2024-01-01','2024-03-31'),
(11,1,4.3,'2024-04-01','2024-06-30'),
(12,2,4.1,'2024-04-01','2024-06-30'),
(13,5,4.7,'2024-04-01','2024-06-30'),
(14,8,4.9,'2024-04-01','2024-06-30'),
(15,16,4.0,'2024-01-01','2024-03-31'),
(16,17,3.9,'2024-01-01','2024-03-31'),
(17,18,4.5,'2024-01-01','2024-03-31'),
(18,12,4.3,'2024-01-01','2024-03-31'),
(19,25,4.6,'2024-01-01','2024-03-31'),
(20,11,3.4,'2024-01-01','2024-03-31'),
(21,13,3.7,'2024-01-01','2024-03-31'),
(22,14,4.0,'2024-04-01','2024-06-30'),
(23,15,4.2,'2024-04-01','2024-06-30'),
(24,19,3.8,'2024-04-01','2024-06-30'),
(25,20,3.5,'2024-04-01','2024-06-30'),
(26,21,3.3,'2024-04-01','2024-06-30'),
(27,22,3.6,'2024-04-01','2024-06-30'),
(28,23,4.0,'2024-04-01','2024-06-30'),
(29,24,4.2,'2024-04-01','2024-06-30'),
(30,10,4.3,'2024-04-01','2024-06-30');

-- ─── Comments (55 records) ───────────────────────────────────
INSERT INTO Comments (comment_id, performance_id, employee_id, comment) VALUES
(1,  1,  1,  'I am committed to maintaining high standards this quarter.'),
(2,  2,  2,  'I will work on client communication skills.'),
(3,  3,  3,  'I will ensure timely reconciliation reports.'),
(4,  4,  4,  'I will propose two new campaign ideas next quarter.'),
(5,  5,  5,  'Will focus on mentoring junior engineers.'),
(6,  6,  6,  'I will take ownership of new process initiatives.'),
(7,  7,  7,  'I will implement a daily task planner.'),
(8,  8,  8,  'Will continue driving sprint velocity improvements.'),
(9,  9,  9,  'Enrolling in advanced sales training this month.'),
(10, 10, 10, 'Proposing a new data analysis framework.'),
(11, 11, 1,  'Maintained consistent output. Will aim for 4.8 next quarter.'),
(12, 12, 2,  'Communication has visibly improved.'),
(13, 13, 5,  'Both features are now in production.'),
(14, 14, 8,  'Team morale is high, retention is strong.'),
(15, 15, 16, 'Financial audits completed ahead of schedule.'),
(16, 16, 17, 'Three campaigns launched with positive ROI.'),
(17, 17, 18, 'Tax savings of 15% achieved for the company.'),
(18, 18, 12, 'No compliance issues this quarter.'),
(19, 19, 25, 'Hired 5 qualified candidates this quarter.'),
(20, 20, 11, 'CSAT score reached 78%, up from 65%.'),
(21, 21, 13, 'Office operations running smoothly.'),
(22, 22, 14, 'Bug count reduced by 30%.'),
(23, 23, 15, 'Zero deployment failures this quarter.'),
(24, 24, 19, 'Will focus on sourcing quality candidates.'),
(25, 25, 20, 'New logistics vendor onboarded successfully.'),
(26, 26, 21, 'Still learning, will perform better next quarter.'),
(27, 27, 22, 'Customer retention improved with new scripts.'),
(28, 28, 23, 'Submitted 4 research reports on time.'),
(29, 29, 24, 'Code review scores are consistently above 90%.'),
(30, 30, 10, 'Submitted proposal for new research collaboration.'),
(31, 1,  25, 'Aisha demonstrates excellent leadership abilities.'),
(32, 2,  8,  'Usman has strong backend delivery skills.'),
(33, 5,  8,  'Hina is our strongest senior engineer.'),
(34, 8,  25, 'Zain is invaluable as team lead.'),
(35, 15, 25, 'Hamza ensures rigorous financial reporting.'),
(36, 18, 25, 'Ali''s legal guidance is always precise.'),
(37, 19, 25, 'Lubna is a cornerstone of the HR team.'),
(38, 3,  25, 'Sara needs to improve turnaround times.'),
(39, 7,  1,  'Nadia should seek time-management coaching.'),
(40, 9,  17, 'Rabia should pursue more sales training.'),
(41, 20, 1,  'Fatima is making good progress in customer handling.'),
(42, 24, 1,  'Zara is getting better at candidate sourcing.'),
(43, 26, 1,  'Iqra is showing good learning attitude.'),
(44, 25, 6,  'Shoaib should look at automating logistics tracking.'),
(45, 10, 25, 'Kamran produces reliable research output.'),
(46, 11, 1,  'Aisha is performing consistently well.'),
(47, 12, 25, 'Usman is a strong technical resource.'),
(48, 13, 8,  'Hina''s feature delivery was flawless.'),
(49, 14, 1,  'Zain''s leadership was exceptional this quarter.'),
(50, 16, 25, 'Amna''s campaign metrics exceeded expectations.'),
(51, 17, 1,  'Owais'' tax strategy saved significant costs.'),
(52, 21, 25, 'Sana keeps the office running efficiently.'),
(53, 23, 25, 'Maham''s DevOps improvements are significant.'),
(54, 22, 8,  'Imran has reduced the bug backlog well.'),
(55, 29, 8,  'Faisal has become a reliable developer.');

-- ─── Training (55 records) ───────────────────────────────────
INSERT INTO Training (training_id, performance_id, employee_id, training_title, trainer_name, start_date, end_date, description) VALUES
(1,  1,  1,  'HR Leadership Program',          'Dr. Hasan',        '2024-04-15', '2024-04-19', 'Covers strategic HR management'),
(2,  2,  2,  'Advanced Python Workshop',       'Prof. Ali Raza',   '2024-04-22', '2024-04-26', 'Deep-dive into Python frameworks'),
(3,  3,  3,  'Financial Reconciliation Seminar','CA Naeem',        '2024-05-06', '2024-05-07', 'Best practices in account reconciliation'),
(4,  4,  4,  'Digital Marketing Bootcamp',     'Trainer Sobia',    '2024-05-13', '2024-05-17', 'SEO, SEM and social media strategies'),
(5,  5,  5,  'System Design Masterclass',      'Eng. Tariq',       '2024-04-29', '2024-05-03', 'Architecture patterns for scalable systems'),
(6,  6,  6,  'Leadership & Initiative',        'Coach Farhan',     '2024-05-20', '2024-05-21', 'Building ownership mindset'),
(7,  7,  7,  'Time Management Workshop',       'Trainer Isha',     '2024-05-27', '2024-05-27', 'Personal productivity techniques'),
(8,  8,  8,  'Agile & Scrum Certification',    'Agile Coach Omer', '2024-06-03', '2024-06-07', 'Scrum master preparation'),
(9,  9,  9,  'Sales Techniques Training',      'Mr. Kamal',        '2024-06-10', '2024-06-11', 'Consultative selling approach'),
(10, 10, 10, 'Data Analysis with Python',      'Prof. Shirin',     '2024-06-17', '2024-06-21', 'Pandas, NumPy, visualization'),
(11, 11, 1,  'Conflict Resolution Workshop',   'Dr. Hasan',        '2024-07-08', '2024-07-08', 'HR conflict handling strategies'),
(12, 12, 2,  'Client Communication Training',  'Trainer Waleed',   '2024-07-15', '2024-07-15', 'Effective client interaction'),
(13, 13, 5,  'AWS Cloud Practitioner',         'Eng. Zubair',      '2024-07-22', '2024-07-26', 'AWS fundamentals and certification prep'),
(14, 14, 8,  'Engineering Management',         'Coach Shahzad',    '2024-07-29', '2024-08-02', 'People and project management for leads'),
(15, 15, 16, 'IFRS Update Seminar',            'CA Bilal Ahmad',   '2024-04-08', '2024-04-09', 'Latest IFRS changes and their impact'),
(16, 16, 17, 'Brand Strategy Workshop',        'Trainer Asma',     '2024-04-15', '2024-04-16', 'Building strong brand identity'),
(17, 17, 18, 'Corporate Tax Planning',         'Tax Expert Noor',  '2024-04-22', '2024-04-26', 'Tax optimization strategies'),
(18, 18, 12, 'Corporate Law Refresher',        'Adv. Rana',        '2024-05-06', '2024-05-07', 'Key updates in company law'),
(19, 19, 25, 'Talent Acquisition Strategies',  'HR Coach Sara',    '2024-05-13', '2024-05-14', 'Modern sourcing and screening'),
(20, 20, 11, 'Customer Service Excellence',    'Trainer Jamila',   '2024-05-20', '2024-05-21', 'Handling difficult customers'),
(21, 21, 13, 'Office Administration Best Practices','Trainer Sana','2024-05-27', '2024-05-27', 'Efficient office management'),
(22, 22, 14, 'Selenium Test Automation',       'QA Lead Haris',    '2024-06-03', '2024-06-07', 'End-to-end test automation'),
(23, 23, 15, 'Kubernetes & Docker',            'DevOps Sami',      '2024-06-10', '2024-06-14', 'Container orchestration'),
(24, 24, 19, 'Boolean Sourcing Techniques',    'Recruiter Rabia',  '2024-06-24', '2024-06-24', 'Advanced search for candidates'),
(25, 25, 20, 'Supply Chain Fundamentals',      'Trainer Azhar',    '2024-07-01', '2024-07-02', 'Basics of supply chain management'),
(26, NULL,21,'Onboarding Training',            'HR Team',          '2024-01-08', '2024-01-12', 'Company policies and procedures'),
(27, NULL,22,'Customer Support Essentials',    'Trainer Jamila',   '2024-07-22', '2024-07-23', 'Call handling and empathy training'),
(28, 28, 23, 'Research Methodologies',         'Prof. Saima',      '2024-07-15', '2024-07-19', 'Qualitative and quantitative methods'),
(29, 29, 24, 'Code Review Best Practices',     'Eng. Tariq',       '2024-07-08', '2024-07-08', 'Clean code principles'),
(30, 30, 10, 'Machine Learning Basics',        'Prof. Shirin',     '2024-08-05', '2024-08-09', 'Introduction to ML algorithms'),
(31, NULL, 2,'Node.js Advanced Workshop',      'Trainer Faisal',   '2024-08-12', '2024-08-16', 'REST APIs and microservices'),
(32, NULL, 5,'React Advanced Patterns',        'Trainer Noman',    '2024-08-19', '2024-08-23', 'Hooks, context, performance'),
(33, NULL, 8,'Cybersecurity Awareness',        'Sec. Expert Zaid', '2024-08-26', '2024-08-27', 'Phishing, passwords, data safety'),
(34, NULL,14,'Playwright Automation',          'QA Lead Haris',    '2024-09-02', '2024-09-06', 'Modern browser automation'),
(35, NULL,15,'Terraform IaC',                  'DevOps Sami',      '2024-09-09', '2024-09-13', 'Infrastructure as code'),
(36, NULL, 3,'Advanced Excel for Finance',     'CA Naeem',         '2024-09-16', '2024-09-17', 'Pivot tables, macros, financial models'),
(37, NULL, 4,'Google Ads Certification',       'Trainer Sobia',    '2024-09-23', '2024-09-24', 'PPC campaign management'),
(38, NULL, 6,'Process Improvement',            'Trainer Azhar',    '2024-09-30', '2024-09-30', 'Lean and six sigma basics'),
(39, NULL, 7,'Workplace Wellness',             'Dr. Nadia',        '2024-10-07', '2024-10-07', 'Mental health and stress management'),
(40, NULL, 9,'CRM Tools Training',             'Trainer Kamran',   '2024-10-14', '2024-10-15', 'Salesforce and HubSpot basics'),
(41, NULL,16,'Power BI for Finance',           'Data Trainer',     '2024-10-21', '2024-10-22', 'Financial dashboards in Power BI'),
(42, NULL,17,'Content Marketing Workshop',     'Trainer Asma',     '2024-10-28', '2024-10-28', 'Video, blog and email marketing'),
(43, NULL,19,'ATS Software Training',          'Recruiter Rabia',  '2024-11-04', '2024-11-04', 'Applicant tracking system usage'),
(44, NULL,20,'Warehouse Management',           'Trainer Azhar',    '2024-11-11', '2024-11-12', 'Inventory and warehousing'),
(45, NULL,18,'Tax Compliance Update 2025',     'Tax Expert Noor',  '2024-11-18', '2024-11-18', 'Latest FBR regulations'),
(46, NULL,12,'Contract Drafting Workshop',     'Adv. Rana',        '2024-11-25', '2024-11-26', 'Contract law and templates'),
(47, NULL,13,'Event Management Basics',        'Trainer Sana',     '2024-12-02', '2024-12-02', 'Corporate event planning'),
(48, NULL,11,'Advanced CX Training',           'Trainer Jamila',   '2024-12-09', '2024-12-10', 'Customer experience strategies'),
(49, NULL,23,'Statistical Analysis',           'Prof. Saima',      '2024-12-03', '2024-12-06', 'Regression and hypothesis testing'),
(50, NULL,24,'Microservices Architecture',     'Eng. Tariq',       '2024-12-09', '2024-12-13', 'Service decomposition patterns'),
(51, NULL,25,'HR Analytics',                   'HR Coach Sara',    '2024-12-16', '2024-12-17', 'People analytics and dashboards'),
(52, NULL,10,'Deep Learning Fundamentals',     'Prof. Shirin',     '2024-12-02', '2024-12-06', 'Neural networks and backpropagation'),
(53, NULL,21,'Advanced Sales Closing',         'Mr. Kamal',        '2024-12-09', '2024-12-09', 'Objection handling techniques'),
(54, NULL,22,'Empathy in Customer Service',    'Trainer Jamila',   '2024-12-16', '2024-12-16', 'Customer empathy mapping'),
(55, NULL,15,'CI/CD with GitHub Actions',      'DevOps Sami',      '2024-12-02', '2024-12-03', 'Automated pipelines');

-- ─── Payroll (55 records) ────────────────────────────────────
INSERT INTO Payroll (payroll_id, employee_id, payroll_month, basic_salary, total_deductions, net_salary) VALUES
(1,  1,  'November-2024',   95000, 12000, 83000),
(2,  2,  'November-2024',   85000, 11000, 74000),
(3,  3,  'November-2024',   60000,  8000, 52000),
(4,  4,  'November-2024',   55000,  7500, 47500),
(5,  5,  'November-2024',  130000, 17000,113000),
(6,  6,  'November-2024',   62000,  8200, 53800),
(7,  7,  'November-2024',   48000,  6500, 41500),
(8,  8,  'November-2024',  155000, 20000,135000),
(9,  9,  'November-2024',   45000,  6000, 39000),
(10, 10, 'November-2024',   78000, 10000, 68000),
(11, 11, 'November-2024',   38000,  5000, 33000),
(12, 12, 'November-2024',  130000, 18000,112000),
(13, 13, 'November-2024',   58000,  7800, 50200),
(14, 14, 'November-2024',   78000, 10500, 67500),
(15, 15, 'November-2024',   88000, 11500, 76500),
(16, 16, 'November-2024',  120000, 16000,104000),
(17, 17, 'November-2024',  100000, 13500, 86500),
(18, 18, 'November-2024',  110000, 14500, 95500),
(19, 19, 'November-2024',   65000,  8500, 56500),
(20, 20, 'November-2024',   50000,  6800, 43200),
(21, 21, 'November-2024',   42000,  5500, 36500),
(22, 22, 'November-2024',   35000,  4500, 30500),
(23, 23, 'November-2024',   82000, 10800, 71200),
(24, 24, 'November-2024',   88000, 11500, 76500),
(25, 25, 'November-2024',  105000, 14000, 91000),
(26, 1,  'October-2024',    95000, 12000, 83000),
(27, 2,  'October-2024',    85000, 11000, 74000),
(28, 3,  'October-2024',    60000,  8000, 52000),
(29, 5,  'October-2024',   130000, 17000,113000),
(30, 8,  'October-2024',   155000, 20000,135000),
(31, 16, 'October-2024',   120000, 16000,104000),
(32, 18, 'October-2024',   110000, 14500, 95500),
(33, 25, 'October-2024',   105000, 14000, 91000),
(34, 12, 'October-2024',   130000, 18000,112000),
(35, 17, 'October-2024',   100000, 13500, 86500),
(36, 4,  'October-2024',    55000,  7500, 47500),
(37, 6,  'October-2024',    62000,  8200, 53800),
(38, 7,  'October-2024',    48000,  6500, 41500),
(39, 9,  'October-2024',    45000,  6000, 39000),
(40, 10, 'October-2024',    78000, 10000, 68000),
(41, 11, 'October-2024',    38000,  5000, 33000),
(42, 13, 'October-2024',    58000,  7800, 50200),
(43, 14, 'October-2024',    78000, 10500, 67500),
(44, 15, 'October-2024',    88000, 11500, 76500),
(45, 19, 'October-2024',    65000,  8500, 56500),
(46, 20, 'October-2024',    50000,  6800, 43200),
(47, 21, 'October-2024',    42000,  5500, 36500),
(48, 22, 'October-2024',    35000,  4500, 30500),
(49, 23, 'October-2024',    82000, 10800, 71200),
(50, 24, 'October-2024',    88000, 11500, 76500),
(51, 1,  'September-2024',  95000, 12000, 83000),
(52, 2,  'September-2024',  85000, 11000, 74000),
(53, 5,  'September-2024', 130000, 17000,113000),
(54, 8,  'September-2024', 155000, 20000,135000),
(55, 25, 'September-2024', 105000, 14000, 91000);

-- ─── Payroll_Deduction ───────────────────────────────────────
INSERT INTO Payroll_Deduction (payroll_id, deduction_id, amount) VALUES
(1,  1, 7000),(1,  2, 3000),(1,  3, 2000),
(2,  1, 6500),(2,  2, 2800),(2,  3, 1700),
(3,  1, 4000),(3,  2, 2000),(3,  3, 2000),
(4,  1, 4500),(4,  2, 1500),(4,  3, 1500),
(5,  1,10000),(5,  2, 4000),(5,  3, 3000),
(6,  1, 5000),(6,  2, 1800),(6,  3, 1400),
(7,  1, 3500),(7,  2, 1500),(7,  3, 1500),
(8,  1,12000),(8,  2, 4000),(8,  3, 4000),
(9,  1, 3000),(9,  2, 1500),(9,  3, 1500),
(10, 1, 6000),(10, 2, 2200),(10, 3, 1800),
(11, 1, 3000),(11, 2, 1000),(11, 3, 1000),
(12, 1,11000),(12, 2, 4000),(12, 3, 3000),
(13, 1, 4500),(13, 2, 1800),(13, 3, 1500),
(14, 1, 6000),(14, 2, 2500),(14, 3, 2000),
(15, 1, 7000),(15, 2, 2500),(15, 3, 2000),
(16, 1,10000),(16, 2, 3500),(16, 3, 2500),
(17, 1, 8000),(17, 2, 3000),(17, 3, 2500),
(18, 1, 9000),(18, 2, 3000),(18, 3, 2500),
(19, 1, 5000),(19, 2, 2000),(19, 3, 1500),
(20, 1, 4000),(20, 2, 1500),(20, 3, 1300);

-- ─── Payroll_Allowance ───────────────────────────────────────
INSERT INTO Payroll_Allowance (payroll_id, allowance_id, amount) VALUES
(1,  1, 20000),(1,  2, 5000),(1,  3, 3000),
(2,  1, 18000),(2,  2, 4000),(2,  3, 2500),
(3,  1, 12000),(3,  2, 3000),(3,  3, 2000),
(4,  1, 10000),(4,  2, 3000),(4,  3, 1500),
(5,  1, 30000),(5,  2, 8000),(5,  3, 5000),(5,  5, 10000),
(6,  1, 12000),(6,  2, 3000),(6,  3, 2000),
(7,  1,  8000),(7,  2, 2500),(7,  3, 1500),
(8,  1, 35000),(8,  2,10000),(8,  3, 6000),(8,  5, 15000),
(9,  1,  8000),(9,  2, 2000),(9,  3, 1500),
(10, 1, 15000),(10, 2, 4000),(10, 3, 3000),
(11, 1,  6000),(11, 2, 2000),(11, 3, 1000),
(12, 1, 25000),(12, 2, 7000),(12, 3, 4000),(12, 5, 8000),
(13, 1, 10000),(13, 2, 3000),(13, 3, 2000),
(14, 1, 15000),(14, 2, 4000),(14, 3, 3000),
(15, 1, 18000),(15, 2, 5000),(15, 3, 3000),
(16, 1, 24000),(16, 2, 6000),(16, 3, 4000),(16, 5, 8000),
(17, 1, 20000),(17, 2, 5000),(17, 3, 3500),
(18, 1, 22000),(18, 2, 6000),(18, 3, 4000),
(19, 1, 12000),(19, 2, 3500),(19, 3, 2500),
(20, 1,  9000),(20, 2, 3000),(20, 3, 2000);

-- ─── Salary_Slip (55 records) ────────────────────────────────
INSERT INTO Salary_Slip (slip_id, payroll_id, employee_id, generation_date, slip_month, net_salary) VALUES
(1,  1,  1,  '2024-11-30', 'November-2024',  83000),
(2,  2,  2,  '2024-11-30', 'November-2024',  74000),
(3,  3,  3,  '2024-11-30', 'November-2024',  52000),
(4,  4,  4,  '2024-11-30', 'November-2024',  47500),
(5,  5,  5,  '2024-11-30', 'November-2024', 113000),
(6,  6,  6,  '2024-11-30', 'November-2024',  53800),
(7,  7,  7,  '2024-11-30', 'November-2024',  41500),
(8,  8,  8,  '2024-11-30', 'November-2024', 135000),
(9,  9,  9,  '2024-11-30', 'November-2024',  39000),
(10, 10, 10, '2024-11-30', 'November-2024',  68000),
(11, 11, 11, '2024-11-30', 'November-2024',  33000),
(12, 12, 12, '2024-11-30', 'November-2024', 112000),
(13, 13, 13, '2024-11-30', 'November-2024',  50200),
(14, 14, 14, '2024-11-30', 'November-2024',  67500),
(15, 15, 15, '2024-11-30', 'November-2024',  76500),
(16, 16, 16, '2024-11-30', 'November-2024', 104000),
(17, 17, 17, '2024-11-30', 'November-2024',  86500),
(18, 18, 18, '2024-11-30', 'November-2024',  95500),
(19, 19, 19, '2024-11-30', 'November-2024',  56500),
(20, 20, 20, '2024-11-30', 'November-2024',  43200),
(21, 21, 21, '2024-11-30', 'November-2024',  36500),
(22, 22, 22, '2024-11-30', 'November-2024',  30500),
(23, 23, 23, '2024-11-30', 'November-2024',  71200),
(24, 24, 24, '2024-11-30', 'November-2024',  76500),
(25, 25, 25, '2024-11-30', 'November-2024',  91000),
(26, 26, 1,  '2024-10-31', 'October-2024',   83000),
(27, 27, 2,  '2024-10-31', 'October-2024',   74000),
(28, 28, 3,  '2024-10-31', 'October-2024',   52000),
(29, 29, 5,  '2024-10-31', 'October-2024',  113000),
(30, 30, 8,  '2024-10-31', 'October-2024',  135000),
(31, 31, 16, '2024-10-31', 'October-2024',  104000),
(32, 32, 18, '2024-10-31', 'October-2024',   95500),
(33, 33, 25, '2024-10-31', 'October-2024',   91000),
(34, 34, 12, '2024-10-31', 'October-2024',  112000),
(35, 35, 17, '2024-10-31', 'October-2024',   86500),
(36, 36, 4,  '2024-10-31', 'October-2024',   47500),
(37, 37, 6,  '2024-10-31', 'October-2024',   53800),
(38, 38, 7,  '2024-10-31', 'October-2024',   41500),
(39, 39, 9,  '2024-10-31', 'October-2024',   39000),
(40, 40, 10, '2024-10-31', 'October-2024',   68000),
(41, 41, 11, '2024-10-31', 'October-2024',   33000),
(42, 42, 13, '2024-10-31', 'October-2024',   50200),
(43, 43, 14, '2024-10-31', 'October-2024',   67500),
(44, 44, 15, '2024-10-31', 'October-2024',   76500),
(45, 45, 19, '2024-10-31', 'October-2024',   56500),
(46, 46, 20, '2024-10-31', 'October-2024',   43200),
(47, 47, 21, '2024-10-31', 'October-2024',   36500),
(48, 48, 22, '2024-10-31', 'October-2024',   30500),
(49, 49, 23, '2024-10-31', 'October-2024',   71200),
(50, 50, 24, '2024-10-31', 'October-2024',   76500),
(51, 51, 1,  '2024-09-30', 'September-2024', 83000),
(52, 52, 2,  '2024-09-30', 'September-2024', 74000),
(53, 53, 5,  '2024-09-30', 'September-2024',113000),
(54, 54, 8,  '2024-09-30', 'September-2024',135000),
(55, 55, 25, '2024-09-30', 'September-2024', 91000);


-- SECTION 5 : 20 REPORTING QUERIES


-- Query 1 (Simple SELECT): List all employees with their names and emails
SELECT employee_id, emp_name, email, employment_status
FROM Employee
ORDER BY emp_name;

-- Query 2 (WHERE condition): Find all active employees hired after 2018
SELECT employee_id, emp_name, hire_date, employment_status
FROM Employee
WHERE employment_status = 'Active'
  AND hire_date > '2018-01-01'
ORDER BY hire_date;

-- Query 3 (WHERE with LIKE): Search employees by partial name
SELECT employee_id, emp_name, email
FROM Employee
WHERE emp_name LIKE '%Ali%'
   OR emp_name LIKE '%Malik%';

-- Query 4 (JOIN 2 tables): List employees with their department names
SELECT e.employee_id, e.emp_name, d.dept_name, d.location
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id
ORDER BY d.dept_name, e.emp_name;

-- Query 5 (JOIN 3 tables): Employee name, department, designation
SELECT e.emp_name, d.dept_name, dg.job_title, dg.seniority_level
FROM Employee e
JOIN Department d   ON e.dept_id        = d.dept_id
JOIN Designation dg ON e.designation_id = dg.designation_id
ORDER BY d.dept_name;

-- Query 6 (GROUP BY): Total employees per department
SELECT d.dept_name, COUNT(e.employee_id) AS total_employees
FROM Department d
LEFT JOIN Employee e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY total_employees DESC;

-- Query 7 (GROUP BY with HAVING): Departments with more than 2 employees
SELECT d.dept_name, COUNT(e.employee_id) AS total_employees
FROM Department d
JOIN Employee e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING COUNT(e.employee_id) > 2
ORDER BY total_employees DESC;

-- Query 8 : Average, min, and max net salary by department
SELECT d.dept_name,
       ROUND(AVG(p.net_salary), 2) AS avg_net_salary,
       MIN(p.net_salary)           AS min_net_salary,
       MAX(p.net_salary)           AS max_net_salary
FROM Payroll p
JOIN Employee e    ON p.employee_id = e.employee_id
JOIN Department d  ON e.dept_id     = d.dept_id
WHERE p.payroll_month = 'November-2024'
GROUP BY d.dept_name
ORDER BY avg_net_salary DESC;

-- Query 9 (JOIN + Aggregation): Total payroll cost per department for November 2024
SELECT d.dept_name,
       SUM(p.net_salary)  AS total_net_payout,
       SUM(p.basic_salary) AS total_basic,
       SUM(p.total_deductions) AS total_deductions
FROM Payroll p
JOIN Employee e   ON p.employee_id = e.employee_id
JOIN Department d ON e.dept_id     = d.dept_id
WHERE p.payroll_month = 'November-2024'
GROUP BY d.dept_name
ORDER BY total_net_payout DESC;

-- Query 10 (Subquery): Employees earning above the company average net salary
SELECT e.emp_name, d.dept_name, p.net_salary
FROM Employee e
JOIN Payroll p    ON e.employee_id = p.employee_id
JOIN Department d ON e.dept_id     = d.dept_id
WHERE p.payroll_month = 'November-2024'
  AND p.net_salary > (
      SELECT AVG(net_salary) FROM Payroll WHERE payroll_month = 'November-2024'
  )
ORDER BY p.net_salary DESC;

-- Query 11 (Attendance summary): Attendance count by status per employee for November 2024
SELECT e.emp_name,
       SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS present_days,
       SUM(CASE WHEN a.status = 'Absent'  THEN 1 ELSE 0 END) AS absent_days,
       SUM(CASE WHEN a.status = 'Late'    THEN 1 ELSE 0 END) AS late_days,
       SUM(CASE WHEN a.status = 'Leave'   THEN 1 ELSE 0 END) AS leave_days
FROM Employee e
LEFT JOIN Attendance a ON e.employee_id = a.employee_id
                       AND a.date BETWEEN '2024-11-01' AND '2024-11-30'
GROUP BY e.emp_name
ORDER BY absent_days DESC;

-- Query 12 (Leave report): Pending leave requests with employee and department info
SELECT l.leave_id, e.emp_name, d.dept_name,
       l.leave_type, l.start_date, l.end_date, l.reason
FROM Leave l
JOIN Employee e   ON l.employee_id = e.employee_id
JOIN Department d ON e.dept_id     = d.dept_id
WHERE l.approved_status = 'Pending'
ORDER BY l.start_date;

-- Query 13 (Performance ranking): Top employees by latest performance rating
SELECT e.emp_name,
       d.dept_name,
       p.rating,
       p.review_start_time,
       p.review_end_time
FROM Performance p
JOIN Employee e ON p.employee_id = e.employee_id
JOIN Department d ON e.dept_id = d.dept_id
ORDER BY p.review_end_time DESC, p.rating DESC;

-- Query 14 (Recruitment funnel): Applications count by status per job posting
SELECT jp.job_title, jp.dept_id,
       COUNT(r.recruitment_id)                                              AS total_applications,
       SUM(CASE WHEN r.status = 'Hired'       THEN 1 ELSE 0 END)           AS hired,
       SUM(CASE WHEN r.status = 'Shortlisted' THEN 1 ELSE 0 END)           AS shortlisted,
       SUM(CASE WHEN r.status = 'In Review'   THEN 1 ELSE 0 END)           AS in_review,
       SUM(CASE WHEN r.status = 'Rejected'    THEN 1 ELSE 0 END)           AS rejected
FROM Job_Posting jp
LEFT JOIN Recruitment r ON jp.job_id = r.job_id
GROUP BY jp.job_id, jp.job_title, jp.dept_id
ORDER BY total_applications DESC;

-- Query 15 (Nested subquery): Employees who have never taken any leave
SELECT employee_id, emp_name, hire_date
FROM Employee
WHERE employee_id NOT IN (
    SELECT DISTINCT employee_id FROM Leave
)
ORDER BY emp_name;

-- Query 16 (Multi-join + subquery): Candidates interviewed but not yet hired
SELECT c.candidate_id,
       CONCAT(c.candidate_firstname, ' ', c.candidate_lastname) AS candidate_name,
       jp.job_title,
       i.interview_date,
       i.result,
       r.status AS recruitment_status
FROM Candidate c
JOIN Recruitment r  ON c.candidate_id = r.candidate_id
JOIN Job_Posting jp ON r.job_id       = jp.job_id
JOIN Interview i    ON c.candidate_id = i.candidate_id
                    AND i.job_id      = r.job_id
WHERE r.status <> 'Hired'
ORDER BY i.interview_date DESC;

-- Query 17 (Training report): Number of training sessions per employee with total days
SELECT e.emp_name, 
       d.dept_name,
       COUNT(t.training_id) AS total_trainings,
       SUM(DATEDIFF(day, t.start_date, t.end_date) + 1) AS total_training_days
FROM Training t
JOIN Employee e ON t.employee_id = e.employee_id
JOIN Department d ON e.dept_id = d.dept_id
GROUP BY e.emp_name, d.dept_name
ORDER BY total_trainings DESC;

-- Query 18 (Salary slip report): Employees with salary slips generated for all 3 months
SELECT e.emp_name,
       COUNT(DISTINCT ss.slip_month) AS months_with_slip,
       SUM(ss.net_salary)            AS total_paid_3_months
FROM Salary_Slip ss
JOIN Employee e ON ss.employee_id = e.employee_id
WHERE ss.slip_month IN ('November-2024','October-2024','September-2024')
GROUP BY e.emp_name
HAVING COUNT(DISTINCT ss.slip_month) = 3
ORDER BY total_paid_3_months DESC;

-- Query 19 (Complex multi-join): Full employee profile — name, dept, designation,
--           role, latest performance rating, and November net salary
SELECT 
    e.emp_name,
    d.dept_name,
    dg.job_title,
    dg.seniority_level,
    r.role_name,
    ISNULL(perf_latest.rating, 0) AS latest_rating,
    ISNULL(p.net_salary, 0) AS nov_2024_net_salary
FROM Employee e
INNER JOIN Department d ON e.dept_id = d.dept_id
INNER JOIN Designation dg ON e.designation_id = dg.designation_id
INNER JOIN Users u ON e.employee_id = u.employee_id
INNER JOIN Role r ON u.role_id = r.role_id
LEFT JOIN Payroll p ON e.employee_id = p.employee_id AND p.payroll_month = 'November-2024'
LEFT JOIN (
    SELECT employee_id, MAX(rating) AS rating
    FROM Performance
    GROUP BY employee_id
) perf_latest ON e.employee_id = perf_latest.employee_id
ORDER BY d.dept_name, e.emp_name;

-- Query 20 (Advanced aggregation + HAVING): Departments where average performance
--           rating is below 4.0 and total deductions exceed 50,000 in November 2024
SELECT d.dept_name,
       ROUND(AVG(perf.rating), 2)  AS avg_performance_rating,
       SUM(p.total_deductions)     AS total_dept_deductions,
       COUNT(e.employee_id)        AS headcount
FROM Department d
JOIN Employee e    ON d.dept_id     = e.dept_id
JOIN Payroll  p    ON e.employee_id = p.employee_id
                   AND p.payroll_month = 'November-2024'
LEFT JOIN Performance perf ON e.employee_id = perf.employee_id
GROUP BY d.dept_name
HAVING AVG(perf.rating) < 4.0
   AND SUM(p.total_deductions) > 50000
ORDER BY avg_performance_rating ASC;

