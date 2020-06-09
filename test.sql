/*--------------------Tutorials---------------*/
/*To run the SQL Queries type <mysql> into CLI. Then <use Chinook;>. To run this sql file use <source test.sql>
    Useful commands
    show Tables;
    desc <table name>;/*

/*The SELECT statement*/
Select Name from Artist;
Select firstName, lastName from Customer;
Select * from Track;
Select Name from MediaType;
select count(*) from Track;
select count(*) from Artist;

/*The WHERE clause*/
Select * from Track
    where Composer = 'U2';
Select * from Album
    where AlbumId = 232;
Select FirstName, LastName, Title from Employee
    where Title = 'IT Staff';

/*The Join functionality*/
Select * from Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId limit 5;
desc Track;
desc Album;
Select Name, Title, ArtistId from Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId Limit 5;
select Name as Track, Title as Album, ArtistId from Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId Limit 5;
select Track.Name as Track, Album.Title as Album, Artist.Name as Artist from Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId
    INNER JOIN Artist on Album.ArtistId = Artist.ArtistId limit 5;
select Track.Name as Track, Album.Title as Album, Artist.Name as Artist from Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId
    INNER JOIN Artist on Album.ArtistId = Artist.ArtistId
    WHERE Artist.Name = 'U2' limit 5;
select Track.Name as Track, Album.Title as Album, Artist.Name as Artist from Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId
    INNER JOIN Artist on Album.ArtistId = Artist.ArtistId
    WHERE Artist.Name = 'U2' and Track.Name = 'Pride (IN the name of Love)';
select Track.Name as Track, Album.Title as Album, Artist.Name as Artist from Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId
    INNER JOIN Artist on Album.ArtistId = Artist.ArtistId
    WHERE Track.Name = 'Believe';

/*----------------------Challenges-----------------*/
/*Challenge 1
Join the 'Track' table and the 'MediaType' table to create a query that shows the Name of the Track, and the Name of the Media Type. Both tables have a 'MediaTypeId' column that you can join on.

            Expected Result: 3503 rows (Here's a sample, actual tracks may be different)

            For Those About To Rock (We Salute You) MPEG audio file
            Balls to the Wall                       Protected AAC audio file
            Fast As a Shark	                        Protected AAC audio file*/
desc Track;
desc MediaType;
select Track.Name as Track, MediaType.Name as 'Media Type' from Track
    inner join MediaType on Track.MediaTypeId = MediaType.MediaTypeId;

/*Challenge 2
Similar Query to above, but join the track table to the Genre table, show the names of the tracks and genres in the results. Figure out the columns you can join on, any aliases that you need. Filter the results to only show 'Jazz' tracks

            Expected: 130 rows (Here's a sample, actual tracks may be different)

            Desafinado	                              Jazz
            Garota De Ipanema	                      Jazz
            Samba De Uma Nota Só (One Note Samba)	  Jazz
            */
desc Track;
desc Genre;
select Track.Name as Track, Genre.Name as Genre from Track
    inner join Genre on Track.GenreId = Genre.GenreId
    where Genre.Name = 'jazz';

/*Challenge 3
Create a Query that shows: The name of a track, the name of it's MediaType, and the name of it's genre. You'll need to join 3 tables together with the appropriate join columns. Add a filter to only show tracks with a MediaType of "Protected AAC audio file" and a Genre of "Soundtrack".

            Expected: 1 row

            Koyaanisqatsi	    Protected AAC audio file	    Soundtrack
            */
desc Track;
desc MediaType;
desc Genre;
select Track.Name as Track, MediaType.Name as 'Media Type', Genre.Name as Genre from Track
    inner join MediaType on Track.MediaTypeId = MediaType.MediaTypeId
    inner join Genre on Track.GenreId = Genre.GenreId
    where MediaType.Name = 'Protected AAC audio File' and Genre.Name = 'Soundtrack';

/*Challenge 4
Filter to only show results for the 'Grunge' playlist

            Expected: 15 rows (example)

            Grunge	  Hunger Strike	      Temple of the Dog	      Temple of the Dog
            Grunge	  Man In The Box	  Facelift	              Alice In Chains
            Grunge	  Evenflow	          Ten	                  Pearl Jam
            */
select Playlist.Name as Playlist, Track.Name as Track, Album.Title as Album, Artist.Name as Artist from Playlist
    inner join PlaylistTrack on Playlist.PlaylistId = PlaylistTrack.PlaylistId
    join Track on PlaylistTrack.TrackId = Track.TrackId
    join Album on Track.AlbumId = Album.AlbumId
    join Artist on Album.ArtistId = Artist.ArtistId
    where Playlist.Name = 'Grunge';

/*Challenge 5
Find a playlist that contains only 1 track.*/
SELECT Playlist.Name as Playlist, COUNT(*) From Playlist 
    INNER JOIN PlaylistTrack on Playlist.PlaylistId = PlaylistTrack.PlaylistId  
    GROUP BY Playlist HAVING count(*) = 1;

/*-------------ORDER BY------------*/
select * from Album
    order by Title desc;

select * from Album
    order by ArtistId, Title desc;

select Track.Name, Album.Title from Track
    inner join Album on Track.AlbumId = Album.AlbumId
    order by Album.Title, Track.Name;

select InvoiceDate, BillingCity, Total from Invoice
    order by Total desc
    limit 5;

/*--Order by Challenge 1--*/
/*Select the InvoiceDate, BillingAddress, and Total from the Invoices table, Ordered by InvoiceDate Descending*/
select InvoiceDate, BillingAddress, Total from Invoice
    order by InvoiceDate desc;

/*Challenge 2*/
/*We need to fire the last three people hired. Select the EmployeeId, LastName, FirstName and HireDate of the 3 Employees with the most recent HireDate*/
select EmployeeId, LastName, FirstName, HireDate from Employee
    order by HireDate desc limit 3;

/*Challenge 3*/
/*Disaster, we've heard from Steve Johnson's lawyers.
He claims that Michael Mitchell was hired on the same day as him, but was hired later in the day. Mitchell should have been let go, not him.
Confirm this by extending the number of results and make sure nobody else was hired on that day.
Then modify the query to return the correct 3 people.
Continue to use HireDate as the primary sort column, but use EmployeeId as the tie breaker.
Assume that a higher EmployeeId means they were hired later.*/
select EmployeeId, LastName, FirstName, HireDate from Employee
    order by HireDate desc, EmployeeId desc limit 3;

/*Challenge 4*/
/*Create a query that shows our 10 biggest invoices by Total value, in descending order.
If two invoices have the same Total, the more recent should appear first.
The query should also show the Name of the Customer*/
select Customer.FirstName, Customer.LastName, Invoice.Total from Invoice
    join Customer on Invoice.CustomerId = Customer.CustomerId
    order by Total desc, InvoiceDate desc limit 10;


/*-------------COUNT------------*/
select count(*) from Customer;
select count(FirstName) from Customer;
select count(*) from Customer
    where FirstName = "Frank";

/*COUNT Challenges*/
/*How Many Customers is Employee 4 the Sales Support Agent For?*/
select count(*) from Customer
    where SupportRepId = 4;

/*Challenge 2*/
/*How Many Customers is Jane Peacock the Sales Support Agent For?*/
select Employee.FirstName as Employee, count(Customer.FirstName) as Customer from Employee
    join Customer on Employee.EmployeeId = Customer.SupportRepId
    where Employee.FirstName = "Jane";

/*Challenge 3*/
/*Which Media Type is most popular? How could you answer this with a single query? You probably cannot based on what you know so far. We will get there.*/
/*Hint: For now, you can use a separate query for each media type so see how many tracks use it. Expected : MPEG audio file*/
select count(TrackId) from Track
    where MediaTypeId = 1;
select count(TrackId) from Track
    where MediaTypeId = 2;
select count(TrackId) from Track
    where MediaTypeId = 3;


/*The MIN function*/
select min(LastName) from Customer;

/*MIN function challenge*/
/*What is the date of birth of our oldest employee?*/
select min(BirthDate) from Employee;

/*The MAX function*/
select max(LastName) from Customer;

/*The MAX function challenge*/
/*On what date was our most recent employee hired?*/
select max(HireDate) from Employee;

/*The Average function*/
select avg(Total) from Invoice;

/*The ROUND function*/
select round(avg(Total), 2) from Invoice;

/*The SUM Expression*/
/*Aggregate functions can sometimes allow us to verify the same information from two sources.
Here is the total value for invoice number 2.*/
select Total from Invoice
    where InvoiceId = 2;
/*Here's what we get by taking the line items from that invoice, multiplying the price by quantity to get the total for each line item.
Then we use the sum function to get the total for the invoice.
You can see here we got the same result of 3.96.*/
select sum(UnitPrice * Quantity) from InvoiceLine
    where InvoiceId = 2;

/*The GROUP BY clause*/
select Album.Title, count(*) from Track
    inner join Album on Track.AlbumId = Album.AlbumId
    group by Track.AlbumId;
/*The key to the group by is that the repeating value in the grouped column, AlbumID, defines a group of rows and gets collapsed into one row.*/
/*So here, we've shown the cheapest track on each album using the min aggregate function.*/
select AlbumId, min(UnitPrice) from Track
    group by AlbumId;
/*And we can do the same thing using the max function to find the most expensive track on each album.*/
select AlbumId, max(UnitPrice) from Track
    group by AlbumId;
/*Now let's find the total cost of each album.
Here we will round to two decimal places and sum the unit price.*/
select AlbumId, round(sum(UnitPrice), 2) from Track
    group by AlbumId;
/*So now we need to join the album table to include the title of the album.
So this shows the exact same data in the right town column the cost of the album, but this time with an album name in the left-hand column.*/
select Album.Title, round(sum(UnitPrice), 2) from Track
    join Album on Track.AlbumId = Album.AlbumId
    group by Track.AlbumId;

/*Challenge 1*/
/*How many customers do we have in the City of Berlin Expected : 2*/
select count(City) from Customer
    where City = 'Berlin';

/*Challenge 2*/
/*How much has been made in sales for the track "The Woman King". Expected : 3.98*/
select sum(InvoiceLine.UnitPrice * InvoiceLine.Quantity), Track.Name as Track from InvoiceLine
    join Track on InvoiceLine.TrackId = Track.TrackId
    where Track.Name = 'The Woman King';

/*Challenge 3*/
/*Create a list of the top 5 acts by number of tracks. The table should include the name of the artist and the number of tracks they have.
    Iron Maiden	    213
    U2	            135
    Led Zeppelin	114
    Metallica	    112
    Deep Purple	    92*/
select Artist.Name as Artist, count(Track.TrackId) as Tracks from Artist
    join Album on Artist.ArtistId = Album.ArtistId
    join Track on Album.AlbumId = Track.AlbumId
    group by Artist.Name
    order by Tracks desc limit 5;

/*------INSERT-----*/
insert into MediaType (Name)
    values ("Test Media Type 1");

/*insert into Album (Title, ArtistId)
    values ("Boy", 150);*/
select AlbumId from Album   
    where Title = "Boy";
select MediaTypeId from MediaType
    where Name = "Protected AAC Audio File";
select GenreId from Genre
    where Name = "Rock";
/*Insert Challenge 1*/
/*Insert the remaining Tracks for the Album Boy*/
/*insert into Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
    values ("A Day Without Me", 348, 2, 1, "U2", 220000, 1234, 0.99);*/
select * from Track
    where AlbumId = 348;

/*Insert Challenge 2*/
/*Run the following Query. It gives an error. Read and understand the error, then fix the problem

            Insert into Track (Name, AlbumId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
            values("Extra Track", 348, 1, "U2", 290000, 1234, 0.99);
            */
/*Insert into Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
            values("Extra Track", 348, 2, 1, "U2", 290000, 1234, 0.99);*/
select * from Track
    where AlbumId = 348;

/*Insert Challenge 3*/
/*Use one insert statement to insert multiple tracks at the same time*/
/*insert into Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
    values 
    ("Another Time, Another Place", 348, 2, 1, "U2", 220000, 1234, 0.99),
    ("The Electric Co", 348, 2, 1, "U2", 220000, 1234, 0.99),
    ("Shadows and Tall Trees", 348, 2, 1, "U2", 220000, 1234, 0.99);*/

select * from Track
    where AlbumId = 348;