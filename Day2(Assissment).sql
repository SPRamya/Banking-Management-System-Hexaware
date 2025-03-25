CREATE DATABASE bankSBI;
USE bankSBI;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1), 
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    DOB DATE NOT NULL, 
    email NVARCHAR(100) NOT NULL UNIQUE, 
    phone_number NVARCHAR(15) NOT NULL,
    address NVARCHAR(255) NOT NULL
);

INSERT INTO Customers (first_name, last_name, DOB, email, phone_number, address)
VALUES 
('John', 'Doe', '1990-01-15', 'john.doe@example.com', '1234567890', '123 Main St'),
('Jane', 'Smith', '1985-05-20', 'jane.smith@example.com', '9876543210', '456 Elm St'),
('Alice', 'Johnson', '1995-08-25', 'alice.johnson@example.com', '5555555555', '789 Oak St'),
('Bob', 'Brown', '1975-12-10', 'bob.brown@example.com', '1111111111', '321 Pine St');

SELECT * FROM Customers;

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY IDENTITY(1,1), 
    customer_id INT NOT NULL, 
    account_type NVARCHAR(20) NOT NULL CHECK (account_type IN ('savings', 'current', 'zero_balance')), 
    balance DECIMAL(15, 2) NOT NULL DEFAULT 0.00, 
    CONSTRAINT FK_CustomerAccount FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);


INSERT INTO Accounts (customer_id, account_type, balance)
VALUES 
(1, 'savings', 1000.00), -- John Doe's savings account
(1, 'current', 500.00),  -- John Doe's current account
(2, 'savings', 1500.00), -- Jane Smith's savings account
(3, 'zero_balance', 0.00); -- Alice Johnson's zero balance account

SELECT * FROM Accounts;

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY IDENTITY(1,1), 
    account_id INT NOT NULL, 
    transaction_type NVARCHAR(20) NOT NULL CHECK (transaction_type IN ('deposit', 'withdrawal', 'transfer')), 
    amount DECIMAL(15, 2) NOT NULL CHECK (amount > 0), 
    transaction_date DATETIME DEFAULT GETDATE(), 
    CONSTRAINT FK_AccountTransaction FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ON DELETE CASCADE
);

-- Insert into Transactions table
INSERT INTO Transactions (account_id, transaction_type, amount)
VALUES 
(1, 'deposit', 200.00), -- Deposit into John Doe's savings account
(1, 'withdrawal', 100.00), -- Withdrawal from John Doe's savings account
(2, 'deposit', 300.00), -- Deposit into John Doe's current account
(3, 'transfer', 50.00); -- Transfer from Jane Smith's savings account

SELECT * FROM Transactions;
-- Day 2(Task1 & Task2)
--1)
INSERT INTO Customers (first_name, last_name, DOB, email, phone_number, address)
VALUES
('Rahul', 'Sharma', '1985-03-12', 'rahul.sharma@email.com', '9876543210', '101 MG Road, Mumbai'),
('Priya', 'Patel', '1990-07-25', 'priya.patel@email.com', '8765432109', '202 Linking Road, Mumbai'),
('Amit', 'Singh', '1988-11-05', 'amit.singh@email.com', '7654321098', '303 Churchgate, Mumbai'),
('Neha', 'Gupta', '1992-02-18', 'neha.gupta@email.com', '6543210987', '404 Bandra West, Mumbai'),
('Vikram', 'Joshi', '1983-09-30', 'vikram.joshi@email.com', '5432109876', '505 Andheri East, Mumbai'),
('Anjali', 'Desai', '1995-04-22', 'anjali.desai@email.com', '4321098765', '606 Powai, Mumbai'),
('Ravi', 'Mehta', '1978-12-15', 'ravi.mehta@email.com', '3210987654', '707 Worli, Mumbai'),
('Sneha', 'Reddy', '1991-06-08', 'sneha.reddy@email.com', '2109876543', '808 Colaba, Mumbai'),
('Arjun', 'Malhotra', '1987-08-19', 'arjun.malhotra@email.com', '1098765432', '909 Juhu, Mumbai'),
('Divya', 'Iyer', '1993-01-27', 'divya.iyer@email.com', '0987654321', '1010 Dadar West, Mumbai');


SELECT customer_id FROM Customers;
SELECT * FROM Accounts;
SELECT customer_id, first_name, last_name FROM Customers;

INSERT INTO Accounts (customer_id, account_type, balance)
VALUES
(1, 'savings', 25000.00),
(1, 'current', 50000.00),
(5, 'savings', 35000.00),
(5, 'current', 45000.00),
(6, 'savings', 0.00),
(6, 'current', 75000.00),
(7, 'savings', 15000.00),
(7, 'current', 30000.00),
(9, 'savings', 20000.00),
(10, 'savings', 40000.00),
(10, 'current', 60000.00),
(11, 'savings', 55000.00),
(12, 'current', 80000.00),
(13, 'savings', 30000.00),
(13, 'current', 70000.00),
(14, 'savings', 10000.00),
(15, 'current', 90000.00),
(16, 'savings', 50000.00),
(16, 'current', 50000.00),
(17, 'savings', 35000.00),
(18, 'current', 85000.00),
(19, 'savings', 25000.00),
(19, 'current', 75000.00);


SELECT account_id, customer_id, account_type FROM Accounts;
select * from Accounts;


INSERT INTO Transactions (account_id, transaction_type, amount)
VALUES
(25, 'deposit', 25000.00),     
(26, 'deposit', 50000.00),     
(25, 'withdrawal', 5000.00),   
(27, 'deposit', 35000.00),     
(28, 'deposit', 45000.00),     
(28, 'withdrawal', 25000.00),  
(30, 'deposit', 75000.00),     
(31, 'deposit', 15000.00),     
(32, 'deposit', 30000.00),     
(32, 'transfer', 20000.00),    
(33, 'deposit', 20000.00),     
(34, 'deposit', 40000.00),     
(36, 'deposit', 55000.00),     
(37, 'deposit', 80000.00);     


2)
i)SELECT 
    c.first_name + ' ' + c.last_name AS customer_name,
    a.account_type,
    c.email
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

ii)
SELECT 
    c.first_name + ' ' + c.last_name AS customer_name,
    a.account_type,
    t.transaction_type,
    t.amount,
    t.transaction_date
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
JOIN Transactions t ON a.account_id = t.account_id
ORDER BY c.customer_id, a.account_id, t.transaction_date;

iii)
UPDATE Accounts
SET balance = balance + 5000
WHERE account_id = 25;

iV)
SELECT 
    first_name + ' ' + last_name AS full_name
FROM Customers;

v)
DELETE FROM Accounts
WHERE account_type = 'savings' AND balance = 0;

vi)

SELECT *
FROM Customers
WHERE address LIKE '%Mumbai%';

vii)

SELECT balance
FROM Accounts
WHERE account_id = 26;

viii)

SELECT *
FROM Accounts
WHERE account_type = 'current' AND balance > 1000;

iX)

SELECT *
FROM Transactions
WHERE account_id = 25
ORDER BY transaction_date;

x)

SELECT 
    account_id,
    customer_id,
    balance,
    balance * 0.04 AS annual_interest,
    balance * 0.04 / 12 AS monthly_interest
FROM Accounts
WHERE account_type = 'savings';

xi)

SELECT *
FROM Accounts
WHERE balance < 500;

xii)

SELECT *
FROM Customers
WHERE address NOT LIKE '%Mumbai%';


---Day3(Task3  & Task4)

--1)
SELECT AVG(balance) AS average_balance
FROM Accounts;

--2)
SELECT TOP 10 account_id, customer_id, balance
FROM Accounts
ORDER BY balance DESC;

--3)
SELECT SUM(amount) AS total_deposits
FROM Transactions
WHERE transaction_type = 'deposit'
AND CAST(transaction_date AS DATE) = '2023-01-01';

--4)

-- Oldest customer
SELECT TOP 1 * FROM Customers ORDER BY DOB ASC;

-- Newest customer
SELECT TOP 1 * FROM Customers ORDER BY DOB DESC;

--5)

SELECT t.*, a.account_type
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id;

--6)
SELECT c.*, a.account_id, a.account_type, a.balance
FROM Customers c
LEFT JOIN Accounts a ON c.customer_id = a.customer_id;

--7)

SELECT c.first_name, c.last_name, t.*
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id
WHERE t.account_id = 1; 

--8)

SELECT c.customer_id, c.first_name, c.last_name, COUNT(a.account_id) AS account_count
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(a.account_id) > 1;

--9)

SELECT 
    account_id,
    SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE 0 END) - 
    SUM(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END) AS net_difference
FROM Transactions
GROUP BY account_id;


---10)
SELECT 
    account_id,
    AVG(amount) AS average_daily_balance
FROM Transactions
WHERE transaction_date BETWEEN '2025-03-23' AND '2025-03-25' -- Replace with your date range
GROUP BY account_id;

select * from Transactions;

---11)

SELECT 
    account_type,
    SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;

---12)

SELECT 
    account_id,
    COUNT(*) AS transaction_count
FROM Transactions
GROUP BY account_id
ORDER BY transaction_count DESC;

---13)

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    a.account_type,
    SUM(a.balance) AS total_balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.account_type
HAVING SUM(a.balance) > 10000 
ORDER BY total_balance DESC;

----14)

SELECT 
    account_id,
    amount,
    CAST(transaction_date AS DATE) AS transaction_date,
    COUNT(*) AS duplicate_count
FROM Transactions
GROUP BY account_id, amount, CAST(transaction_date AS DATE)
HAVING COUNT(*) > 1;


---TASK 4

--1)
SELECT c.*
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
WHERE a.balance = (SELECT MAX(balance) FROM Accounts);


---2)
SELECT AVG(avg_balance) AS average_balance_multi_account
FROM (
    SELECT c.customer_id, AVG(a.balance) AS avg_balance
    FROM Customers c
    JOIN Accounts a ON c.customer_id = a.customer_id
    GROUP BY c.customer_id
    HAVING COUNT(a.account_id) > 1
) AS multi_account_customers;

---3)

SELECT DISTINCT a.*
FROM Accounts a
JOIN Transactions t ON a.account_id = t.account_id
WHERE t.amount > (SELECT AVG(amount) FROM Transactions);

--4)

SELECT c.*
FROM Customers c
WHERE c.customer_id NOT IN (
    SELECT DISTINCT a.customer_id
    FROM Accounts a
    JOIN Transactions t ON a.account_id = t.account_id
);

---5)
SELECT SUM(balance) AS total_balance_no_transactions
FROM Accounts
WHERE account_id NOT IN (SELECT DISTINCT account_id FROM Transactions);

--6)

SELECT t.*
FROM Transactions t
WHERE t.account_id IN (
    SELECT account_id 
    FROM Accounts 
    WHERE balance = (SELECT MIN(balance) FROM Accounts)
);



--7)

SELECT c.*
FROM Customers c
WHERE c.customer_id IN (
    SELECT customer_id
    FROM Accounts
    GROUP BY customer_id
    HAVING COUNT(DISTINCT account_type) > 1
);


--8)

SELECT 
    account_type,
    COUNT(*) AS count,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Accounts) AS percentage
FROM Accounts
GROUP BY account_type;


---9)

SELECT t.*
FROM Transactions t
WHERE t.account_id IN (
    SELECT account_id 
    FROM Accounts 
    WHERE customer_id = 1
);


--10)
SELECT 
    account_type,
    SUM(balance) AS type_total,
    SUM(balance) * 100.0 / (SELECT SUM(balance) FROM Accounts) AS percentage_of_total
FROM Accounts
GROUP BY account_type;
