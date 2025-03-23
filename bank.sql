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