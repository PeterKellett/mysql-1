/*--------------------Tutorials---------------*/
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
