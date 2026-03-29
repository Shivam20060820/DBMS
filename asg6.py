import pymysql
#python -m pip install pymysql
db=pymysql.connect(user="root",host="localhost",password="your_pass")
cursor=db.cursor()

cursor.execute("drop database shivam_banking")
cursor.execute("create database if not exists shivam_banking")
print("shivam_banking db created")
cursor.execute("use shivam_banking")
cursor.execute("create table customer (customer_id int primary key, name varchar(50), dob date, phone varchar(15), email varchar(50), address varchar(100))")
cursor.execute("create table account (account_no int primary key, customer_id int, account_type varchar(20), balance decimal(10,2), open_date date, foreign key (customer_id) references customer(customer_id));")
cursor.execute("create table transactions(transaction_id int primary key, account_no int, type varchar(10), amount decimal(10,2), txn_date timestamp, foreign key (account_no) references account(account_no));")
cursor.execute("create table branch (branch_id int primary key, branch_name varchar(50), city varchar(50))")
cursor.execute("create table employee (employee_id int primary key, name varchar(50), position varchar(30), salary decimal(10,2), branch_id int, foreign key (branch_id) references branch(branch_id));")

sql = "insert into customer values (%s,%s,%s,%s,%s,%s)"
val = [
    (1,"rahul","2000-01-10","9876543210","rahul@gmail.com","pune"),
    (2,"amit","1999-05-12","9876543211","amit@gmail.com","mumbai"),
    (3,"neha","2001-03-22","9876543212","neha@gmail.com","nashik"),
    (4,"sneha","2002-07-18","9876543213","sneha@gmail.com","nagpur"),
    (5,"rohit","1998-11-30","9876543214","rohit@gmail.com","delhi")
]
cursor.executemany(sql,val)

sql = "insert into account values (%s,%s,%s,%s,%s)"
val = [
    (101,1,"savings",5000.00,"2023-01-01"),
    (102,2,"current",10000.00,"2023-02-01"),
    (103,3,"savings",7500.00,"2023-03-01"),
    (104,4,"current",2000.00,"2023-04-01"),
    (105,5,"savings",9000.00,"2023-05-01")
]
cursor.executemany(sql,val)

sql = "insert into transactions values (%s,%s,%s,%s,%s)"
val = [
    (1,101,"deposit",1000.00,"2024-01-01 10:00:00"),
    (2,102,"withdraw",500.00,"2024-01-02 11:00:00"),
    (3,103,"deposit",2000.00,"2024-01-03 12:00:00"),
    (4,104,"withdraw",1000.00,"2024-01-04 01:00:00"),
    (5,105,"deposit",1500.00,"2024-01-05 02:00:00")
]
cursor.executemany(sql,val)

sql = "insert into branch values (%s,%s,%s)"
val = [
    (1,"pune_branch","pune"),
    (2,"mumbai_branch","mumbai"),
    (3,"nashik_branch","nashik"),
    (4,"nagpur_branch","nagpur"),
    (5,"delhi_branch","delhi")
]
cursor.executemany(sql,val)

sql = "insert into employee values (%s,%s,%s,%s,%s)"
val = [
    (1,"raj","manager",50000.00,1),
    (2,"vikas","clerk",30000.00,2),
    (3,"pooja","cashier",25000.00,3),
    (4,"anil","manager",55000.00,4),
    (5,"kiran","clerk",28000.00,5)
]
cursor.executemany(sql,val)
print("customers table-")
cursor.execute("select * from customer")
for row in cursor.fetchall():
    print(row)
print(" ")


cursor.execute("alter table customer add column gender varchar(10)")

# cursor.execute("alter table customer add column gender varchar(10)")
print("customers table after adding column gender ")
cursor.execute("select * from customer")
for row in cursor.fetchall():
    print(row)
print(" ")

print("account table-")
cursor.execute("select * from account")
for row in cursor.fetchall():
    print(row)
print(" ")

cursor.execute("update account set balance = 8000 where account_no = 101")
print("account table after updating the value")
cursor.execute("select * from account")
for row in cursor.fetchall():
    print(row)


# cursor.execute("delete from customer where customer_id = 5")

# cursor.execute("select * from customer")
# for row in cursor.fetchall():
#     print(row)


db.commit()
db.close()
