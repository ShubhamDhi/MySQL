1. What are the names of all the customers who live in New York?
Select firstname, lastname From customers 
Where city = "New York"


2. What is the total number of accounts in the Accounts table?
Select count(*) 
From accounts


3. What is the total balance of all checking accounts?
Select AccountType, sum(balance) As total_balance 
From accounts
Where accounttype = "Checking"
 
 
4. What is the total balance of all accounts associated with customers who live in Los Angeles?
Select c.city as customer_city, sum(balance) As total_Balance 
From accounts as a
Join customers as c on c.customerID = a.customerID
Where city = "Los Angeles"


5. Which branch has the highest average account balance?
Select b.branchName, avg(a.balance) as avg_Balance 
From accounts as a
Join branches as b on b.branchID = a.branchID
Group by b.branchName
Order by avg(a.balance) desc


6. Which customer has the highest current balance in their accounts?
Select c.firstname, a.balance from customers as c
Join accounts as a on a.customerID = c.customerID
Order by a.balance desc
Limit 1


7. Which branch has the highest total balance across all of its accounts?
select b.branchID, b.branchName, sum(a.balance) AS total_balance
from branches as b 
Join accounts as a on a.branchId = b.branchId
group by b.branchId
Order by total_balance desc
Limit 1


8. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
select c.customerID, c.firstName, sum(a.balance) AS total_balance
from customers as c
Join accounts as a on a.customerId = c.customerId
Where a.AccountType IN ('Savings', 'Checking')
group by c.customerID
Order by total_balance desc
Limit 1


9. Which branch has the highest number of transactions in the Transactions table?
Select b.branchID as BranchID, b.branchName, COUNT(t.transactionID) as TransactionCount
From branches as b
Join accounts as a on b.branchID = a.branchID
Join transactions as t on t.accountID = a.accountID
Group by b.branchID, b.branchName;