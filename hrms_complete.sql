create database db;
use db;
-- 1. DEPARTMENT
CREATE TABLE DEPARTMENT (
    dept_id       INT            NOT NULL,
    dept_name     VARCHAR(100)   NOT NULL,
    location      VARCHAR(150),
    CONSTRAINT pk_department PRIMARY KEY (dept_id)
);

-- 2. DESIGNATION
CREATE TABLE DESIGNATION (
    designation_id   INT           NOT NULL,
    dept_id          INT           NOT NULL,
    job_title        VARCHAR(100)  NOT NULL,
    min_salary       DECIMAL(12,2),
    max_salary       DECIMAL(12,2),
    CONSTRAINT pk_designation PRIMARY KEY (designation_id)
);

-- 3. EMPLOYEE
CREATE TABLE EMPLOYEE (
    employee_id        INT           NOT NULL,
    dept_id            INT           NOT NULL,
    designation_id     INT           NOT NULL,
    manager_id         INT,
    emp_first_name     VARCHAR(50)   NOT NULL,
    emp_last_name      VARCHAR(50)   NOT NULL,
    gender             CHAR(1),
    dob                DATE,
    email              VARCHAR(150),
    nid                VARCHAR(30),
    skills             VARCHAR(255),
    face_data          VARCHAR(255),
    employment_status  VARCHAR(30)   DEFAULT 'Active',
    hire_date          DATE,
    date_of_birth      DATE,
    mode_of_hire       VARCHAR(50),
    CONSTRAINT pk_employee PRIMARY KEY (employee_id)
);

-- 4. EMPLOYEE_EMAIL  (multivalued)
CREATE TABLE EMPLOYEE_EMAIL (
    employee_id  INT           NOT NULL,
    email        VARCHAR(150)  NOT NULL,
    CONSTRAINT pk_emp_email PRIMARY KEY (employee_id, email)
);

-- 5. EMPLOYEE_PHONE  (multivalued)
CREATE TABLE EMPLOYEE_PHONE (
    employee_id  INT          NOT NULL,
    phone        VARCHAR(20)  NOT NULL,
    CONSTRAINT pk_emp_phone PRIMARY KEY (employee_id, phone)
);

-- 6. ROLE
CREATE TABLE ROLE (
    role_id    INT           NOT NULL,
    role_name  VARCHAR(80)   NOT NULL,
    CONSTRAINT pk_role PRIMARY KEY (role_id)
);

-- 7. PERMISSION
CREATE TABLE PERMISSION (
    permission_id    INT           NOT NULL,
    permission_name  VARCHAR(100)  NOT NULL,
    CONSTRAINT pk_permission PRIMARY KEY (permission_id)
);

-- 8. ROLE_PERMISSION  (junction)
CREATE TABLE ROLE_PERMISSION (
    role_id        INT  NOT NULL,
    permission_id  INT  NOT NULL,
    CONSTRAINT pk_role_permission PRIMARY KEY (role_id, permission_id)
);

-- 9. USER
CREATE TABLE "USER" (
    user_id       INT           NOT NULL,
    role_id       INT           NOT NULL,
    employee_id   INT,
    username      VARCHAR(80)   NOT NULL,
    password_hash VARCHAR(255)  NOT NULL,
    CONSTRAINT pk_user PRIMARY KEY (user_id)
);

-- 10. ATTENDANCE
CREATE TABLE ATTENDANCE (
    attendance_id  INT          NOT NULL,
    employee_id    INT          NOT NULL,
    date           DATE         NOT NULL,
    check_in_time  TIME,
    check_out_time TIME,
    status         VARCHAR(20)  DEFAULT 'Present',
    CONSTRAINT pk_attendance PRIMARY KEY (attendance_id)
);

-- 11. LEAVE
CREATE TABLE LEAVE (
    leave_id       INT           NOT NULL,
    employee_id    INT           NOT NULL,
    leave_type     VARCHAR(50),
    start_date     DATE          NOT NULL,
    end_date       DATE          NOT NULL,
    status         VARCHAR(20)   DEFAULT 'Pending',
    approved_admin INT,
    CONSTRAINT pk_leave PRIMARY KEY (leave_id)
);

-- 12. PERFORMANCE
CREATE TABLE PERFORMANCE (
    performance_id    INT            NOT NULL,
    employee_id       INT            NOT NULL,
    review_start_time DATE,
    review_end_time   DATE,
    score_outline     VARCHAR(255),
    rating            DECIMAL(3,1),
    CONSTRAINT pk_performance PRIMARY KEY (performance_id)
);

-- 13. COMMENTS
CREATE TABLE COMMENTS (
    comment_id      INT   NOT NULL,
    performance_id  INT   NOT NULL,
    comment         TEXT,
    created_by      INT,
    CONSTRAINT pk_comments PRIMARY KEY (comment_id)
);

-- 14. TRAINING
CREATE TABLE TRAINING (
    training_id     INT           NOT NULL,
    performance_id  INT,
    employee_id     INT           NOT NULL,
    training_title  VARCHAR(150)  NOT NULL,
    trainer_name    VARCHAR(100),
    start_date      DATE,
    end_date        DATE,
    description     TEXT,
    CONSTRAINT pk_training PRIMARY KEY (training_id)
);

-- 15. PAYROLL
CREATE TABLE PAYROLL (
    payroll_id     INT             NOT NULL,
    employee_id    INT             NOT NULL,
    payroll_month  DATE            NOT NULL,
    basic_salary   DECIMAL(12,2)   NOT NULL,
    total_deductions DECIMAL(12,2) DEFAULT 0,
    net_salary     DECIMAL(12,2),
    CONSTRAINT pk_payroll PRIMARY KEY (payroll_id)
);

-- 16. ALLOWANCE
CREATE TABLE ALLOWANCE (
    allowance_id    INT           NOT NULL,
    type            VARCHAR(80)   NOT NULL,
    CONSTRAINT pk_allowance PRIMARY KEY (allowance_id)
);

-- 17. DEDUCTION
CREATE TABLE DEDUCTION (
    deduction_id  INT          NOT NULL,
    type          VARCHAR(80)  NOT NULL,
    CONSTRAINT pk_deduction PRIMARY KEY (deduction_id)
);

-- 18. PAYROLL_ALLOWANCE  (junction)
CREATE TABLE PAYROLL_ALLOWANCE (
    pay_id        INT             NOT NULL,
    allowance_id  INT             NOT NULL,
    amount        DECIMAL(12,2)   NOT NULL,
    CONSTRAINT pk_payroll_allowance PRIMARY KEY (pay_id, allowance_id)
);

-- 19. PAYROLL_DEDUCTION  (junction)
CREATE TABLE PAYROLL_DEDUCTION (
    payroll_id    INT             NOT NULL,
    deduction_id  INT             NOT NULL,
    amount        DECIMAL(12,2)   NOT NULL,
    CONSTRAINT pk_payroll_deduction PRIMARY KEY (payroll_id, deduction_id)
);

-- 20. SALARY_SLIP
CREATE TABLE SALARY_SLIP (
    slip_id         INT             NOT NULL,
    payroll_id      INT             NOT NULL,
    slip_date       DATE,
    slip_month      DATE,
    generated_slip  VARCHAR(255),
    net_salary      DECIMAL(12,2),
    CONSTRAINT pk_salary_slip PRIMARY KEY (slip_id)
);

-- 21. JOB_POSTING
CREATE TABLE JOB_POSTING (
    job_id          INT           NOT NULL,
    designation_id  INT           NOT NULL,
    dept_id         INT           NOT NULL,
    job_posted      DATE,
    min_experience  INT,
    min_education   VARCHAR(100),
    min_salary      DECIMAL(12,2),
    max_salary      DECIMAL(12,2),
    job_title       VARCHAR(150),
    status          VARCHAR(30)   DEFAULT 'Open',
    description     TEXT,
    CONSTRAINT pk_job_posting PRIMARY KEY (job_id)
);

-- 22. SKILLS
CREATE TABLE SKILLS (
    skill_id    INT           NOT NULL,
    skill_name  VARCHAR(100)  NOT NULL,
    CONSTRAINT pk_skills PRIMARY KEY (skill_id)
);

-- 23. JOBPOSTING_SKILL  (junction)
CREATE TABLE JOBPOSTING_SKILL (
    job_id    INT  NOT NULL,
    skill_id  INT  NOT NULL,
    CONSTRAINT pk_jobposting_skill PRIMARY KEY (job_id, skill_id)
);

-- 24. CANDIDATE
CREATE TABLE CANDIDATE (
    candidate_id        INT           NOT NULL,
    job_id              INT           NOT NULL,
    candidate_firstname VARCHAR(80)   NOT NULL,
    candidate_lastname  VARCHAR(80)   NOT NULL,
    application_date    DATE,
    app_status          VARCHAR(30)   DEFAULT 'Applied',
    resume              VARCHAR(255),
    CONSTRAINT pk_candidate PRIMARY KEY (candidate_id)
);

-- 25. CANDIDATE_EMAIL  (multivalued)
CREATE TABLE CANDIDATE_EMAIL (
    candidate_id  INT           NOT NULL,
    email         VARCHAR(150)  NOT NULL,
    CONSTRAINT pk_candidate_email PRIMARY KEY (candidate_id, email)
);

-- 26. CANDIDATE_PHONE  (multivalued)
CREATE TABLE CANDIDATE_PHONE (
    candidate_id  INT          NOT NULL,
    phone         VARCHAR(20)  NOT NULL,
    CONSTRAINT pk_candidate_phone PRIMARY KEY (candidate_id, phone)
);

-- 27. RECRUITMENT
CREATE TABLE RECRUITMENT (
    recruitment_id  INT   NOT NULL,
    job_id          INT   NOT NULL,
    candidate_id    INT   NOT NULL,
    application_date DATE,
    status          VARCHAR(30) DEFAULT 'In Progress',
    CONSTRAINT pk_recruitment PRIMARY KEY (recruitment_id)
);

-- 28. INTERVIEW
CREATE TABLE INTERVIEW (
    interview_id      INT           NOT NULL,
    job_id            INT           NOT NULL,
    candidate_id      INT           NOT NULL,
    interviewer_id    INT,
    interview_date    DATE,
    interview_name    VARCHAR(150),
    result            VARCHAR(30),
    remarks           TEXT,
    has_interview     CHAR(1)       DEFAULT 'Y',
    CONSTRAINT pk_interview PRIMARY KEY (interview_id)
);


-- ============================================================
-- SECTION 2: ALTER TABLE — FOREIGN KEY CONSTRAINTS
-- ============================================================

-- DESIGNATION → DEPARTMENT
ALTER TABLE DESIGNATION
    ADD CONSTRAINT fk_desig_dept
    FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id);

-- EMPLOYEE → DEPARTMENT
ALTER TABLE EMPLOYEE
    ADD CONSTRAINT fk_emp_dept
    FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id);

-- EMPLOYEE → DESIGNATION
ALTER TABLE EMPLOYEE
    ADD CONSTRAINT fk_emp_desig
    FOREIGN KEY (designation_id) REFERENCES DESIGNATION(designation_id);

-- EMPLOYEE self-referential (manager)
ALTER TABLE EMPLOYEE
    ADD CONSTRAINT fk_emp_manager
    FOREIGN KEY (manager_id) REFERENCES EMPLOYEE(employee_id);

-- EMPLOYEE_EMAIL → EMPLOYEE
ALTER TABLE EMPLOYEE_EMAIL
    ADD CONSTRAINT fk_empemail_emp
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id);

-- EMPLOYEE_PHONE → EMPLOYEE
ALTER TABLE EMPLOYEE_PHONE
    ADD CONSTRAINT fk_empphone_emp
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id);

-- ROLE_PERMISSION → ROLE
ALTER TABLE ROLE_PERMISSION
    ADD CONSTRAINT fk_rp_role
    FOREIGN KEY (role_id) REFERENCES ROLE(role_id);

-- ROLE_PERMISSION → PERMISSION
ALTER TABLE ROLE_PERMISSION
    ADD CONSTRAINT fk_rp_permission
    FOREIGN KEY (permission_id) REFERENCES PERMISSION(permission_id);

-- USER → ROLE
ALTER TABLE "USER"
    ADD CONSTRAINT fk_user_role
    FOREIGN KEY (role_id) REFERENCES ROLE(role_id);

-- USER → EMPLOYEE
ALTER TABLE "USER"
    ADD CONSTRAINT fk_user_emp
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id);

-- ATTENDANCE → EMPLOYEE
ALTER TABLE ATTENDANCE
    ADD CONSTRAINT fk_attend_emp
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id);

-- LEAVE → EMPLOYEE
ALTER TABLE LEAVE
    ADD CONSTRAINT fk_leave_emp
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id);

-- LEAVE → EMPLOYEE (approved by)
ALTER TABLE LEAVE
    ADD CONSTRAINT fk_leave_admin
    FOREIGN KEY (approved_admin) REFERENCES EMPLOYEE(employee_id);

-- PERFORMANCE → EMPLOYEE
ALTER TABLE PERFORMANCE
    ADD CONSTRAINT fk_perf_emp
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id);

-- COMMENTS → PERFORMANCE
ALTER TABLE COMMENTS
    ADD CONSTRAINT fk_comments_perf
    FOREIGN KEY (performance_id) REFERENCES PERFORMANCE(performance_id);

-- COMMENTS → USER (created_by)
ALTER TABLE COMMENTS
    ADD CONSTRAINT fk_comments_user
    FOREIGN KEY (created_by) REFERENCES "USER"(user_id);

-- TRAINING → PERFORMANCE
ALTER TABLE TRAINING
    ADD CONSTRAINT fk_training_perf
    FOREIGN KEY (performance_id) REFERENCES PERFORMANCE(performance_id);

-- TRAINING → EMPLOYEE
ALTER TABLE TRAINING
    ADD CONSTRAINT fk_training_emp
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id);

-- PAYROLL → EMPLOYEE
ALTER TABLE PAYROLL
    ADD CONSTRAINT fk_payroll_emp
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id);

-- PAYROLL_ALLOWANCE → PAYROLL
ALTER TABLE PAYROLL_ALLOWANCE
    ADD CONSTRAINT fk_pa_payroll
    FOREIGN KEY (pay_id) REFERENCES PAYROLL(payroll_id);

-- PAYROLL_ALLOWANCE → ALLOWANCE
ALTER TABLE PAYROLL_ALLOWANCE
    ADD CONSTRAINT fk_pa_allowance
    FOREIGN KEY (allowance_id) REFERENCES ALLOWANCE(allowance_id);

-- PAYROLL_DEDUCTION → PAYROLL
ALTER TABLE PAYROLL_DEDUCTION
    ADD CONSTRAINT fk_pd_payroll
    FOREIGN KEY (payroll_id) REFERENCES PAYROLL(payroll_id);

-- PAYROLL_DEDUCTION → DEDUCTION
ALTER TABLE PAYROLL_DEDUCTION
    ADD CONSTRAINT fk_pd_deduction
    FOREIGN KEY (deduction_id) REFERENCES DEDUCTION(deduction_id);

-- SALARY_SLIP → PAYROLL
ALTER TABLE SALARY_SLIP
    ADD CONSTRAINT fk_slip_payroll
    FOREIGN KEY (payroll_id) REFERENCES PAYROLL(payroll_id);

-- JOB_POSTING → DESIGNATION
ALTER TABLE JOB_POSTING
    ADD CONSTRAINT fk_jp_desig
    FOREIGN KEY (designation_id) REFERENCES DESIGNATION(designation_id);

-- JOB_POSTING → DEPARTMENT
ALTER TABLE JOB_POSTING
    ADD CONSTRAINT fk_jp_dept
    FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id);

-- JOBPOSTING_SKILL → JOB_POSTING
ALTER TABLE JOBPOSTING_SKILL
    ADD CONSTRAINT fk_jps_jp
    FOREIGN KEY (job_id) REFERENCES JOB_POSTING(job_id);

-- JOBPOSTING_SKILL → SKILLS
ALTER TABLE JOBPOSTING_SKILL
    ADD CONSTRAINT fk_jps_skill
    FOREIGN KEY (skill_id) REFERENCES SKILLS(skill_id);

-- CANDIDATE → JOB_POSTING
ALTER TABLE CANDIDATE
    ADD CONSTRAINT fk_cand_jp
    FOREIGN KEY (job_id) REFERENCES JOB_POSTING(job_id);

-- CANDIDATE_EMAIL → CANDIDATE
ALTER TABLE CANDIDATE_EMAIL
    ADD CONSTRAINT fk_cemail_cand
    FOREIGN KEY (candidate_id) REFERENCES CANDIDATE(candidate_id);

-- CANDIDATE_PHONE → CANDIDATE
ALTER TABLE CANDIDATE_PHONE
    ADD CONSTRAINT fk_cphone_cand
    FOREIGN KEY (candidate_id) REFERENCES CANDIDATE(candidate_id);

-- RECRUITMENT → JOB_POSTING
ALTER TABLE RECRUITMENT
    ADD CONSTRAINT fk_rec_jp
    FOREIGN KEY (job_id) REFERENCES JOB_POSTING(job_id);

-- RECRUITMENT → CANDIDATE
ALTER TABLE RECRUITMENT
    ADD CONSTRAINT fk_rec_cand
    FOREIGN KEY (candidate_id) REFERENCES CANDIDATE(candidate_id);

-- INTERVIEW → JOB_POSTING
ALTER TABLE INTERVIEW
    ADD CONSTRAINT fk_intv_jp
    FOREIGN KEY (job_id) REFERENCES JOB_POSTING(job_id);

-- INTERVIEW → CANDIDATE
ALTER TABLE INTERVIEW
    ADD CONSTRAINT fk_intv_cand
    FOREIGN KEY (candidate_id) REFERENCES CANDIDATE(candidate_id);

-- INTERVIEW → EMPLOYEE (interviewer)
ALTER TABLE INTERVIEW
    ADD CONSTRAINT fk_intv_emp
    FOREIGN KEY (interviewer_id) REFERENCES EMPLOYEE(employee_id);


-- ============================================================
-- SECTION 3: INSERT INTO MASTER TABLES  (20-30 Records each)
-- ============================================================

-- ---- DEPARTMENT (20 records) ----
INSERT INTO DEPARTMENT (dept_id, dept_name, location) VALUES
(1,  'Human Resources',         'Block A, Floor 1'),
(2,  'Information Technology',  'Block B, Floor 2'),
(3,  'Finance & Accounts',      'Block A, Floor 2'),
(4,  'Marketing',               'Block C, Floor 1'),
(5,  'Sales',                   'Block C, Floor 2'),
(6,  'Operations',              'Block D, Floor 1'),
(7,  'Research & Development',  'Block B, Floor 3'),
(8,  'Customer Support',        'Block D, Floor 2'),
(9,  'Legal',                   'Block A, Floor 3'),
(10, 'Administration',          'Block E, Floor 1'),
(11, 'Procurement',             'Block E, Floor 2'),
(12, 'Logistics',               'Block F, Floor 1'),
(13, 'Quality Assurance',       'Block F, Floor 2'),
(14, 'Public Relations',        'Block C, Floor 3'),
(15, 'Product Management',      'Block B, Floor 4'),
(16, 'Data Analytics',          'Block B, Floor 5'),
(17, 'Cybersecurity',           'Block B, Floor 6'),
(18, 'Payroll',                 'Block A, Floor 4'),
(19, 'Training & Development',  'Block E, Floor 3'),
(20, 'Executive Office',        'Block A, Floor 5');


-- ---- ROLE (20 records) ----
INSERT INTO ROLE (role_id, role_name) VALUES
(1,  'Super Admin'),
(2,  'HR Manager'),
(3,  'HR Officer'),
(4,  'Department Manager'),
(5,  'Team Lead'),
(6,  'Employee'),
(7,  'Finance Manager'),
(8,  'Finance Officer'),
(9,  'Recruiter'),
(10, 'Interviewer'),
(11, 'Payroll Manager'),
(12, 'IT Admin'),
(13, 'Trainer'),
(14, 'Department Head'),
(15, 'Director'),
(16, 'CEO'),
(17, 'COO'),
(18, 'CTO'),
(19, 'Guest'),
(20, 'Auditor');


-- ---- PERMISSION (20 records) ----
INSERT INTO PERMISSION (permission_id, permission_name) VALUES
(1,  'View Employee'),
(2,  'Edit Employee'),
(3,  'Delete Employee'),
(4,  'View Payroll'),
(5,  'Edit Payroll'),
(6,  'Approve Leave'),
(7,  'View Reports'),
(8,  'Manage Roles'),
(9,  'Post Job'),
(10, 'Manage Recruitment'),
(11, 'Conduct Interview'),
(12, 'View Training'),
(13, 'Edit Training'),
(14, 'Manage Attendance'),
(15, 'View Performance'),
(16, 'Edit Performance'),
(17, 'Manage Departments'),
(18, 'Manage Designations'),
(19, 'Generate Salary Slip'),
(20, 'System Configuration');


-- ---- SKILLS (25 records) ----
INSERT INTO SKILLS (skill_id, skill_name) VALUES
(1,  'Python'),
(2,  'Java'),
(3,  'SQL'),
(4,  'Project Management'),
(5,  'Data Analysis'),
(6,  'Communication'),
(7,  'Leadership'),
(8,  'JavaScript'),
(9,  'React'),
(10, 'Node.js'),
(11, 'Machine Learning'),
(12, 'Financial Analysis'),
(13, 'Accounting'),
(14, 'Marketing Strategy'),
(15, 'SEO'),
(16, 'Customer Service'),
(17, 'Negotiation'),
(18, 'Legal Research'),
(19, 'Cybersecurity'),
(20, 'Network Administration'),
(21, 'UI/UX Design'),
(22, 'Agile/Scrum'),
(23, 'DevOps'),
(24, 'Cloud Computing'),
(25, 'Business Analysis');


-- ---- ALLOWANCE (20 records) ----
INSERT INTO ALLOWANCE (allowance_id, type) VALUES
(1,  'House Rent Allowance'),
(2,  'Medical Allowance'),
(3,  'Transport Allowance'),
(4,  'Meal Allowance'),
(5,  'Communication Allowance'),
(6,  'Performance Bonus'),
(7,  'Annual Bonus'),
(8,  'Overtime Allowance'),
(9,  'Fuel Allowance'),
(10, 'Utility Allowance'),
(11, 'Shift Allowance'),
(12, 'Project Completion Bonus'),
(13, 'Relocation Allowance'),
(14, 'Education Allowance'),
(15, 'Childcare Allowance'),
(16, 'Internet Allowance'),
(17, 'Clothing Allowance'),
(18, 'Risk Allowance'),
(19, 'Seniority Allowance'),
(20, 'Hardship Allowance');


-- ---- DEDUCTION (20 records) ----
INSERT INTO DEDUCTION (deduction_id, type) VALUES
(1,  'Income Tax'),
(2,  'Provident Fund'),
(3,  'Health Insurance'),
(4,  'Life Insurance'),
(5,  'Pension Contribution'),
(6,  'Loan Repayment'),
(7,  'Advance Recovery'),
(8,  'Late Arrival Deduction'),
(9,  'Absence Deduction'),
(10, 'Professional Tax'),
(11, 'Social Security'),
(12, 'Dental Insurance'),
(13, 'Vision Insurance'),
(14, 'Union Dues'),
(15, 'Garnishment'),
(16, 'Equipment Recovery'),
(17, 'Training Cost Recovery'),
(18, 'Canteen Deduction'),
(19, 'Parking Fee'),
(20, 'Miscellaneous Deduction');


-- ---- DESIGNATION (25 records) ----
INSERT INTO DESIGNATION (designation_id, dept_id, job_title, min_salary, max_salary) VALUES
(1,  1,  'HR Director',              150000, 250000),
(2,  1,  'HR Manager',               90000,  150000),
(3,  1,  'HR Officer',               50000,  90000),
(4,  2,  'Chief Technology Officer', 200000, 350000),
(5,  2,  'IT Manager',               120000, 200000),
(6,  2,  'Software Engineer',        70000,  130000),
(7,  2,  'System Analyst',           80000,  140000),
(8,  3,  'Chief Financial Officer',  200000, 350000),
(9,  3,  'Finance Manager',          120000, 200000),
(10, 3,  'Accountant',               60000,  100000),
(11, 4,  'Marketing Director',       150000, 250000),
(12, 4,  'Marketing Manager',        90000,  150000),
(13, 5,  'Sales Manager',            100000, 180000),
(14, 5,  'Sales Executive',          50000,  80000),
(15, 6,  'Operations Manager',       110000, 180000),
(16, 7,  'R&D Manager',              120000, 200000),
(17, 8,  'Customer Support Lead',    60000,  100000),
(18, 9,  'Legal Counsel',            130000, 220000),
(19, 10, 'Administrative Manager',   80000,  130000),
(20, 16, 'Data Scientist',           90000,  160000),
(21, 17, 'Cybersecurity Analyst',    85000,  150000),
(22, 19, 'Training Coordinator',     60000,  100000),
(23, 15, 'Product Manager',          100000, 180000),
(24, 2,  'DevOps Engineer',          80000,  140000),
(25, 20, 'Chief Executive Officer',  300000, 500000);


-- ---- EMPLOYEE (25 records) ----
-- Note: manager_id set NULL initially; updated via ALTER after all rows inserted
INSERT INTO EMPLOYEE (employee_id, dept_id, designation_id, manager_id, emp_first_name, emp_last_name,
                      gender, dob, email, nid, skills, employment_status, hire_date, mode_of_hire) VALUES
(1,  20, 25, NULL, 'Ahmed',    'Siddiqui',  'M', '1970-03-15', 'ahmed.siddiqui@hrms.com',  'NID-001', 'Leadership,Strategy',          'Active', '2010-01-01', 'Direct'),
(2,  1,  1,  1,    'Sara',     'Malik',     'F', '1975-06-20', 'sara.malik@hrms.com',       'NID-002', 'HR,Recruitment',               'Active', '2012-04-15', 'Direct'),
(3,  2,  4,  1,    'Bilal',    'Khan',      'M', '1978-11-10', 'bilal.khan@hrms.com',       'NID-003', 'Python,Cloud,Leadership',      'Active', '2013-07-01', 'Direct'),
(4,  3,  8,  1,    'Hina',     'Chaudhry',  'F', '1980-02-28', 'hina.chaudhry@hrms.com',   'NID-004', 'Finance,Audit',                'Active', '2014-01-10', 'Direct'),
(5,  1,  2,  2,    'Usman',    'Raza',      'M', '1985-07-14', 'usman.raza@hrms.com',       'NID-005', 'HR,Training',                  'Active', '2015-03-20', 'Internal Transfer'),
(6,  2,  5,  3,    'Fatima',   'Aslam',     'F', '1988-09-05', 'fatima.aslam@hrms.com',    'NID-006', 'Java,SQL,Agile',               'Active', '2016-08-11', 'Direct'),
(7,  2,  6,  6,    'Ali',      'Hassan',    'M', '1992-01-22', 'ali.hassan@hrms.com',       'NID-007', 'Python,React,Node.js',         'Active', '2018-02-14', 'Direct'),
(8,  3,  9,  4,    'Zainab',   'Hussain',   'F', '1990-05-30', 'zainab.hussain@hrms.com',  'NID-008', 'Accounting,Excel',             'Active', '2017-05-01', 'Direct'),
(9,  4,  11, 1,    'Kamran',   'Sheikh',    'M', '1977-12-03', 'kamran.sheikh@hrms.com',   'NID-009', 'Marketing,SEO',                'Active', '2014-09-15', 'Direct'),
(10, 5,  13, 1,    'Nadia',    'Iqbal',     'F', '1983-04-18', 'nadia.iqbal@hrms.com',     'NID-010', 'Sales,Negotiation',            'Active', '2015-11-30', 'Direct'),
(11, 2,  6,  6,    'Hamza',    'Tariq',     'M', '1994-08-07', 'hamza.tariq@hrms.com',     'NID-011', 'JavaScript,React,CSS',         'Active', '2019-06-01', 'Direct'),
(12, 2,  24, 6,    'Ayesha',   'Qureshi',   'F', '1993-03-25', 'ayesha.qureshi@hrms.com',  'NID-012', 'DevOps,Docker,AWS',            'Active', '2019-09-10', 'Direct'),
(13, 7,  16, 1,    'Omar',     'Farooq',    'M', '1982-10-14', 'omar.farooq@hrms.com',     'NID-013', 'Research,Data Analysis',       'Active', '2016-02-20', 'Direct'),
(14, 16, 20, 3,    'Sana',     'Nawaz',     'F', '1991-07-09', 'sana.nawaz@hrms.com',      'NID-014', 'ML,Python,Data Science',       'Active', '2020-01-15', 'Direct'),
(15, 17, 21, 3,    'Imran',    'Butt',      'M', '1989-11-22', 'imran.butt@hrms.com',      'NID-015', 'Cybersecurity,Networking',     'Active', '2020-03-01', 'Direct'),
(16, 3,  10, 8,    'Mehwish',  'Ali',       'F', '1995-06-12', 'mehwish.ali@hrms.com',     'NID-016', 'Accounting,Taxation',          'Active', '2021-07-01', 'Direct'),
(17, 4,  12, 9,    'Faisal',   'Mehmood',   'M', '1987-01-30', 'faisal.mehmood@hrms.com',  'NID-017', 'Digital Marketing,SEO',        'Active', '2018-04-15', 'Direct'),
(18, 5,  14, 10,   'Rabia',    'Zahid',     'F', '1996-09-17', 'rabia.zahid@hrms.com',     'NID-018', 'Sales,CRM',                    'Active', '2022-02-10', 'Direct'),
(19, 8,  17, 1,    'Kashif',   'Mirza',     'M', '1986-03-08', 'kashif.mirza@hrms.com',    'NID-019', 'Customer Service,Communication','Active','2017-10-05', 'Direct'),
(20, 9,  18, 1,    'Saira',    'Javed',     'F', '1981-08-25', 'saira.javed@hrms.com',     'NID-020', 'Legal,Contracts',              'Active', '2015-06-20', 'Direct'),
(21, 19, 22, 2,    'Tariq',    'Mahmood',   'M', '1984-12-11', 'tariq.mahmood@hrms.com',   'NID-021', 'Training,Facilitation',        'Active', '2016-11-01', 'Direct'),
(22, 15, 23, 1,    'Madiha',   'Aziz',      'F', '1990-04-02', 'madiha.aziz@hrms.com',     'NID-022', 'Product Management,Agile',     'Active', '2019-01-20', 'Direct'),
(23, 6,  15, 1,    'Shahid',   'Rana',      'M', '1979-07-16', 'shahid.rana@hrms.com',     'NID-023', 'Operations,Logistics',         'Active', '2013-12-01', 'Direct'),
(24, 1,  3,  5,    'Lubna',    'Baig',      'F', '1997-02-05', 'lubna.baig@hrms.com',      'NID-024', 'Recruitment,HR',               'Active', '2022-08-15', 'Direct'),
(25, 2,  7,  6,    'Junaid',   'Saeed',     'M', '1991-10-28', 'junaid.saeed@hrms.com',    'NID-025', 'System Analysis,SQL',          'Active', '2020-05-12', 'Direct');


-- ============================================================
-- SECTION 4: INSERT INTO DETAIL TABLES  (50-70 Records each)
-- ============================================================

-- ---- ROLE_PERMISSION (50 records) ----
INSERT INTO ROLE_PERMISSION (role_id, permission_id) VALUES
(1, 1),(1, 2),(1, 3),(1, 4),(1, 5),(1, 6),(1, 7),(1, 8),(1, 9),(1,10),
(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),
(2, 1),(2, 2),(2, 3),(2, 6),(2, 7),(2,12),(2,13),(2,14),(2,15),(2,16),
(3, 1),(3, 6),(3, 7),(3,14),(3,15),
(4, 1),(4, 6),(4, 7),(4,15),
(7, 4),(7, 5),(7, 7),(7,19),
(9, 1),(9, 9),(9,10),(9,11),
(11,4),(11,5),(11,7),(11,19);


-- ---- USER (25 records) ----
INSERT INTO "USER" (user_id, role_id, employee_id, username, password_hash) VALUES
(1,  1,  1,  'ahmed.sid',   '$2b$12$ahmedhash'),
(2,  2,  2,  'sara.mal',    '$2b$12$sarahash'),
(3,  12, 3,  'bilal.kha',   '$2b$12$bilalhash'),
(4,  7,  4,  'hina.cha',    '$2b$12$hinahash'),
(5,  2,  5,  'usman.raz',   '$2b$12$usmanhash'),
(6,  4,  6,  'fatima.asl',  '$2b$12$fatimahash'),
(7,  6,  7,  'ali.has',     '$2b$12$alihash'),
(8,  8,  8,  'zainab.hus',  '$2b$12$zainabhash'),
(9,  4,  9,  'kamran.she',  '$2b$12$kamranhash'),
(10, 4,  10, 'nadia.iqa',   '$2b$12$nadiahash'),
(11, 6,  11, 'hamza.tar',   '$2b$12$hamzahash'),
(12, 6,  12, 'ayesha.qur',  '$2b$12$ayeshahash'),
(13, 4,  13, 'omar.far',    '$2b$12$omarhash'),
(14, 6,  14, 'sana.naw',    '$2b$12$sanahash'),
(15, 6,  15, 'imran.but',   '$2b$12$imranhash'),
(16, 6,  16, 'mehwish.ali', '$2b$12$mehwishhash'),
(17, 6,  17, 'faisal.meh',  '$2b$12$faisalhash'),
(18, 6,  18, 'rabia.zah',   '$2b$12$rabiahash'),
(19, 6,  19, 'kashif.mir',  '$2b$12$kashifhash'),
(20, 6,  20, 'saira.jav',   '$2b$12$sairahash'),
(21, 13, 21, 'tariq.mah',   '$2b$12$tariqhash'),
(22, 6,  22, 'madiha.azi',  '$2b$12$madihahash'),
(23, 4,  23, 'shahid.ran',  '$2b$12$shahidhash'),
(24, 3,  24, 'lubna.bai',   '$2b$12$lubnarhash'),
(25, 6,  25, 'junaid.sae',  '$2b$12$junaidhash');


-- ---- EMPLOYEE_EMAIL ----
INSERT INTO EMPLOYEE_EMAIL (employee_id, email) VALUES
(1,  'ahmed.personal@gmail.com'),
(2,  'sara.personal@gmail.com'),
(3,  'bilal.personal@gmail.com'),
(4,  'hina.personal@gmail.com'),
(5,  'usman.personal@gmail.com'),
(6,  'fatima.personal@gmail.com'),
(7,  'ali.personal@gmail.com'),
(8,  'zainab.personal@gmail.com'),
(9,  'kamran.personal@gmail.com'),
(10, 'nadia.personal@gmail.com'),
(11, 'hamza.personal@gmail.com'),
(12, 'ayesha.personal@gmail.com'),
(13, 'omar.personal@gmail.com'),
(14, 'sana.personal@gmail.com'),
(15, 'imran.personal@gmail.com'),
(16, 'mehwish.personal@gmail.com'),
(17, 'faisal.personal@gmail.com'),
(18, 'rabia.personal@gmail.com'),
(19, 'kashif.personal@gmail.com'),
(20, 'saira.personal@gmail.com');


-- ---- EMPLOYEE_PHONE ----
INSERT INTO EMPLOYEE_PHONE (employee_id, phone) VALUES
(1, '0300-1111111'),(1, '0321-1111112'),
(2, '0300-2222221'),(3, '0300-3333331'),
(4, '0300-4444441'),(5, '0300-5555551'),
(6, '0300-6666661'),(7, '0300-7777771'),
(8, '0300-8888881'),(9, '0300-9999991'),
(10,'0301-1010101'),(11,'0301-1111111'),
(12,'0301-1212121'),(13,'0301-1313131'),
(14,'0301-1414141'),(15,'0301-1515151'),
(16,'0301-1616161'),(17,'0301-1717171'),
(18,'0301-1818181'),(19,'0301-1919191'),
(20,'0301-2020201'),(21,'0301-2121211'),
(22,'0301-2222221'),(23,'0301-2323231'),
(24,'0301-2424241'),(25,'0301-2525251');


-- ---- ATTENDANCE (60 records: 3 per employee for ~20 employees) ----
INSERT INTO ATTENDANCE (attendance_id, employee_id, date, check_in_time, check_out_time, status) VALUES
(1,  1, '2024-03-01', '08:55', '17:10', 'Present'),
(2,  1, '2024-03-04', '09:05', '17:00', 'Present'),
(3,  1, '2024-03-05', NULL,    NULL,    'Absent'),
(4,  2, '2024-03-01', '08:50', '17:05', 'Present'),
(5,  2, '2024-03-04', '08:45', '17:00', 'Present'),
(6,  2, '2024-03-05', '09:30', '17:00', 'Late'),
(7,  3, '2024-03-01', '08:58', '17:15', 'Present'),
(8,  3, '2024-03-04', '09:00', '17:00', 'Present'),
(9,  3, '2024-03-05', '09:00', '17:00', 'Present'),
(10, 4, '2024-03-01', '09:02', '17:10', 'Present'),
(11, 4, '2024-03-04', NULL,    NULL,    'Absent'),
(12, 4, '2024-03-05', '08:55', '17:05', 'Present'),
(13, 5, '2024-03-01', '09:15', '17:00', 'Late'),
(14, 5, '2024-03-04', '09:00', '17:00', 'Present'),
(15, 5, '2024-03-05', '09:00', '17:00', 'Present'),
(16, 6, '2024-03-01', '08:45', '17:20', 'Present'),
(17, 6, '2024-03-04', '08:50', '17:10', 'Present'),
(18, 6, '2024-03-05', '09:00', '17:00', 'Present'),
(19, 7, '2024-03-01', '09:00', '17:00', 'Present'),
(20, 7, '2024-03-04', '09:35', '17:00', 'Late'),
(21, 7, '2024-03-05', '09:00', '17:00', 'Present'),
(22, 8, '2024-03-01', '09:00', '17:05', 'Present'),
(23, 8, '2024-03-04', '09:00', '17:00', 'Present'),
(24, 8, '2024-03-05', NULL,    NULL,    'Absent'),
(25, 9, '2024-03-01', '08:40', '17:00', 'Present'),
(26, 9, '2024-03-04', '08:50', '17:00', 'Present'),
(27, 9, '2024-03-05', '09:00', '17:15', 'Present'),
(28,10, '2024-03-01', '09:00', '17:00', 'Present'),
(29,10, '2024-03-04', NULL,    NULL,    'Absent'),
(30,10, '2024-03-05', '09:00', '17:00', 'Present'),
(31,11, '2024-03-01', '09:10', '17:00', 'Present'),
(32,11, '2024-03-04', '09:00', '17:00', 'Present'),
(33,11, '2024-03-05', '09:40', '17:00', 'Late'),
(34,12, '2024-03-01', '08:55', '17:05', 'Present'),
(35,12, '2024-03-04', '09:00', '17:00', 'Present'),
(36,12, '2024-03-05', '09:00', '17:00', 'Present'),
(37,13, '2024-03-01', '09:00', '17:00', 'Present'),
(38,13, '2024-03-04', '09:00', '17:00', 'Present'),
(39,13, '2024-03-05', NULL,    NULL,    'Absent'),
(40,14, '2024-03-01', '08:50', '17:10', 'Present'),
(41,14, '2024-03-04', '09:00', '17:00', 'Present'),
(42,14, '2024-03-05', '09:00', '17:00', 'Present'),
(43,15, '2024-03-01', '09:00', '17:00', 'Present'),
(44,15, '2024-03-04', '09:20', '17:00', 'Late'),
(45,15, '2024-03-05', '09:00', '17:00', 'Present'),
(46,16, '2024-03-01', '09:00', '17:00', 'Present'),
(47,16, '2024-03-04', '09:00', '17:00', 'Present'),
(48,16, '2024-03-05', '09:00', '17:00', 'Present'),
(49,17, '2024-03-01', '09:05', '17:05', 'Present'),
(50,17, '2024-03-04', NULL,    NULL,    'Absent'),
(51,17, '2024-03-05', '09:00', '17:00', 'Present'),
(52,18, '2024-03-01', '09:00', '17:00', 'Present'),
(53,18, '2024-03-04', '08:45', '17:00', 'Present'),
(54,18, '2024-03-05', '09:00', '17:00', 'Present'),
(55,19, '2024-03-01', '09:00', '17:00', 'Present'),
(56,19, '2024-03-04', '09:30', '17:00', 'Late'),
(57,19, '2024-03-05', '09:00', '17:00', 'Present'),
(58,20, '2024-03-01', '09:00', '17:00', 'Present'),
(59,20, '2024-03-04', '09:00', '17:05', 'Present'),
(60,20, '2024-03-05', '09:00', '17:00', 'Present');


-- ---- LEAVE (50 records) ----
INSERT INTO LEAVE (leave_id, employee_id, leave_type, start_date, end_date, status, approved_admin) VALUES
(1,  7,  'Annual',       '2024-01-15', '2024-01-19', 'Approved', 6),
(2,  11, 'Sick',         '2024-02-05', '2024-02-06', 'Approved', 6),
(3,  14, 'Casual',       '2024-02-12', '2024-02-12', 'Approved', 2),
(4,  16, 'Annual',       '2024-02-20', '2024-02-23', 'Approved', 8),
(5,  18, 'Sick',         '2024-03-01', '2024-03-02', 'Pending',  NULL),
(6,  24, 'Casual',       '2024-03-10', '2024-03-10', 'Approved', 2),
(7,  5,  'Annual',       '2024-03-18', '2024-03-22', 'Approved', 2),
(8,  8,  'Maternity',    '2024-01-01', '2024-03-31', 'Approved', 4),
(9,  12, 'Casual',       '2024-04-01', '2024-04-01', 'Pending',  NULL),
(10, 17, 'Sick',         '2024-04-08', '2024-04-09', 'Approved', 9),
(11, 22, 'Annual',       '2024-04-15', '2024-04-19', 'Approved', 2),
(12, 7,  'Casual',       '2024-04-22', '2024-04-22', 'Rejected', 6),
(13, 11, 'Annual',       '2024-05-06', '2024-05-10', 'Approved', 6),
(14, 3,  'Sick',         '2024-05-13', '2024-05-14', 'Approved', 1),
(15, 15, 'Casual',       '2024-05-20', '2024-05-20', 'Approved', 3),
(16, 19, 'Annual',       '2024-05-27', '2024-05-31', 'Approved', 1),
(17, 25, 'Sick',         '2024-06-03', '2024-06-03', 'Pending',  NULL),
(18, 6,  'Casual',       '2024-06-10', '2024-06-10', 'Approved', 3),
(19, 14, 'Annual',       '2024-06-17', '2024-06-21', 'Approved', 3),
(20, 20, 'Study',        '2024-06-24', '2024-06-28', 'Approved', 1),
(21, 2,  'Casual',       '2024-07-01', '2024-07-01', 'Approved', 1),
(22, 4,  'Sick',         '2024-07-08', '2024-07-10', 'Approved', 1),
(23, 23, 'Annual',       '2024-07-15', '2024-07-19', 'Approved', 1),
(24, 13, 'Casual',       '2024-07-22', '2024-07-22', 'Approved', 1),
(25, 9,  'Annual',       '2024-07-29', '2024-08-02', 'Approved', 1),
(26, 10, 'Sick',         '2024-08-05', '2024-08-06', 'Approved', 1),
(27, 1,  'Annual',       '2024-08-12', '2024-08-16', 'Approved', 1),
(28, 7,  'Annual',       '2024-08-19', '2024-08-23', 'Approved', 6),
(29, 24, 'Sick',         '2024-08-26', '2024-08-27', 'Pending',  NULL),
(30, 18, 'Casual',       '2024-09-02', '2024-09-02', 'Approved', 10),
(31, 11, 'Sick',         '2024-09-09', '2024-09-09', 'Approved', 6),
(32, 16, 'Annual',       '2024-09-16', '2024-09-20', 'Approved', 8),
(33, 25, 'Annual',       '2024-09-23', '2024-09-27', 'Approved', 6),
(34, 5,  'Casual',       '2024-10-07', '2024-10-07', 'Approved', 2),
(35, 12, 'Annual',       '2024-10-14', '2024-10-18', 'Approved', 6),
(36, 14, 'Sick',         '2024-10-21', '2024-10-22', 'Approved', 3),
(37, 21, 'Annual',       '2024-10-28', '2024-11-01', 'Approved', 2),
(38, 17, 'Casual',       '2024-11-04', '2024-11-04', 'Rejected', 9),
(39, 7,  'Study',        '2024-11-11', '2024-11-15', 'Approved', 6),
(40, 22, 'Sick',         '2024-11-18', '2024-11-19', 'Approved', 2),
(41, 3,  'Annual',       '2024-11-25', '2024-11-29', 'Approved', 1),
(42, 15, 'Annual',       '2024-12-02', '2024-12-06', 'Approved', 3),
(43, 8,  'Casual',       '2024-12-09', '2024-12-09', 'Approved', 4),
(44, 20, 'Annual',       '2024-12-16', '2024-12-20', 'Approved', 1),
(45, 6,  'Annual',       '2024-12-23', '2024-12-27', 'Approved', 3),
(46, 10, 'Casual',       '2025-01-06', '2025-01-06', 'Pending',  NULL),
(47, 13, 'Sick',         '2025-01-13', '2025-01-14', 'Approved', 1),
(48, 19, 'Annual',       '2025-01-20', '2025-01-24', 'Approved', 1),
(49, 24, 'Annual',       '2025-01-27', '2025-01-31', 'Pending',  NULL),
(50, 25, 'Sick',         '2025-02-03', '2025-02-03', 'Approved', 6);


-- ---- PERFORMANCE (25 records) ----
INSERT INTO PERFORMANCE (performance_id, employee_id, review_start_time, review_end_time, score_outline, rating) VALUES
(1,  1,  '2024-01-01', '2024-03-31', 'Exceptional strategic leadership',        5.0),
(2,  2,  '2024-01-01', '2024-03-31', 'Excellent HR management',                 4.8),
(3,  3,  '2024-01-01', '2024-03-31', 'Strong technical leadership',             4.7),
(4,  4,  '2024-01-01', '2024-03-31', 'Solid financial oversight',               4.5),
(5,  5,  '2024-01-01', '2024-03-31', 'Good HR operations',                      4.0),
(6,  6,  '2024-01-01', '2024-03-31', 'Effective team management',               4.2),
(7,  7,  '2024-01-01', '2024-03-31', 'Good development output',                 3.9),
(8,  8,  '2024-01-01', '2024-03-31', 'Accurate accounting',                     4.1),
(9,  9,  '2024-01-01', '2024-03-31', 'Creative marketing campaigns',            4.3),
(10, 10, '2024-01-01', '2024-03-31', 'Exceeded sales targets',                  4.6),
(11, 11, '2024-01-01', '2024-03-31', 'Productive frontend developer',           3.8),
(12, 12, '2024-01-01', '2024-03-31', 'Excellent DevOps automation',             4.4),
(13, 13, '2024-01-01', '2024-03-31', 'Innovative R&D contributions',            4.7),
(14, 14, '2024-01-01', '2024-03-31', 'High-quality ML models',                  4.9),
(15, 15, '2024-01-01', '2024-03-31', 'Strong security posture improved',        4.5),
(16, 16, '2024-01-01', '2024-03-31', 'Accurate and timely reporting',           3.9),
(17, 17, '2024-01-01', '2024-03-31', 'Creative digital campaigns',              4.0),
(18, 18, '2024-01-01', '2024-03-31', 'Met sales quota',                         3.7),
(19, 19, '2024-01-01', '2024-03-31', 'Good customer satisfaction scores',       4.2),
(20, 20, '2024-01-01', '2024-03-31', 'Legal compliance maintained',             4.3),
(21, 21, '2024-01-01', '2024-03-31', 'Effective training delivery',             4.1),
(22, 22, '2024-01-01', '2024-03-31', 'Successful product launches',             4.6),
(23, 23, '2024-01-01', '2024-03-31', 'Efficient operations management',         4.0),
(24, 24, '2024-01-01', '2024-03-31', 'Responsive HR support',                   3.8),
(25, 25, '2024-01-01', '2024-03-31', 'Good system analysis quality',            4.0);


-- ---- COMMENTS (50 records) ----
INSERT INTO COMMENTS (comment_id, performance_id, comment, created_by) VALUES
(1,  1,  'Ahmed consistently drives company-wide strategic goals.',        1),
(2,  1,  'Exceptional stakeholder management skills.',                     2),
(3,  2,  'Sara maintains excellent employee relations.',                   1),
(4,  2,  'Needs to improve turnaround time on HR tickets.',               5),
(5,  3,  'Bilal is a cornerstone of the IT department.',                  1),
(6,  3,  'Recommends more documentation practices.',                       6),
(7,  4,  'Hina delivers clean financials every quarter.',                  1),
(8,  4,  'Appreciated risk management improvements.',                     4),
(9,  5,  'Usman handles HR operations smoothly.',                         2),
(10, 5,  'Should enhance digital HR tools knowledge.',                    5),
(11, 6,  'Fatima built a high-performing dev team.',                       3),
(12, 6,  'Code review process improved under her watch.',                  7),
(13, 7,  'Ali delivers clean, maintainable code.',                         6),
(14, 7,  'Needs to improve estimation accuracy.',                          11),
(15, 8,  'Zainab's month-end closing is flawless.',                        4),
(16, 8,  'Good collaboration with external auditors.',                     8),
(17, 9,  'Kamran led a successful brand refresh campaign.',                1),
(18, 9,  'Digital channel adoption needs improvement.',                   17),
(19,10,  'Nadia exceeded quarterly sales KPIs.',                           1),
(20,10,  'Strong pipeline management skills.',                             10),
(21,11,  'Hamza brings creativity to UI work.',                            6),
(22,11,  'Testing practices can be strengthened.',                        12),
(23,12,  'Ayesha automated 70% of deployment pipelines.',                  3),
(24,12,  'Excellent incident response time.',                             12),
(25,13,  'Omar published 2 research papers this quarter.',                 1),
(26,13,  'Cross-team R&D collaboration is a strength.',                   13),
(27,14,  'Sana's ML models outperform baselines by 15%.',                  3),
(28,14,  'Excellent documentation habits.',                               14),
(29,15,  'Imran reduced security incidents by 40%.',                       3),
(30,15,  'Proactive vulnerability patching commended.',                   15),
(31,16,  'Mehwish maintains clean books.',                                  8),
(32,16,  'Can improve speed of monthly reports.',                         16),
(33,17,  'Faisal's SEO strategy boosted organic traffic 30%.',             9),
(34,17,  'Needs stronger analytics reporting.',                           17),
(35,18,  'Rabia closes deals consistently.',                              10),
(36,18,  'Needs to expand key account portfolio.',                        18),
(37,19,  'Kashif resolves escalations effectively.',                      1),
(38,19,  'Customer satisfaction score improved.',                         19),
(39,20,  'Saira ensured zero compliance incidents.',                       1),
(40,20,  'Contract review turnaround improved.',                          20),
(41,21,  'Tariq designed impactful training modules.',                     2),
(42,21,  'Learner feedback scores are excellent.',                        21),
(43,22,  'Madiha delivered 3 major product features on schedule.',         1),
(44,22,  'Roadmap planning improved significantly.',                      22),
(45,23,  'Shahid reduced operational costs by 12%.',                       1),
(46,23,  'Process optimizations are well-documented.',                    23),
(47,24,  'Lubna responds quickly to employee queries.',                    2),
(48,24,  'Needs more confidence in complex HR cases.',                    24),
(49,25,  'Junaid delivers accurate system requirements.',                   6),
(50,25,  'Good cross-functional communication.',                          25);


-- ---- TRAINING (50 records) ----
INSERT INTO TRAINING (training_id, performance_id, employee_id, training_title, trainer_name,
                      start_date, end_date, description) VALUES
(1,  5,  5,  'Advanced HR Technology',         'Dr. Salman Akhtar',  '2024-02-01', '2024-02-03', 'HRIS systems and digital HR tools'),
(2,  7,  7,  'Clean Code Practices',           'Eng. Noman Farooq', '2024-02-05', '2024-02-06', 'Code quality and standards'),
(3,  11, 11, 'Frontend Performance Workshop',  'Eng. Noman Farooq', '2024-02-08', '2024-02-08', 'React optimization'),
(4,  16, 16, 'Advanced Excel for Finance',     'Fatima Accounting', '2024-02-10', '2024-02-11', 'Financial modelling'),
(5,  18, 18, 'Sales Mastery Program',          'Coach Tahir',        '2024-02-12', '2024-02-16', 'Closing techniques'),
(6,  24, 24, 'HR Case Management',             'Sara Malik',         '2024-02-19', '2024-02-20', 'Complex HR scenario handling'),
(7,  14, 14, 'Deep Learning Foundations',      'Dr. Ahsan Rizvi',    '2024-03-01', '2024-03-05', 'Neural networks & PyTorch'),
(8,  15, 15, 'Ethical Hacking Fundamentals',   'Imran Cyber',        '2024-03-07', '2024-03-09', 'Penetration testing basics'),
(9,  17, 17, 'Digital Marketing Analytics',    'Maalik SEO',         '2024-03-11', '2024-03-12', 'Google Analytics & SEMrush'),
(10, 21, 21, 'Instructional Design',           'Prof. Hina T',       '2024-03-14', '2024-03-15', 'Curriculum design techniques'),
(11, 3,  3,  'Cloud Architecture on AWS',      'AWS Partner',        '2024-03-18', '2024-03-22', 'Solutions Architect prep'),
(12, 12, 12, 'Kubernetes & Container Orch.',   'Eng. Umar Docker',   '2024-03-25', '2024-03-27', 'K8s deployment patterns'),
(13, 22, 22, 'Agile Product Management',       'Coach Yusuf PM',     '2024-04-01', '2024-04-03', 'Product vision & roadmap'),
(14, 9,  9,  'Brand Strategy Workshop',        'Branding Expert',    '2024-04-05', '2024-04-06', 'Brand positioning'),
(15, 10, 10, 'Key Account Management',         'Sales Coach',        '2024-04-08', '2024-04-09', 'Enterprise sales'),
(16, 13, 13, 'Grant Writing for R&D',          'Dr. Bilal R',        '2024-04-11', '2024-04-12', 'Research funding proposals'),
(17, 19, 19, 'Customer Experience Management', 'CX Consultant',      '2024-04-15', '2024-04-16', 'Journey mapping'),
(18, 20, 20, 'Contract Law Updates',           'Advocate Rana',      '2024-04-18', '2024-04-18', 'Recent legal amendments'),
(19, 23, 23, 'Lean Six Sigma Yellow Belt',     'LSS Trainer',        '2024-04-22', '2024-04-26', 'Process improvement basics'),
(20, 4,  4,  'Financial Risk Management',      'CFA Trainer',        '2024-05-01', '2024-05-03', 'Risk assessment frameworks'),
(21, 6,  6,  'Team Leadership Excellence',     'Leadership Coach',   '2024-05-06', '2024-05-07', 'Situational leadership'),
(22, 8,  8,  'IFRS Standards Update',          'ICAP Trainer',       '2024-05-09', '2024-05-10', 'New IFRS standards'),
(23, 1,  1,  'Executive Leadership Program',   'IMD Faculty',        '2024-05-13', '2024-05-17', 'Board-level leadership'),
(24, 2,  2,  'Strategic HR Management',        'SHRM Trainer',       '2024-05-20', '2024-05-22', 'HR strategy alignment'),
(25, 25, 25, 'Business Requirements Analysis', 'BA Expert',          '2024-05-27', '2024-05-28', 'Requirement elicitation'),
(26, 5,  5,  'Employment Law Compliance',      'Legal Expert',       '2024-06-03', '2024-06-03', 'Labor law updates'),
(27, 7,  7,  'Microservices Architecture',     'Eng. Asim Cloud',    '2024-06-05', '2024-06-07', 'Service decomposition'),
(28, 11, 11, 'TypeScript for Professionals',   'Tech Trainer',       '2024-06-10', '2024-06-10', 'Advanced TS patterns'),
(29, 14, 14, 'NLP Applications Workshop',      'Dr. Ahsan Rizvi',    '2024-06-12', '2024-06-14', 'Text classification & NLP'),
(30, 15, 15, 'Cloud Security Architecture',    'AWS Security',       '2024-06-17', '2024-06-19', 'AWS security best practices'),
(31, 12, 12, 'Infrastructure as Code',         'IaC Expert',         '2024-06-21', '2024-06-22', 'Terraform & Ansible'),
(32, 17, 17, 'Content Marketing Strategy',     'Content Expert',     '2024-06-24', '2024-06-25', 'Content creation funnel'),
(33, 22, 22, 'OKR Workshop',                   'OKR Coach',          '2024-07-01', '2024-07-01', 'Setting and tracking OKRs'),
(34, 3,  3,  'CTO Leadership Skills',          'Tech Leadership',    '2024-07-03', '2024-07-05', 'Technical leadership'),
(35, 9,  9,  'Social Media Marketing',         'SM Expert',          '2024-07-08', '2024-07-09', 'Platform strategies'),
(36, 10, 10, 'Negotiation Skills',             'Negotiation Coach',  '2024-07-11', '2024-07-12', 'Win-win negotiation'),
(37, 16, 16, 'Financial Statement Analysis',   'CFA Trainer',        '2024-07-15', '2024-07-16', 'Ratio analysis'),
(38, 19, 19, 'Conflict Resolution',            'HR Consultant',      '2024-07-18', '2024-07-18', 'De-escalation techniques'),
(39, 21, 21, 'Train-the-Trainer',              'TTT Expert',         '2024-07-22', '2024-07-23', 'Facilitation skills'),
(40, 23, 23, 'Supply Chain Optimization',      'SCM Expert',         '2024-07-25', '2024-07-26', 'End-to-end logistics'),
(41, 6,  6,  'Performance Management',         'HR Expert',          '2024-08-01', '2024-08-02', 'KPI frameworks'),
(42, 13, 13, 'Data-Driven Research Methods',   'Research Expert',    '2024-08-05', '2024-08-07', 'Quantitative methods'),
(43, 20, 20, 'Corporate Governance',           'Governance Expert',  '2024-08-12', '2024-08-13', 'Board advisory skills'),
(44, 24, 24, 'Digital HR Transformation',      'CHRO Coach',         '2024-08-19', '2024-08-20', 'Future of HR'),
(45, 25, 25, 'Data Modelling Techniques',      'DB Architect',       '2024-08-26', '2024-08-27', 'ER & dimensional modelling'),
(46, 4,  4,  'Treasury Management',            'Treasury Trainer',   '2024-09-02', '2024-09-03', 'Cash flow management'),
(47, 8,  8,  'Internal Audit Techniques',      'CIA Trainer',        '2024-09-09', '2024-09-10', 'Audit evidence & testing'),
(48, 18, 18, 'CRM Mastery: Salesforce',        'SF Trainer',         '2024-09-16', '2024-09-17', 'Salesforce CRM workflows'),
(49, 2,  2,  'Compensation & Benefits',        'C&B Expert',         '2024-09-23', '2024-09-24', 'Salary benchmarking'),
(50, 1,  1,  'Board Governance Workshop',      'Board Advisor',      '2024-09-30', '2024-09-30', 'Director responsibilities');


-- ---- PAYROLL (50 records — covers 25 employees x 2 months) ----
INSERT INTO PAYROLL (payroll_id, employee_id, payroll_month, basic_salary, total_deductions, net_salary) VALUES
-- January 2024
(1,  1,  '2024-01-31', 320000, 45000, 275000),
(2,  2,  '2024-01-31', 130000, 18000, 112000),
(3,  3,  '2024-01-31', 185000, 28000, 157000),
(4,  4,  '2024-01-31', 190000, 30000, 160000),
(5,  5,  '2024-01-31', 100000, 14000,  86000),
(6,  6,  '2024-01-31', 150000, 22000, 128000),
(7,  7,  '2024-01-31',  85000, 12000,  73000),
(8,  8,  '2024-01-31',  90000, 13000,  77000),
(9,  9,  '2024-01-31', 130000, 18000, 112000),
(10, 10, '2024-01-31', 120000, 16000, 104000),
(11, 11, '2024-01-31',  80000, 11000,  69000),
(12, 12, '2024-01-31',  90000, 12000,  78000),
(13, 13, '2024-01-31', 140000, 20000, 120000),
(14, 14, '2024-01-31', 110000, 15000,  95000),
(15, 15, '2024-01-31', 100000, 13000,  87000),
(16, 16, '2024-01-31',  75000, 10000,  65000),
(17, 17, '2024-01-31',  95000, 13000,  82000),
(18, 18, '2024-01-31',  65000,  9000,  56000),
(19, 19, '2024-01-31',  80000, 11000,  69000),
(20, 20, '2024-01-31', 155000, 22000, 133000),
(21, 21, '2024-01-31',  80000, 11000,  69000),
(22, 22, '2024-01-31', 120000, 17000, 103000),
(23, 23, '2024-01-31', 130000, 18000, 112000),
(24, 24, '2024-01-31',  60000,  8000,  52000),
(25, 25, '2024-01-31',  90000, 12000,  78000),
-- February 2024
(26, 1,  '2024-02-29', 320000, 45000, 275000),
(27, 2,  '2024-02-29', 130000, 18000, 112000),
(28, 3,  '2024-02-29', 185000, 28000, 157000),
(29, 4,  '2024-02-29', 190000, 30000, 160000),
(30, 5,  '2024-02-29', 100000, 14000,  86000),
(31, 6,  '2024-02-29', 155000, 23000, 132000),
(32, 7,  '2024-02-29',  85000, 12000,  73000),
(33, 8,  '2024-02-29',  90000, 13000,  77000),
(34, 9,  '2024-02-29', 135000, 19000, 116000),
(35, 10, '2024-02-29', 125000, 17000, 108000),
(36, 11, '2024-02-29',  82000, 11500,  70500),
(37, 12, '2024-02-29',  92000, 12500,  79500),
(38, 13, '2024-02-29', 140000, 20000, 120000),
(39, 14, '2024-02-29', 115000, 16000,  99000),
(40, 15, '2024-02-29', 102000, 14000,  88000),
(41, 16, '2024-02-29',  76000, 10500,  65500),
(42, 17, '2024-02-29',  97000, 13500,  83500),
(43, 18, '2024-02-29',  67000,  9500,  57500),
(44, 19, '2024-02-29',  82000, 11500,  70500),
(45, 20, '2024-02-29', 155000, 22000, 133000),
(46, 21, '2024-02-29',  82000, 11500,  70500),
(47, 22, '2024-02-29', 122000, 17500, 104500),
(48, 23, '2024-02-29', 132000, 19000, 113000),
(49, 24, '2024-02-29',  62000,  8500,  53500),
(50, 25, '2024-02-29',  92000, 12500,  79500);


-- ---- PAYROLL_ALLOWANCE (60 records) ----
INSERT INTO PAYROLL_ALLOWANCE (pay_id, allowance_id, amount) VALUES
(1, 1, 30000),(1, 2, 5000),(1, 6, 20000),
(2, 1, 15000),(2, 2, 3000),(2, 3, 2000),
(3, 1, 20000),(3, 2, 5000),(3, 6, 15000),
(4, 1, 22000),(4, 2, 5000),(4, 6, 18000),
(5, 1, 12000),(5, 2, 3000),(5, 3, 2000),
(6, 1, 18000),(6, 2, 4000),(6, 6, 12000),
(7, 1, 10000),(7, 2, 2500),(7, 3, 1500),
(8, 1, 10000),(8, 2, 3000),
(9, 1, 15000),(9, 2, 3500),(9, 6, 10000),
(10,1, 14000),(10,2, 3000),(10,3, 2000),
(11,1,  9000),(11,2, 2500),
(12,1, 10000),(12,2, 2500),(12,3, 1500),
(13,1, 16000),(13,2, 4000),(13,6, 12000),
(14,1, 12000),(14,2, 3000),(14,5,  1500),
(15,1, 11000),(15,2, 2500),(15,3,  1500),
(16,1,  8000),(16,2, 2000),
(17,1, 11000),(17,2, 2500),(17,3,  1500),
(18,1,  7000),(18,2, 2000),
(19,1,  9000),(19,2, 2500),
(20,1, 18000),(20,2, 4000),(20,6, 15000);


-- ---- PAYROLL_DEDUCTION (60 records) ----
INSERT INTO PAYROLL_DEDUCTION (payroll_id, deduction_id, amount) VALUES
(1, 1, 32000),(1, 2, 9600),(1, 3, 3400),
(2, 1, 11000),(2, 2, 3900),(2, 3, 3100),
(3, 1, 18500),(3, 2, 5550),(3, 3, 3950),
(4, 1, 19000),(4, 2, 5700),(4, 3, 5300),
(5, 1,  9500),(5, 2, 3000),(5, 3, 1500),
(6, 1, 14500),(6, 2, 4500),(6, 3, 3000),
(7, 1,  7500),(7, 2, 2550),(7, 3, 1950),
(8, 1,  8000),(8, 2, 2700),(8, 3, 2300),
(9, 1, 11000),(9, 2, 3900),(9, 3, 3100),
(10,1, 10000),(10,2, 3600),(10,3, 2400),
(11,1,  6800),(11,2, 2400),(11,3, 1800),
(12,1,  7500),(12,2, 2700),(12,3, 1800),
(13,1, 12000),(13,2, 4200),(13,3, 3800),
(14,1,  9000),(14,2, 3300),(14,3, 2700),
(15,1,  8500),(15,2, 3000),(15,3, 1500),
(16,1,  6200),(16,2, 2250),(16,3, 1550),
(17,1,  8000),(17,2, 2850),(17,3, 2150),
(18,1,  5500),(18,2, 1950),(18,3, 1550),
(19,1,  6800),(19,2, 2400),(19,3, 1800),
(20,1, 14500),(20,2, 4650),(20,3, 2850);


-- ---- SALARY_SLIP (50 records) ----
INSERT INTO SALARY_SLIP (slip_id, payroll_id, slip_date, slip_month, generated_slip, net_salary) VALUES
(1,  1,  '2024-01-31', '2024-01-01', 'slip_emp1_jan24.pdf',  275000),
(2,  2,  '2024-01-31', '2024-01-01', 'slip_emp2_jan24.pdf',  112000),
(3,  3,  '2024-01-31', '2024-01-01', 'slip_emp3_jan24.pdf',  157000),
(4,  4,  '2024-01-31', '2024-01-01', 'slip_emp4_jan24.pdf',  160000),
(5,  5,  '2024-01-31', '2024-01-01', 'slip_emp5_jan24.pdf',   86000),
(6,  6,  '2024-01-31', '2024-01-01', 'slip_emp6_jan24.pdf',  128000),
(7,  7,  '2024-01-31', '2024-01-01', 'slip_emp7_jan24.pdf',   73000),
(8,  8,  '2024-01-31', '2024-01-01', 'slip_emp8_jan24.pdf',   77000),
(9,  9,  '2024-01-31', '2024-01-01', 'slip_emp9_jan24.pdf',  112000),
(10, 10, '2024-01-31', '2024-01-01', 'slip_emp10_jan24.pdf', 104000),
(11, 11, '2024-01-31', '2024-01-01', 'slip_emp11_jan24.pdf',  69000),
(12, 12, '2024-01-31', '2024-01-01', 'slip_emp12_jan24.pdf',  78000),
(13, 13, '2024-01-31', '2024-01-01', 'slip_emp13_jan24.pdf', 120000),
(14, 14, '2024-01-31', '2024-01-01', 'slip_emp14_jan24.pdf',  95000),
(15, 15, '2024-01-31', '2024-01-01', 'slip_emp15_jan24.pdf',  87000),
(16, 16, '2024-01-31', '2024-01-01', 'slip_emp16_jan24.pdf',  65000),
(17, 17, '2024-01-31', '2024-01-01', 'slip_emp17_jan24.pdf',  82000),
(18, 18, '2024-01-31', '2024-01-01', 'slip_emp18_jan24.pdf',  56000),
(19, 19, '2024-01-31', '2024-01-01', 'slip_emp19_jan24.pdf',  69000),
(20, 20, '2024-01-31', '2024-01-01', 'slip_emp20_jan24.pdf', 133000),
(21, 21, '2024-01-31', '2024-01-01', 'slip_emp21_jan24.pdf',  69000),
(22, 22, '2024-01-31', '2024-01-01', 'slip_emp22_jan24.pdf', 103000),
(23, 23, '2024-01-31', '2024-01-01', 'slip_emp23_jan24.pdf', 112000),
(24, 24, '2024-01-31', '2024-01-01', 'slip_emp24_jan24.pdf',  52000),
(25, 25, '2024-01-31', '2024-01-01', 'slip_emp25_jan24.pdf',  78000),
(26, 26, '2024-02-29', '2024-02-01', 'slip_emp1_feb24.pdf',  275000),
(27, 27, '2024-02-29', '2024-02-01', 'slip_emp2_feb24.pdf',  112000),
(28, 28, '2024-02-29', '2024-02-01', 'slip_emp3_feb24.pdf',  157000),
(29, 29, '2024-02-29', '2024-02-01', 'slip_emp4_feb24.pdf',  160000),
(30, 30, '2024-02-29', '2024-02-01', 'slip_emp5_feb24.pdf',   86000),
(31, 31, '2024-02-29', '2024-02-01', 'slip_emp6_feb24.pdf',  132000),
(32, 32, '2024-02-29', '2024-02-01', 'slip_emp7_feb24.pdf',   73000),
(33, 33, '2024-02-29', '2024-02-01', 'slip_emp8_feb24.pdf',   77000),
(34, 34, '2024-02-29', '2024-02-01', 'slip_emp9_feb24.pdf',  116000),
(35, 35, '2024-02-29', '2024-02-01', 'slip_emp10_feb24.pdf', 108000),
(36, 36, '2024-02-29', '2024-02-01', 'slip_emp11_feb24.pdf',  70500),
(37, 37, '2024-02-29', '2024-02-01', 'slip_emp12_feb24.pdf',  79500),
(38, 38, '2024-02-29', '2024-02-01', 'slip_emp13_feb24.pdf', 120000),
(39, 39, '2024-02-29', '2024-02-01', 'slip_emp14_feb24.pdf',  99000),
(40, 40, '2024-02-29', '2024-02-01', 'slip_emp15_feb24.pdf',  88000),
(41, 41, '2024-02-29', '2024-02-01', 'slip_emp16_feb24.pdf',  65500),
(42, 42, '2024-02-29', '2024-02-01', 'slip_emp17_feb24.pdf',  83500),
(43, 43, '2024-02-29', '2024-02-01', 'slip_emp18_feb24.pdf',  57500),
(44, 44, '2024-02-29', '2024-02-01', 'slip_emp19_feb24.pdf',  70500),
(45, 45, '2024-02-29', '2024-02-01', 'slip_emp20_feb24.pdf', 133000),
(46, 46, '2024-02-29', '2024-02-01', 'slip_emp21_feb24.pdf',  70500),
(47, 47, '2024-02-29', '2024-02-01', 'slip_emp22_feb24.pdf', 104500),
(48, 48, '2024-02-29', '2024-02-01', 'slip_emp23_feb24.pdf', 113000),
(49, 49, '2024-02-29', '2024-02-01', 'slip_emp24_feb24.pdf',  53500),
(50, 50, '2024-02-29', '2024-02-01', 'slip_emp25_feb24.pdf',  79500);


-- ---- JOB_POSTING (20 records) ----
INSERT INTO JOB_POSTING (job_id, designation_id, dept_id, job_posted, min_experience,
                          min_education, min_salary, max_salary, job_title, status, description) VALUES
(1,  6,  2,  '2024-01-10', 3, 'BS Computer Science',    70000, 130000, 'Software Engineer',           'Closed',  'Backend and API development role'),
(2,  24, 2,  '2024-01-15', 2, 'BS Computer Science',    80000, 140000, 'DevOps Engineer',              'Closed',  'CI/CD pipeline and cloud ops'),
(3,  3,  1,  '2024-02-01', 1, 'BBA / MBA',              50000,  90000, 'HR Officer',                  'Closed',  'Recruitment and onboarding support'),
(4,  10, 3,  '2024-02-10', 2, 'ACCA / B.Com',           60000, 100000, 'Accountant',                  'Open',    'Financial reporting and reconciliation'),
(5,  14, 5,  '2024-02-20', 1, 'BBA Sales',              50000,  80000, 'Sales Executive',             'Open',    'B2B and B2C sales'),
(6,  20, 16, '2024-03-01', 3, 'BS Data Science / CS',   90000, 160000, 'Data Scientist',              'Open',    'Predictive modelling and dashboards'),
(7,  21, 17, '2024-03-05', 2, 'BS CS / Information Sec',85000, 150000, 'Cybersecurity Analyst',       'Open',    'Threat detection and response'),
(8,  22, 19, '2024-03-10', 2, 'BBA / Education',        60000, 100000, 'Training Coordinator',        'Closed',  'Design and deliver training programs'),
(9,  23, 15, '2024-03-15', 4, 'MBA / Engineering',      100000,180000, 'Product Manager',             'Open',    'Product roadmap and stakeholder management'),
(10, 17, 8,  '2024-03-20', 1, 'BBA / BCS',              60000, 100000, 'Customer Support Lead',       'Open',    'Team leadership and escalation handling'),
(11, 7,  2,  '2024-04-01', 3, 'BS Computer Science',    80000, 140000, 'System Analyst',              'Open',    'Requirements gathering and system design'),
(12, 12, 4,  '2024-04-10', 3, 'MBA Marketing',          90000, 150000, 'Marketing Manager',           'Open',    'Multi-channel marketing management'),
(13, 13, 5,  '2024-04-15', 5, 'MBA / BBA',             100000, 180000, 'Sales Manager',               'Open',    'Regional sales strategy'),
(14, 9,  3,  '2024-04-20', 5, 'ACCA / CA / MBA Finance',120000,200000, 'Finance Manager',             'Open',    'Financial planning and analysis'),
(15, 15, 6,  '2024-04-25', 6, 'MBA / Engineering',     110000, 180000, 'Operations Manager',          'Open',    'End-to-end operations oversight'),
(16, 16, 7,  '2024-05-01', 5, 'PhD / MS',              120000, 200000, 'R&D Manager',                 'Open',    'Applied research leadership'),
(17, 6,  2,  '2024-05-10', 2, 'BS Computer Science',    70000, 130000, 'Software Engineer (Frontend)','Open',    'React and Next.js development'),
(18, 6,  2,  '2024-05-15', 3, 'BS Computer Science',    75000, 130000, 'Software Engineer (Backend)', 'Open',    'Node.js and microservices'),
(19, 19, 10, '2024-05-20', 3, 'BBA / MBA',              80000, 130000, 'Administrative Manager',      'Open',    'Office administration management'),
(20, 18, 9,  '2024-05-25', 5, 'LLB / LLM',            130000, 220000, 'Legal Counsel',               'Open',    'Corporate law and contracts');


-- ---- SKILLS for JOBPOSTING_SKILL ----
INSERT INTO JOBPOSTING_SKILL (job_id, skill_id) VALUES
(1, 2),(1, 3),(1, 8),
(2,23),(2,24),(2,22),
(3, 6),(3, 7),
(4,12),(4,13),
(5,17),(5, 6),
(6, 1),(6, 5),(6,11),
(7,19),(7,20),
(8, 6),(8, 7),
(9, 4),(9,22),(9,25),
(10,16),(10,6),
(11,3),(11,25),
(12,14),(12,15),
(13,17),(13, 7),
(14,12),(14,25),
(15, 4),(15,22),
(16, 5),(16,11),
(17, 8),(17, 9),
(18,10),(18, 2),
(19, 6),(19, 7),
(20,18),(20,25);


-- ---- CANDIDATE (50 records) ----
INSERT INTO CANDIDATE (candidate_id, job_id, candidate_firstname, candidate_lastname,
                        application_date, app_status, resume) VALUES
(1,  1,  'Arslan',   'Baig',     '2024-01-12', 'Hired',     'resume_arslan.pdf'),
(2,  1,  'Zara',     'Malik',    '2024-01-13', 'Rejected',  'resume_zara.pdf'),
(3,  1,  'Hassan',   'Noor',     '2024-01-14', 'Rejected',  'resume_hassan.pdf'),
(4,  2,  'Noman',    'Farooq',   '2024-01-17', 'Hired',     'resume_noman.pdf'),
(5,  2,  'Rida',     'Islam',    '2024-01-18', 'Rejected',  'resume_rida.pdf'),
(6,  3,  'Hira',     'Saeed',    '2024-02-03', 'Hired',     'resume_hira.pdf'),
(7,  3,  'Waleed',   'Tahir',    '2024-02-04', 'Rejected',  'resume_waleed.pdf'),
(8,  4,  'Maria',    'Aziz',     '2024-02-12', 'Shortlisted','resume_maria.pdf'),
(9,  4,  'Shehzad',  'Ali',      '2024-02-13', 'Applied',   'resume_shehzad.pdf'),
(10, 5,  'Amna',     'Riaz',     '2024-02-22', 'Applied',   'resume_amna.pdf'),
(11, 5,  'Junaid',   'Khalid',   '2024-02-23', 'Applied',   'resume_junaid.pdf'),
(12, 6,  'Nida',     'Qasim',    '2024-03-03', 'Shortlisted','resume_nida.pdf'),
(13, 6,  'Shahzeb',  'Dar',      '2024-03-04', 'Applied',   'resume_shahzeb.pdf'),
(14, 7,  'Asad',     'Nawaz',    '2024-03-07', 'Shortlisted','resume_asad.pdf'),
(15, 7,  'Lubna',    'Yousaf',   '2024-03-08', 'Applied',   'resume_lubnay.pdf'),
(16, 8,  'Zubair',   'Ahmad',    '2024-03-12', 'Hired',     'resume_zubair.pdf'),
(17, 8,  'Sobia',    'Hanif',    '2024-03-13', 'Rejected',  'resume_sobia.pdf'),
(18, 9,  'Farhaan',  'Mehmood',  '2024-03-17', 'Shortlisted','resume_farhaan.pdf'),
(19, 9,  'Bushra',   'Khaliq',   '2024-03-18', 'Applied',   'resume_bushra.pdf'),
(20, 10, 'Azfar',    'Iqbal',    '2024-03-22', 'Applied',   'resume_azfar.pdf'),
(21, 10, 'Saman',    'Tahir',    '2024-03-23', 'Applied',   'resume_saman.pdf'),
(22, 11, 'Danish',   'Rehman',   '2024-04-03', 'Shortlisted','resume_danish.pdf'),
(23, 11, 'Saima',    'Nasir',    '2024-04-04', 'Applied',   'resume_saima.pdf'),
(24, 12, 'Imtiaz',   'Sultan',   '2024-04-12', 'Applied',   'resume_imtiaz.pdf'),
(25, 12, 'Kishwar',  'Ameen',    '2024-04-13', 'Applied',   'resume_kishwar.pdf'),
(26, 13, 'Nadeem',   'Gondal',   '2024-04-17', 'Applied',   'resume_nadeem.pdf'),
(27, 13, 'Shazia',   'Pervez',   '2024-04-18', 'Shortlisted','resume_shazia.pdf'),
(28, 14, 'Khalid',   'Mirza',    '2024-04-22', 'Shortlisted','resume_khalid.pdf'),
(29, 14, 'Farzana',  'Bibi',     '2024-04-23', 'Applied',   'resume_farzana.pdf'),
(30, 15, 'Tariq',    'Sultan',   '2024-04-27', 'Applied',   'resume_tariqs.pdf'),
(31, 15, 'Uzma',     'Siddiq',   '2024-04-28', 'Applied',   'resume_uzma.pdf'),
(32, 16, 'Babar',    'Shaheen',  '2024-05-03', 'Applied',   'resume_babar.pdf'),
(33, 16, 'Naseem',   'Hayat',    '2024-05-04', 'Applied',   'resume_naseem.pdf'),
(34, 17, 'Zaid',     'Farhan',   '2024-05-12', 'Shortlisted','resume_zaid.pdf'),
(35, 17, 'Hadia',    'Kamran',   '2024-05-13', 'Applied',   'resume_hadia.pdf'),
(36, 18, 'Sohail',   'Rashid',   '2024-05-17', 'Applied',   'resume_sohail.pdf'),
(37, 18, 'Fareeha',  'Zafar',    '2024-05-18', 'Applied',   'resume_fareeha.pdf'),
(38, 19, 'Waqar',    'Javed',    '2024-05-22', 'Applied',   'resume_waqar.pdf'),
(39, 19, 'Maham',    'Ilyas',    '2024-05-23', 'Applied',   'resume_maham.pdf'),
(40, 20, 'Asif',     'Rauf',     '2024-05-27', 'Shortlisted','resume_asif.pdf'),
(41, 20, 'Fauzia',   'Qamar',    '2024-05-28', 'Applied',   'resume_fauzia.pdf'),
(42, 6,  'Hamid',    'Saleem',   '2024-03-05', 'Applied',   'resume_hamid.pdf'),
(43, 7,  'Rukhsana', 'Awan',     '2024-03-09', 'Applied',   'resume_rukhsana.pdf'),
(44, 9,  'Maryam',   'Akram',    '2024-03-19', 'Applied',   'resume_maryam.pdf'),
(45, 11, 'Umer',     'Chishti',  '2024-04-05', 'Applied',   'resume_umer.pdf'),
(46, 12, 'Ghazala',  'Hayat',    '2024-04-14', 'Applied',   'resume_ghazala.pdf'),
(47, 13, 'Sarfraz',  'Hussain',  '2024-04-19', 'Applied',   'resume_sarfraz.pdf'),
(48, 14, 'Nusrat',   'Parveen',  '2024-04-24', 'Applied',   'resume_nusrat.pdf'),
(49, 17, 'Naveed',   'Bhatti',   '2024-05-14', 'Applied',   'resume_naveed.pdf'),
(50, 18, 'Robina',   'Chaudhry', '2024-05-19', 'Applied',   'resume_robina.pdf');


-- ---- CANDIDATE_EMAIL ----
INSERT INTO CANDIDATE_EMAIL (candidate_id, email) VALUES
(1,'arslan.baig@email.com'),(2,'zara.malik@email.com'),(3,'hassan.noor@email.com'),
(4,'noman.farooq@email.com'),(5,'rida.islam@email.com'),(6,'hira.saeed@email.com'),
(7,'waleed.tahir@email.com'),(8,'maria.aziz@email.com'),(9,'shehzad.ali@email.com'),
(10,'amna.riaz@email.com'),(11,'junaid.khalid@email.com'),(12,'nida.qasim@email.com'),
(13,'shahzeb.dar@email.com'),(14,'asad.nawaz@email.com'),(15,'lubna.yousaf@email.com'),
(16,'zubair.ahmad@email.com'),(17,'sobia.hanif@email.com'),(18,'farhaan.meh@email.com'),
(19,'bushra.khaliq@email.com'),(20,'azfar.iqbal@email.com');


-- ---- CANDIDATE_PHONE ----
INSERT INTO CANDIDATE_PHONE (candidate_id, phone) VALUES
(1,'0311-1010101'),(2,'0311-2020202'),(3,'0311-3030303'),
(4,'0311-4040404'),(5,'0311-5050505'),(6,'0311-6060606'),
(7,'0311-7070707'),(8,'0311-8080808'),(9,'0311-9090909'),
(10,'0312-1010101'),(11,'0312-2020202'),(12,'0312-3030303'),
(13,'0312-4040404'),(14,'0312-5050505'),(15,'0312-6060606'),
(16,'0312-7070707'),(17,'0312-8080808'),(18,'0312-9090909'),
(19,'0313-1010101'),(20,'0313-2020202');


-- ---- RECRUITMENT (50 records) ----
INSERT INTO RECRUITMENT (recruitment_id, job_id, candidate_id, application_date, status) VALUES
(1,  1,  1,  '2024-01-12', 'Hired'),
(2,  1,  2,  '2024-01-13', 'Rejected'),
(3,  1,  3,  '2024-01-14', 'Rejected'),
(4,  2,  4,  '2024-01-17', 'Hired'),
(5,  2,  5,  '2024-01-18', 'Rejected'),
(6,  3,  6,  '2024-02-03', 'Hired'),
(7,  3,  7,  '2024-02-04', 'Rejected'),
(8,  4,  8,  '2024-02-12', 'In Progress'),
(9,  4,  9,  '2024-02-13', 'In Progress'),
(10, 5,  10, '2024-02-22', 'In Progress'),
(11, 5,  11, '2024-02-23', 'In Progress'),
(12, 6,  12, '2024-03-03', 'In Progress'),
(13, 6,  13, '2024-03-04', 'In Progress'),
(14, 7,  14, '2024-03-07', 'In Progress'),
(15, 7,  15, '2024-03-08', 'In Progress'),
(16, 8,  16, '2024-03-12', 'Hired'),
(17, 8,  17, '2024-03-13', 'Rejected'),
(18, 9,  18, '2024-03-17', 'In Progress'),
(19, 9,  19, '2024-03-18', 'In Progress'),
(20, 10, 20, '2024-03-22', 'In Progress'),
(21, 10, 21, '2024-03-23', 'In Progress'),
(22, 11, 22, '2024-04-03', 'In Progress'),
(23, 11, 23, '2024-04-04', 'In Progress'),
(24, 12, 24, '2024-04-12', 'In Progress'),
(25, 12, 25, '2024-04-13', 'In Progress'),
(26, 13, 26, '2024-04-17', 'In Progress'),
(27, 13, 27, '2024-04-18', 'In Progress'),
(28, 14, 28, '2024-04-22', 'In Progress'),
(29, 14, 29, '2024-04-23', 'In Progress'),
(30, 15, 30, '2024-04-27', 'In Progress'),
(31, 15, 31, '2024-04-28', 'In Progress'),
(32, 16, 32, '2024-05-03', 'In Progress'),
(33, 16, 33, '2024-05-04', 'In Progress'),
(34, 17, 34, '2024-05-12', 'In Progress'),
(35, 17, 35, '2024-05-13', 'In Progress'),
(36, 18, 36, '2024-05-17', 'In Progress'),
(37, 18, 37, '2024-05-18', 'In Progress'),
(38, 19, 38, '2024-05-22', 'In Progress'),
(39, 19, 39, '2024-05-23', 'In Progress'),
(40, 20, 40, '2024-05-27', 'In Progress'),
(41, 20, 41, '2024-05-28', 'In Progress'),
(42, 6,  42, '2024-03-05', 'In Progress'),
(43, 7,  43, '2024-03-09', 'In Progress'),
(44, 9,  44, '2024-03-19', 'In Progress'),
(45, 11, 45, '2024-04-05', 'In Progress'),
(46, 12, 46, '2024-04-14', 'In Progress'),
(47, 13, 47, '2024-04-19', 'In Progress'),
(48, 14, 48, '2024-04-24', 'In Progress'),
(49, 17, 49, '2024-05-14', 'In Progress'),
(50, 18, 50, '2024-05-19', 'In Progress');


-- ---- INTERVIEW (50 records) ----
INSERT INTO INTERVIEW (interview_id, job_id, candidate_id, interviewer_id,
                        interview_date, interview_name, result, remarks, has_interview) VALUES
(1,  1,  1,  6,  '2024-01-16', 'Technical Round 1',     'Pass',    'Strong backend skills',           'Y'),
(2,  1,  1,  3,  '2024-01-18', 'Technical Round 2',     'Pass',    'Good system design knowledge',   'Y'),
(3,  1,  2,  6,  '2024-01-15', 'Technical Round 1',     'Fail',    'Weak in OOP concepts',            'Y'),
(4,  1,  3,  6,  '2024-01-16', 'Technical Round 1',     'Fail',    'Limited project experience',      'Y'),
(5,  2,  4,  3,  '2024-01-20', 'DevOps Assessment',     'Pass',    'Excellent Docker & K8s skills',   'Y'),
(6,  2,  5,  3,  '2024-01-20', 'DevOps Assessment',     'Fail',    'No production CI/CD experience',  'Y'),
(7,  3,  6,  2,  '2024-02-06', 'HR Interview',          'Pass',    'Strong communication skills',     'Y'),
(8,  3,  7,  2,  '2024-02-06', 'HR Interview',          'Fail',    'Lacks HR systems knowledge',      'Y'),
(9,  4,  8,  8,  '2024-02-15', 'Finance Technical',     'Pending', 'Awaiting decision',               'Y'),
(10, 5,  10, 10, '2024-02-25', 'Sales Assessment',      'Pending', 'Good communication observed',     'Y'),
(11, 5,  11, 10, '2024-02-25', 'Sales Assessment',      'Pending', 'Average performance',             'Y'),
(12, 6,  12, 14, 'scheduled',  NULL,                    NULL,      NULL,                              'Y'),
(13, 6,  13, 14, 'scheduled',  NULL,                    NULL,      NULL,                              'Y'),
(14, 7,  14, 15, 'scheduled',  NULL,                    NULL,      NULL,                              'Y'),
(15, 7,  15, 15, 'scheduled',  NULL,                    NULL,      NULL,                              'Y'),
(16, 8,  16, 21, '2024-03-15', 'Training Assessment',   'Pass',    'Well-prepared candidate',         'Y'),
(17, 8,  17, 21, '2024-03-15', 'Training Assessment',   'Fail',    'Weak presentation skills',        'Y'),
(18, 9,  18, 22, '2024-03-20', 'Product Case Study',    'Pending', 'Case study submitted',            'Y'),
(19, 10, 20, 19, '2024-03-25', 'CS Lead Interview',     'Pending', 'Awaiting HR approval',            'Y'),
(20, 11, 22, 25, '2024-04-06', 'System Analysis Test',  'Pending', 'Test under evaluation',           'Y'),
(21, 12, 24, 9,  '2024-04-15', 'Marketing Presentation','Pending', 'Presentation done',               'Y'),
(22, 13, 26, 10, '2024-04-20', 'Sales Strategy Round',  'Pending', 'Second round needed',             'Y'),
(23, 13, 27, 10, '2024-04-20', 'Sales Strategy Round',  'Pending', 'Strong candidate',                'Y'),
(24, 14, 28, 8,  '2024-04-25', 'Finance Case Study',    'Pending', 'Case study submitted',            'Y'),
(25, 16, 32, 13, '2024-05-06', 'R&D Presentation',      'Pending', 'Promising researcher',            'Y'),
(26, 17, 34, 7,  '2024-05-15', 'Frontend Code Test',    'Pending', 'Good React skills',               'Y'),
(27, 18, 36, 7,  '2024-05-20', 'Backend Code Test',     'Pending', 'Strong Node.js background',       'Y'),
(28, 20, 40, 20, '2024-05-30', 'Legal Case Review',     'Pending', 'Awaiting senior review',          'Y'),
(29, 1,  1,  2,  '2024-01-19', 'HR Final Interview',    'Pass',    'Culture fit confirmed',           'Y'),
(30, 2,  4,  2,  '2024-01-22', 'HR Final Interview',    'Pass',    'Excellent attitude',              'Y'),
(31, 3,  6,  1,  '2024-02-07', 'CEO Final Approval',    'Pass',    'Approved for hire',               'Y'),
(32, 8,  16, 2,  '2024-03-16', 'HR Final Interview',    'Pass',    'Hired as Training Coordinator',   'Y'),
(33, 6,  42, 14, '2024-03-08', 'Data Science Screen',   'Pending', 'Initial screening done',          'Y'),
(34, 7,  43, 15, '2024-03-11', 'Security Screen',       'Pending', 'Background check pending',        'Y'),
(35, 9,  44, 22, '2024-03-21', 'Product Phone Screen',  'Pending', 'Good initial impression',         'Y'),
(36, 11, 45, 25, '2024-04-08', 'BA Phone Screen',       'Pending', 'Passed initial screening',        'Y'),
(37, 12, 46, 9,  '2024-04-16', 'Marketing Screen',      'Pending', 'Portfolio reviewed',              'Y'),
(38, 13, 47, 10, '2024-04-21', 'Sales Phone Screen',    'Pending', 'Confident communicator',          'Y'),
(39, 14, 48, 8,  '2024-04-26', 'Finance Screen',        'Pending', 'Numbers-focused candidate',       'Y'),
(40, 17, 49, 7,  '2024-05-16', 'React Skills Test',     'Pending', 'Strong portfolio shown',          'Y'),
(41, 18, 50, 7,  '2024-05-21', 'Node.js Skills Test',   'Pending', 'Good GitHub profile',             'Y'),
(42, 4,  9,  8,  '2024-02-16', 'Accounting Test',       'Pending', 'Test results pending',            'Y'),
(43, 15, 30, 23, '2024-05-01', 'Ops Manager Interview',  'Pending', 'Strong operations background',   'Y'),
(44, 15, 31, 23, '2024-05-01', 'Ops Manager Interview',  'Pending', 'Needs follow-up',                'Y'),
(45, 19, 38, 19, '2024-05-25', 'Admin Interview',        'Pending', 'Office management skills good',  'Y'),
(46, 19, 39, 19, '2024-05-25', 'Admin Interview',        'Pending', 'Lacks seniority',                'Y'),
(47, 20, 41, 20, '2024-05-31', 'Legal Interview',        'Pending', 'Fresh LLM graduate',             'Y'),
(48, 16, 33, 13, '2024-05-07', 'R&D Technical Screen',   'Pending', 'PhD candidate',                  'Y'),
(49, 6,  12, 14, '2024-03-10', 'DS Technical Screen',    'Pending', 'Online test passed',             'Y'),
(50, 7,  14, 15, '2024-03-12', 'Cyber Technical Screen', 'Pending', 'CEH certified',                  'Y');


-- ============================================================
-- SECTION 5: 20 REPORT QUERIES OF VARYING DIFFICULTY
-- ============================================================

-- ====================================================
-- Query 1 (Simple SELECT)
-- List all employees with their full names and email
-- ====================================================
SELECT
    employee_id,
    emp_first_name || ' ' || emp_last_name AS full_name,
    email,
    employment_status,
    hire_date
FROM EMPLOYEE
ORDER BY emp_last_name, emp_first_name;


-- ====================================================
-- Query 2 (WHERE Condition)
-- Find all Active female employees hired after 2018
-- ====================================================
SELECT
    employee_id,
    emp_first_name || ' ' || emp_last_name AS full_name,
    gender,
    hire_date,
    employment_status
FROM EMPLOYEE
WHERE gender = 'F'
  AND employment_status = 'Active'
  AND hire_date > '2018-12-31'
ORDER BY hire_date DESC;


-- ====================================================
-- Query 3 (Simple JOIN — 2 tables)
-- List each employee along with their department name
-- ====================================================
SELECT
    e.employee_id,
    e.emp_first_name || ' ' || e.emp_last_name AS full_name,
    d.dept_name,
    d.location
FROM EMPLOYEE  e
JOIN DEPARTMENT d ON e.dept_id = d.dept_id
ORDER BY d.dept_name, e.emp_last_name;


-- ====================================================
-- Query 4 (3-table JOIN)
-- Show each employee, their department, and job title
-- ====================================================
SELECT
    e.employee_id,
    e.emp_first_name || ' ' || e.emp_last_name AS full_name,
    d.dept_name,
    ds.job_title
FROM EMPLOYEE    e
JOIN DEPARTMENT  d  ON e.dept_id        = d.dept_id
JOIN DESIGNATION ds ON e.designation_id = ds.designation_id
ORDER BY d.dept_name, ds.job_title;


-- ====================================================
-- Query 5 (GROUP BY)
-- Count the number of employees per department
-- ====================================================
SELECT
    d.dept_name,
    COUNT(e.employee_id) AS employee_count
FROM DEPARTMENT d
LEFT JOIN EMPLOYEE e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY employee_count DESC;


-- ====================================================
-- Query 6 (GROUP BY with HAVING)
-- Departments that have more than 1 employee
-- ====================================================
SELECT
    d.dept_name,
    COUNT(e.employee_id) AS employee_count
FROM DEPARTMENT d
JOIN EMPLOYEE   e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING COUNT(e.employee_id) > 1
ORDER BY employee_count DESC;


-- ====================================================
-- Query 7 (Aggregation — Payroll Summary per Employee)
-- Total basic salary and net salary paid (both months)
-- to each employee, sorted by net pay descending
-- ====================================================
SELECT
    e.emp_first_name || ' ' || e.emp_last_name AS full_name,
    d.dept_name,
    SUM(p.basic_salary)    AS total_basic,
    SUM(p.total_deductions) AS total_deductions,
    SUM(p.net_salary)      AS total_net_paid
FROM PAYROLL    p
JOIN EMPLOYEE   e ON p.employee_id = e.employee_id
JOIN DEPARTMENT d ON e.dept_id     = d.dept_id
GROUP BY e.employee_id, e.emp_first_name, e.emp_last_name, d.dept_name
ORDER BY total_net_paid DESC;


-- ====================================================
-- Query 8 (GROUP BY with HAVING — Leave Overusers)
-- Employees who took more than 2 approved leave requests
-- ====================================================
SELECT
    e.emp_first_name || ' ' || e.emp_last_name AS full_name,
    COUNT(l.leave_id)   AS approved_leaves,
    SUM(DATEDIFF(l.end_date, l.start_date) + 1) AS total_days_off
FROM LEAVE    l
JOIN EMPLOYEE e ON l.employee_id = e.employee_id
WHERE l.status = 'Approved'
GROUP BY e.employee_id, e.emp_first_name, e.emp_last_name
HAVING COUNT(l.leave_id) > 2
ORDER BY approved_leaves DESC;


-- ====================================================
-- Query 9 (Subquery — simple)
-- Find employees whose net salary is above
-- the company average net salary in January 2024
-- ====================================================
SELECT
    e.emp_first_name || ' ' || e.emp_last_name AS full_name,
    p.net_salary
FROM PAYROLL  p
JOIN EMPLOYEE e ON p.employee_id = e.employee_id
WHERE p.payroll_month = '2024-01-31'
  AND p.net_salary > (
        SELECT AVG(net_salary)
        FROM   PAYROLL
        WHERE  payroll_month = '2024-01-31'
      )
ORDER BY p.net_salary DESC;


-- ====================================================
-- Query 10 (Subquery — correlated)
-- For each department, find the highest-rated employee
-- (based on latest performance review)
-- ====================================================
SELECT
    d.dept_name,
    e.emp_first_name || ' ' || e.emp_last_name AS top_performer,
    pf.rating
FROM PERFORMANCE pf
JOIN EMPLOYEE    e  ON pf.employee_id = e.employee_id
JOIN DEPARTMENT  d  ON e.dept_id      = d.dept_id
WHERE pf.rating = (
        SELECT MAX(p2.rating)
        FROM   PERFORMANCE p2
        JOIN   EMPLOYEE    e2 ON p2.employee_id = e2.employee_id
        WHERE  e2.dept_id = e.dept_id
      )
ORDER BY pf.rating DESC;


-- ====================================================
-- Query 11 (Multi-table JOIN — Attendance Summary)
-- Count Present / Absent / Late status per employee
-- for the sampled March 2024 dates
-- ====================================================
SELECT
    e.emp_first_name || ' ' || e.emp_last_name AS full_name,
    d.dept_name,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS present_days,
    SUM(CASE WHEN a.status = 'Absent'  THEN 1 ELSE 0 END) AS absent_days,
    SUM(CASE WHEN a.status = 'Late'    THEN 1 ELSE 0 END) AS late_days
FROM ATTENDANCE a
JOIN EMPLOYEE   e ON a.employee_id = e.employee_id
JOIN DEPARTMENT d ON e.dept_id     = d.dept_id
GROUP BY e.employee_id, e.emp_first_name, e.emp_last_name, d.dept_name
ORDER BY absent_days DESC, late_days DESC;


-- ====================================================
-- Query 12 (Nested Subquery)
-- List all candidates who applied to jobs posted in
-- the IT department (dept_id = 2), with job title
-- ====================================================
SELECT
    c.candidate_id,
    c.candidate_firstname || ' ' || c.candidate_lastname AS candidate_name,
    jp.job_title,
    c.application_date,
    c.app_status
FROM CANDIDATE   c
JOIN JOB_POSTING jp ON c.job_id = jp.job_id
WHERE jp.job_id IN (
        SELECT job_id
        FROM   JOB_POSTING
        WHERE  dept_id = 2
      )
ORDER BY jp.job_title, c.application_date;


-- ====================================================
-- Query 13 (JOIN + Aggregation — Training Report)
-- Number of training sessions attended per employee
-- and the earliest training start date
-- ====================================================
SELECT
    e.emp_first_name || ' ' || e.emp_last_name AS full_name,
    d.dept_name,
    COUNT(t.training_id)   AS sessions_attended,
    MIN(t.start_date)      AS first_training_date,
    MAX(t.end_date)        AS last_training_date
FROM TRAINING   t
JOIN EMPLOYEE   e ON t.employee_id = e.employee_id
JOIN DEPARTMENT d ON e.dept_id     = d.dept_id
GROUP BY e.employee_id, e.emp_first_name, e.emp_last_name, d.dept_name
ORDER BY sessions_attended DESC;


-- ====================================================
-- Query 14 (Self-Join — Manager-Employee Hierarchy)
-- Show each employee alongside their manager's name
-- ====================================================
SELECT
    e.employee_id,
    e.emp_first_name || ' ' || e.emp_last_name     AS employee_name,
    COALESCE(m.emp_first_name || ' ' || m.emp_last_name, 'No Manager') AS manager_name,
    d.dept_name
FROM EMPLOYEE   e
LEFT JOIN EMPLOYEE   m ON e.manager_id = m.employee_id
JOIN      DEPARTMENT d ON e.dept_id    = d.dept_id
ORDER BY manager_name, employee_name;


-- ====================================================
-- Query 15 (Complex JOIN + GROUP BY — Recruitment Funnel)
-- Per job posting: total applicants, shortlisted,
-- interviewed, hired, rejected
-- ====================================================
SELECT
    jp.job_title,
    d.dept_name,
    COUNT(DISTINCT c.candidate_id)                                              AS total_applicants,
    SUM(CASE WHEN c.app_status = 'Shortlisted' THEN 1 ELSE 0 END)              AS shortlisted,
    COUNT(DISTINCT i.candidate_id)                                              AS interviewed,
    SUM(CASE WHEN c.app_status = 'Hired'       THEN 1 ELSE 0 END)              AS hired,
    SUM(CASE WHEN c.app_status = 'Rejected'    THEN 1 ELSE 0 END)              AS rejected
FROM JOB_POSTING jp
JOIN DEPARTMENT  d  ON jp.dept_id = d.dept_id
LEFT JOIN CANDIDATE  c  ON jp.job_id  = c.job_id
LEFT JOIN INTERVIEW  i  ON jp.job_id  = i.job_id AND i.candidate_id = c.candidate_id
GROUP BY jp.job_id, jp.job_title, d.dept_name
ORDER BY total_applicants DESC;


-- ====================================================
-- Query 16 (Nested Subquery + Aggregation)
-- Find departments whose average performance rating
-- is above the overall company average
-- ====================================================
SELECT
    d.dept_name,
    ROUND(AVG(pf.rating), 2) AS avg_dept_rating
FROM PERFORMANCE pf
JOIN EMPLOYEE    e  ON pf.employee_id = e.employee_id
JOIN DEPARTMENT  d  ON e.dept_id      = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING AVG(pf.rating) > (
           SELECT AVG(rating) FROM PERFORMANCE
       )
ORDER BY avg_dept_rating DESC;


-- ====================================================
-- Query 17 (Multi-level Nested Query)
-- List employees who have NEVER taken any leave
-- ====================================================
SELECT
    e.employee_id,
    e.emp_first_name || ' ' || e.emp_last_name AS full_name,
    d.dept_name,
    e.hire_date
FROM EMPLOYEE   e
JOIN DEPARTMENT d ON e.dept_id = d.dept_id
WHERE e.employee_id NOT IN (
        SELECT DISTINCT employee_id
        FROM   LEAVE
      )
ORDER BY e.hire_date;


-- ====================================================
-- Query 18 (Complex Report — Payroll Deductions Breakdown)
-- Total amount per deduction type across all payrolls
-- sorted by total deduction descending
-- ====================================================
SELECT
    dt.type                  AS deduction_type,
    COUNT(pd.payroll_id)     AS times_applied,
    SUM(pd.amount)           AS total_deducted,
    ROUND(AVG(pd.amount), 2) AS avg_deduction
FROM PAYROLL_DEDUCTION pd
JOIN DEDUCTION         dt ON pd.deduction_id = dt.deduction_id
GROUP BY dt.deduction_id, dt.type
ORDER BY total_deducted DESC;


-- ====================================================
-- Query 19 (Window Function — Rank employees in each
-- department by their January 2024 net salary)
-- ====================================================
SELECT
    d.dept_name,
    e.emp_first_name || ' ' || e.emp_last_name AS full_name,
    p.net_salary,
    RANK() OVER (
        PARTITION BY d.dept_id
        ORDER BY p.net_salary DESC
    ) AS salary_rank_in_dept
FROM PAYROLL    p
JOIN EMPLOYEE   e ON p.employee_id = e.employee_id
JOIN DEPARTMENT d ON e.dept_id     = d.dept_id
WHERE p.payroll_month = '2024-01-31'
ORDER BY d.dept_name, salary_rank_in_dept;


-- ====================================================
-- Query 20 (Full Executive Summary — Most Complex)
-- Department-level HR dashboard:
-- headcount, avg salary, avg performance rating,
-- total leaves taken, total trainings conducted,
-- and open job postings
-- ====================================================
SELECT
    d.dept_name,
    COUNT(DISTINCT e.employee_id)                     AS headcount,
    ROUND(AVG(p.net_salary), 0)                       AS avg_net_salary,
    ROUND(AVG(pf.rating), 2)                          AS avg_performance_rating,
    COUNT(DISTINCT lv.leave_id)                       AS total_leaves_taken,
    COUNT(DISTINCT tr.training_id)                    AS total_trainings,
    SUM(CASE WHEN jp.status = 'Open' THEN 1 ELSE 0 END) AS open_job_postings
FROM DEPARTMENT  d
LEFT JOIN EMPLOYEE    e  ON d.dept_id      = e.dept_id
LEFT JOIN PAYROLL     p  ON e.employee_id  = p.employee_id
                        AND p.payroll_month = '2024-01-31'
LEFT JOIN PERFORMANCE pf ON e.employee_id  = pf.employee_id
LEFT JOIN LEAVE       lv ON e.employee_id  = lv.employee_id
                        AND lv.status      = 'Approved'
LEFT JOIN TRAINING    tr ON e.employee_id  = tr.employee_id
LEFT JOIN JOB_POSTING jp ON d.dept_id      = jp.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY headcount DESC, avg_performance_rating DESC;

-- ============================================================
-- END OF HRMS SQL SCRIPT
-- ============================================================
