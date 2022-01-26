Create Database SinemaDb;
use SinemaDb

create table Genres(
	Id int primary key identity,
	GenreName nvarchar(50) not null
)

Insert Into Genres(GenreName)
Values  ('Comedy'),
		('Crime'),
		('Horror'),
		('Romance'),
		('Action')

create table Customers(
	Id int primary key identity,
	CustomerName nvarchar(50) not null,
	CustomerContact nvarchar(50)
)

Insert Into Customers(CustomerName,CustomerContact)
Values  ('Idris Jafarzade','+99450*******'),
		('Namiq Haydarof','+99455*******'),
		('Parviz Asadov', '+99450*******'),
		('Orxhan Abdullayev','+99450*******'),
		('Elnur Maharramli','+99470*******'),
		('Azim Mammadov','+99450*******')

create table Halls(
	Id int primary key identity,
	HallNumber nvarchar(50) not null
)

Insert Into Halls(HallNumber)
Values  ('First Hall'),
		('Second Hall'),
		('Third Hall'),
		('Fourth Hall')
	
create table Sessions(
	Id int primary key identity,
	SessionDay nvarchar(50) not null,
	SessionTime nvarchar(50) not null
)

Insert Into Sessions(SessionDay,SessionTime)
Values ('Monday','11:00 AM'),
		('Tuesday','15:00 PM'),
		('Wednesday','9:00 AM'),
		('Thursday','18:00 PM'),
		('Friday','15:00 PM'),
		('Saturday','21:00 PM'),
		('Sunday','23:00 PM')

create table Actors(
	Id int primary key identity,
	ActorName nvarchar(50) not null,
	ActorLName nvarchar(50) not null,
	ActorRating decimal(10,2) ,
	Nationality nvarchar(50) not null,
	Gender nvarchar(20) not null,
)

Insert Into Actors(ActorName,ActorLName,ActorRating,Nationality,Gender)
Values ('Tom','Cruise',9.5,'american','male'),
		('Margot','Robbie',9.4,'australian','female'),
		('Keanu','Reeves',9.6,'lebanese','male'),
		('Natalie','Portman',9.3,'jewish','female'),
		('Angelina','Jolie',9.7,'american','female'),
		('Jim','Carrey',9.8,'canadian','male')

create table Movies(
	Id int primary key identity,
	MovieName nvarchar(50) not null,
	Country nvarchar(50) ,
	RelasedYear nvarchar(50) not null,
	MovieRating decimal(10,2),
	Duration nvarchar(50) not null,
	ActorId int references Actors(Id),
	GenreId int references Genres(Id)
)

Insert Into Movies(MovieName,Country,RelasedYear,MovieRating,Duration,ActorId,GenreId)
Values	('The Mask','USA','1994',6.9,'1hr 40min',6,1),
		('Focus','USA','2015',6.6,'1hr 44min',2,4),
		('Mission Impossible 6','USA','2018',7.7,'2hr 28min',1,5),
		('Taking Lives','USA','2004',6,'1hr 43min',5,2),
		('Annihilation','USA','2018',7.0,'2hr',4,3),
		('John Wick','USA','2014',7.4,'1hr 41min',3,5)

create table Tickets(
	Id int primary key identity,
	Price decimal(10,2) not null,
	MovieId int references Movies(Id),
	CustomerId int references Customers(Id),
	HallId int references Halls(Id),
	SessionId int references Sessions(Id)
)

Insert Into Tickets(Price,MovieId,CustomerId,HallId,SessionId)
Values  (40,1,1,2,3),
		(30,2,2,4,2),
		(60,3,3,3,5),
		(30,4,4,2,7),
		(40,5,5,1,1),
		(50,6,6,4,4)

CREATE VIEW v_TicketInfo
AS
Select t.Id , Price, MovieName,GenreName, Duration, CustomerName,CustomerContact,HallNumber,SessionTime,ActorName,ActorLName from Tickets t
Join Movies m
ON t.MovieId = m.Id

Join Genres g
ON m.GenreId = g.Id

Join Actors a
ON m.ActorId = a.Id

Join Customers c
ON t.CustomerId = c.Id

Join Halls h
ON t.HallId = h.Id

Join Sessions s
On t.SessionId = s.Id

Select * FROM v_TicketInfo

