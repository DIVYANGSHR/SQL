use DSBANKMANAGEMENTSYSTEAM;
CREATE DATABASE DSBANKMANAGEMENTSYSTEAM;
USE DSBANKMANAGEMENTSYSTEAM;

CREATE TABLE BankManager (manager_id INT AUTO_INCREMENT PRIMARY KEY,
 manager_name VARCHAR(200) NOT NULL,
    contact_number VARCHAR(30),
    email VARCHAR(50)
);


INSERT INTO BankManager (manager_name,contact_number, email)
VALUES
    ('Ravi Kumar', '9876543210', 'ravi.kumar@bank.com'),
    ('Sita Sharma', '9876543211', 'sita.sharma@bank.com'),
    ('Ramesh singh','9876543209', 'ramesh.singh@bank.com'),
    ('Ajay yadav','9876543219', 'ajay.yadav@bank.com');
    
SELECT * FROM BANKMANAGER;
    
show columns from BANKMANAGER;
    
CREATE TABLE Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(70) NOT NULL,
    position VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES BankManager(manager_id)
);

INSERT INTO Employee (employee_name, position, manager_id)
VALUES
 
    ('Anil Gupta', 'Manager', 1),
    ('Priya Verma', 'Assistant Manager', 1),
    ('Ramesh Rao', 'Clerk', 2),
    ('Sunita Singh', 'Clerk', 2),
    ('Ramesh Patel', 'Sales', 2),
    ('Sunil Sharma', 'Sales', 3),
    ('Seema Ravat', 'Insurance', 3);

DROP TABLE employee;
    
SELECT * FROM Employee; 

 show columns from Employee ;
 
 
 
     CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15),
    email VARCHAR(90),
    address VARCHAR(200)
);

INSERT INTO Customer (customer_name, contact_number, email, address)
VALUES
    ('Amit Kumar', '9123456789', 'amit.kumar@gmail.com', 'Delhi'),
    ('Rajesh Kumar', '9123456790', 'rajesh.kumar@gmail.com', 'Mumbai'),
    ('Pooja Rani', '9123546791', 'pooja.rani@gmail.com', 'Chennai'),
    ('Vikram Singh', '9123456792', 'vikram.singh@gmail.com', 'Bangalore'),
    ('Meena Patel', '9123457692', 'meena.patel@gmail.com', 'Kolkata'),
    ( 'Deelip singh','9192887435','deelipsingh12@gmail.com','Delhi'),
     ('Sohan Yadav', '9123456885', 'sohanyadav@gmail.com', 'Mumbai'),
    ('Rani Patel', '9123546332', 'ranipatel@gmail.com', 'Chennai'),
    ('Ram Ahire', '9123456324', 'ramahire@gmail.com', 'Bangalore'),
    ('Reetu Sawant', '9123457987', 'reetusawant@gmail.com', 'Kolkata'),
     ('Samir Ansari', '9123456234', 'samir.ansari@gmail.com', 'Bangalore'),
    ('Navita Sinde', '9123457897', 'navita.sinde@gmail.com', 'Mumbai');
    
    SELECT * FROM Customer;
    
    show columns from Customer;
    
    CREATE TABLE Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50),
    balance DECIMAL(15, 2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

    INSERT INTO Accounts (customer_id, account_type, balance)
VALUES
    (1, 'Savings', 10000.00),
    (2, 'Current', 50000.00),
    (3, 'Savings', 15000.00),
    (4, 'Current', 30000.00),
    (5, 'Savings', 20000.00),
    (6, 'Savings', 15000.00),
    (7, 'Current', 40000.00),
    (8, 'Savings', 25000.00),
    (9, 'Current', 200000.00),
    (10, 'Savings', 60000.00),
     (11, 'Current', 210000.00),
    (12, 'Savings', 45000.00);
    
    SELECT *  FROM Accounts;
    
	show columns from Accounts;



CREATE TABLE Deposit (
    deposit_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    deposit_amount DECIMAL(15, 2),
    deposit_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

INSERT INTO Deposit (account_id, deposit_amount, deposit_date)
VALUES
    (1, 5000.00, '2025-01-01'),
    (2, 10000.00, '2025-01-02'),
    (3, 7000.00, '2025-01-05'),
    (4, 12000.00, '2025-01-07'),
    (5, 15000.00, '2025-01-10'),
	(6, 9000.00, '2025-01-01'),
    (7, 11000.00, '2025-01-02'),
    (8, 2000.00, '2025-01-05'),
    (9, 14000.00, '2025-01-07'),
    (10, 25000.00, '2025-01-10'),
     (11, 14000.00, '2025-01-07'),
    (12, 25000.00, '2025-01-10');
    
    SELECT * FROM Deposit;
    
    
    
    show columns from Deposit;


CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(50),  -- 'Personal Loan', 'Home Loan', 'Insurance', 'Gold Loan'
    loan_amount DECIMAL(15, 2),
    loan_date DATE,   FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Loans (customer_id, loan_type, loan_amount, loan_date)
VALUES
    (1, 'Personal Loan', 50000.00, '2025-01-05'),
    (2, 'Home Loan', 150000.00, '2025-01-10'),
    (3, 'Gold Loan', 20000.00, '2025-01-15'),
    (4, 'Insurance', 10000.00, '2025-01-18'),
    (5, 'Personal Loan', 300000.00, '2025-01-20'),
     (6, 'Personal Loan', 50000.00, '2025-01-05'),
    (7, 'Home Loan', 1500000.00, '2025-01-10'),
    (8, 'Gold Loan', 200000.00, '2025-01-15'),
    (9, 'Insurance', 10000.00, '2025-01-18'),
    (10, 'Personal Loan', 250000.00, '2025-01-20'),
    (11, 'Gold Loan', 30000.00, '2025-01-15'),
    (12, 'Insurance', 100000.00, '2025-01-18');
     



    SELECT * FROM LOANS;
    
    SHOW COLUMNS FROM Loans;
    
    SELECT  Loans from employee
    order by Loans DESC;
    

SELECT * FROM Deposit
WHERE Deposit_amount BETWEEN 5000 AND 15000;

SELECT * FROM LOANS
LIMIT 4;

SELECT * FROM Customer
WHERE email IS NOT NULL;

SELECT * FROM Employee
ORDER BY employee_name ASC;

SELECT DISTINCT account_type FROM Accounts;

SELECT customer_id, COUNT(*) AS number_of_transactions
FROM LOANS
GROUP BY customer_id;

SELECT CONCAT(customer_name, ' - ', email) AS customer_info
FROM Customer;

----- joins =========

SELECT e.employee_name, b.manager_name
FROM Employee e
INNER JOIN BankManager b ON e.manager_id = b.manager_id;

SELECT e.employee_name, b.manager_name
FROM Employee e
LEFT JOIN BankManager b ON e.manager_id = b.manager_id;



SELECT e.employee_name, b.manager_name
FROM Employee e
RIGHT JOIN BankManager b ON e.manager_id = b.manager_id;

SELECT e1.employee_name AS Employee1, e2.employee_name AS Employee2
FROM Employee e1
INNER JOIN Employee e2 ON e1.manager_id = e2.manager_id;

SELECT Customer.customer_name, BankManager.manager_name
FROM Customer
CROSS JOIN BankManager;

-- SELECT customer_name AS customer_1, customer_name AS customer_2, account_type
-- FROM AccountS
-- JOIN AccountS  ON account_type = account_type
-- WHERE customer_id != customer_id;



--- union =====

SELECT employee_name FROM Employee
UNION
SELECT customer_name FROM Customer;

SELECT employee_name FROM Employee
UNION ALL
SELECT customer_name FROM Customer;

  -- SubqueriesSingle  ==============

SELECT employee_name
FROM Employee
WHERE manager_id = (SELECT manager_id FROM BankManager WHERE manager_name = 'Ravi Kumar');

-- multipal row =================

SELECT employee_name
FROM Employee
WHERE manager_id IN (SELECT manager_id FROM BankManager WHERE manager_name LIKE 'Sita%');


CREATE VIEW ManagerEmployeeView AS
SELECT e.employee_name, b.manager_name
FROM Employee e
INNER JOIN BankManager b ON e.manager_id = b.manager_id;

INSERT INTO BankManager (manager_name, phone_number)
VALUES 
    ('Ravi Kumar', '9876543210'),
    ('Sita Sharma', '9876543211'),
    ('Ramesh Singh', '9876543209'),
    ('Ajay Yadav', '9876543219');



SELECT * FROM ManagerEmployeeView;

SELECT MIN(balance) AS min_balance, MAX(balance) AS max_balance
FROM Accounts;

SELECT COUNT(account_id) AS total_accounts, AVG(balance) AS average_balance
FROM Accounts;




































use DSBANKMANAGEMENTSYSTEAM;
CREATE DATABASE DSBANKMANAGEMENTSYSTEAM;
USE DSBANKMANAGEMENTSYSTEAM;

CREATE TABLE BankManager (manager_id INT AUTO_INCREMENT PRIMARY KEY,
 manager_name VARCHAR(200) NOT NULL,
    contact_number VARCHAR(30),
    email VARCHAR(50)
);


INSERT INTO BankManager (manager_name,contact_number, email)
VALUES
    ('Ravi Kumar', '9876543210', 'ravi.kumar@bank.com'),
    ('Sita Sharma', '9876543211', 'sita.sharma@bank.com'),
    ('Ramesh singh','9876543209', 'ramesh.singh@bank.com'),
    ('Ajay yadav','9876543219', 'ajay.yadav@bank.com');
    
SELECT * FROM BANKMANAGER;
    
show columns from BANKMANAGER;
    
CREATE TABLE Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(70) NOT NULL,
    position VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES BankManager(manager_id)
);

INSERT INTO Employee (employee_name, position, manager_id)
VALUES
 
    ('Anil Gupta', 'Manager', 1),
    ('Priya Verma', 'Assistant Manager', 1),
    ('Ramesh Rao', 'Clerk', 2),
    ('Sunita Singh', 'Clerk', 2),
    ('Ramesh Patel', 'Sales', 2),
    ('Sunil Sharma', 'Sales', 3),
    ('Seema Ravat', 'Insurance', 3);

DROP TABLE employee;
    
SELECT * FROM Employee; 

 show columns from Employee ;
 
 
 
     CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15),
    email VARCHAR(90),
    address VARCHAR(200)
);

INSERT INTO Customer (customer_name, contact_number, email, address)
VALUES
    ('Amit Kumar', '9123456789', 'amit.kumar@gmail.com', 'Delhi'),
    ('Rajesh Kumar', '9123456790', 'rajesh.kumar@gmail.com', 'Mumbai'),
    ('Pooja Rani', '9123546791', 'pooja.rani@gmail.com', 'Chennai'),
    ('Vikram Singh', '9123456792', 'vikram.singh@gmail.com', 'Bangalore'),
    ('Meena Patel', '9123457692', 'meena.patel@gmail.com', 'Kolkata'),
    ( 'Deelip singh','9192887435','deelipsingh12@gmail.com','Delhi'),
     ('Sohan Yadav', '9123456885', 'sohanyadav@gmail.com', 'Mumbai'),
    ('Rani Patel', '9123546332', 'ranipatel@gmail.com', 'Chennai'),
    ('Ram Ahire', '9123456324', 'ramahire@gmail.com', 'Bangalore'),
    ('Reetu Sawant', '9123457987', 'reetusawant@gmail.com', 'Kolkata'),
     ('Samir Ansari', '9123456234', 'samir.ansari@gmail.com', 'Bangalore'),
    ('Navita Sinde', '9123457897', 'navita.sinde@gmail.com', 'Mumbai');
    
    SELECT * FROM Customer;
    
    show columns from Customer;
    
    CREATE TABLE Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50),
    balance DECIMAL(15, 2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

    INSERT INTO Accounts (customer_id, account_type, balance)
VALUES
    (1, 'Savings', 10000.00),
    (2, 'Current', 50000.00),
    (3, 'Savings', 15000.00),
    (4, 'Current', 30000.00),
    (5, 'Savings', 20000.00),
    (6, 'Savings', 15000.00),
    (7, 'Current', 40000.00),
    (8, 'Savings', 25000.00),
    (9, 'Current', 200000.00),
    (10, 'Savings', 60000.00),
     (11, 'Current', 210000.00),
    (12, 'Savings', 45000.00);
    
    SELECT *  FROM Accounts;
    
	show columns from Accounts;



CREATE TABLE Deposit (
    deposit_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    deposit_amount DECIMAL(15, 2),
    deposit_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

INSERT INTO Deposit (account_id, deposit_amount, deposit_date)
VALUES
    (1, 5000.00, '2025-01-01'),
    (2, 10000.00, '2025-01-02'),
    (3, 7000.00, '2025-01-05'),
    (4, 12000.00, '2025-01-07'),
    (5, 15000.00, '2025-01-10'),
	(6, 9000.00, '2025-01-01'),
    (7, 11000.00, '2025-01-02'),
    (8, 2000.00, '2025-01-05'),
    (9, 14000.00, '2025-01-07'),
    (10, 25000.00, '2025-01-10'),
     (11, 14000.00, '2025-01-07'),
    (12, 25000.00, '2025-01-10');
    
    SELECT * FROM Deposit;
    
    
    
    show columns from Deposit;


CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(50),  -- 'Personal Loan', 'Home Loan', 'Insurance', 'Gold Loan'
    loan_amount DECIMAL(15, 2),
    loan_date DATE,   FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Loans (customer_id, loan_type, loan_amount, loan_date)
VALUES
    (1, 'Personal Loan', 50000.00, '2025-01-05'),
    (2, 'Home Loan', 150000.00, '2025-01-10'),
    (3, 'Gold Loan', 20000.00, '2025-01-15'),
    (4, 'Insurance', 10000.00, '2025-01-18'),
    (5, 'Personal Loan', 300000.00, '2025-01-20'),
     (6, 'Personal Loan', 50000.00, '2025-01-05'),
    (7, 'Home Loan', 1500000.00, '2025-01-10'),
    (8, 'Gold Loan', 200000.00, '2025-01-15'),
    (9, 'Insurance', 10000.00, '2025-01-18'),
    (10, 'Personal Loan', 250000.00, '2025-01-20'),
    (11, 'Gold Loan', 30000.00, '2025-01-15'),
    (12, 'Insurance', 100000.00, '2025-01-18');
     



    SELECT * FROM LOANS;
    
    SHOW COLUMNS FROM Loans;
    
    SELECT  Loans from employee
    order by Loans DESC;
    

SELECT * FROM Deposit
WHERE Deposit_amount BETWEEN 5000 AND 15000;

SELECT * FROM LOANS
LIMIT 4;

SELECT * FROM Customer
WHERE email IS NOT NULL;

SELECT * FROM Employee
ORDER BY employee_name ASC;

SELECT DISTINCT account_type FROM Accounts;

SELECT customer_id, COUNT(*) AS number_of_transactions
FROM LOANS
GROUP BY customer_id;

SELECT CONCAT(customer_name, ' - ', email) AS customer_info
FROM Customer;

----- joins =========

SELECT e.employee_name, b.manager_name
FROM Employee e
INNER JOIN BankManager b ON e.manager_id = b.manager_id;

SELECT e.employee_name, b.manager_name
FROM Employee e
LEFT JOIN BankManager b ON e.manager_id = b.manager_id;



SELECT e.employee_name, b.manager_name
FROM Employee e
RIGHT JOIN BankManager b ON e.manager_id = b.manager_id;

SELECT e1.employee_name AS Employee1, e2.employee_name AS Employee2
FROM Employee e1
INNER JOIN Employee e2 ON e1.manager_id = e2.manager_id;

--- union =====

SELECT employee_name FROM Employee
UNION
SELECT customer_name FROM Customer;

SELECT employee_name FROM Employee
UNION ALL
SELECT customer_name FROM Customer;

  -- SubqueriesSingle  ==============

SELECT employee_name
FROM Employee
WHERE manager_id = (SELECT manager_id FROM BankManager WHERE manager_name = 'Ravi Kumar');

-- multipal row =================

SELECT employee_name
FROM Employee
WHERE manager_id IN (SELECT manager_id FROM BankManager WHERE manager_name LIKE 'Sita%');


CREATE VIEW ManagerEmployeeView AS
SELECT e.employee_name, b.manager_name
FROM Employee e
INNER JOIN BankManager b ON e.manager_id = b.manager_id;

INSERT INTO BankManager (manager_name, phone_number)
VALUES 
    ('Ravi Kumar', '9876543210'),
    ('Sita Sharma', '9876543211'),
    ('Ramesh Singh', '9876543209'),
    ('Ajay Yadav', '9876543219');



SELECT * FROM ManagerEmployeeView;





































