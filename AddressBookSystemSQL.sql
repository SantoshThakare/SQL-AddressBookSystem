--1Creating the database

create database Address_Book_System

--2Creating address book table

create table AddressBookTable
(
  personId int identity(1,1) primary key,
  firstName varchar(100),
  lastName varchar(100),
  address varchar(200),
  city varchar(50),
  state varchar(100),
  zipCode bigint,
  phoneNumber bigint,
  email varchar(50)
)
--3-Insert Records into the table

insert into AddressBookTable values ('Santosh','Thakare','K.K.Nagar','Dhule','Maharashtra',600007,8642536784,'santoshthakare50@gmail.com');
insert into AddressBookTable values('Arjun','Patil','MGR Nagar','Nandurbar','Maharashtra',689542,9875621552,'arjun23@gmail.com');
insert into AddressBookTable values('Nilesh','Bhamre','hgh Nagar','Indore','Madhya Pradesh',869456,8654973250,'nilesh5@gmail.com');
insert into AddressBookTable values('Manish','singh','hf Nagar','Jalgaon','Maharashtra',869456,8654973250,'manish55@gmail.com');
insert into AddressBookTable values('Dipak','Patil','hfh Nagar','Pune','Maharashtra ',869456,8654973250,'dipak4@gmail.com');

select * from AddressBookTable

-- 4Edit contact in table
update AddressBookTable set email='manishsingh45@gmail.com' where firstName='Manish' and lastName='singh'

-- 5Delete the record from table
delete from AddressBookTable where firstName='Manish' and lastName='singh' 

-- 6 Retriving record based on City or state
select * from AddressBookTable where state='Maharashtra' or city='Jalgaon'
select * from AddressBookTable where state = 'Madhya Pradesh'

--7 Calculate the size of the record by state or city
select count(phoneNumber)as NoOfContact,state from AddressBookTable group by state
select count(phoneNumber) as NoOfContact,city from AddressBookTable group by city

--8 Retrive Record Base on city sorted order
select * from AddressBookTable where city='Jalgaon' order by(lastName)
select * from AddressBookTable where state='Maharashtra' order by(firstName)

--9-Adding type of the contact
alter table addressBookTable add bookType varchar(200)
update AddressBookTable set bookType='Family' where personId=1 or personId=3
update AddressBookTable set bookType='Friend' where personId=2
update AddressBookTable set bookType='Profession' where personId=5

--10 Calculating the size of the record based on type
select count(phoneNumber)as NoOfContact,bookType from AddressBookTable group by bookType

--11 Adding contact in Two type

insert into AddressBookTable values ('Sanjay','Koli','K.K.Nagar','Nandurbar','Maharashtra',600007,8662536784,'sanju45@gmail.com','Friend')

--12 Create the ER Diagram for the Table
Create table ContactType 
(
 typeId int primary key,
 typeName varchar(50)
)

create table ContactAddress
(
 contactId int ,
 typeId int
)

create table AddressBook
(
  personId int identity(1,1) primary key,
  firstName varchar(100),
  lastName varchar(100),
  address varchar(200),
  city varchar(50),
  state varchar(100),
  zipCode bigint,
  phoneNumber bigint,
  email varchar(50),
  typeId int
)
--inserting records into the AddressBook

Insert into AddressBook (firstName,lastName,address,city,state,zipCode,phoneNumber,email) 
Select firstName,lastName,address,city,state,zipCode,phoneNumber,email from AddressBookTable

Alter table AddressBook drop column typeId

--Insert the contact type of table such as Friends and family, Profession
insert into ContactType values (1,'Friend'),(2,'Family'),(3,'Profession')
select * from ContactType

--Insert the Contact Address that link type and person id
insert into ContactAddress values(2,2),(3,2),(2,1),(4,1),(5,3)
select * from ContactAddress

Alter table ContactAddress Add foreign key (contactId) REFERENCES AddressBook(personId)
Alter table ContactAddress Add foreign key (typeId) REFERENCES ContactType(typeId)

----13 Checking the Retrival 
----6 Retriving record based on City or state
select * from AddressBook where state='Maharashtra' or city='Pune'

select * from AddressBook where state = 'Dhule'

--7 Calculate size of record by state or city
select count(phoneNumber)as NoOfContact,state from AddressBook group by state
select count(phoneNumber) as NoOfContact,city from AddressBook group by city

--8 Retrive Record Base on city sorted order
select * from AddressBook where city='Jalgaon' order by(lastName)
select * from AddressBook where state='Maharashtra' order by(firstName)

--10- count number of person by type
SELECT count(ContactAddress.contactId) as NoOfContact,ContactType.typeName
from ContactAddress
full join ContactType on ContactAddress.typeId=ContactType.typeId
group by ContactType.typeName

drop table AddressBookTable
select * from AddressBook