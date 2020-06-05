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
