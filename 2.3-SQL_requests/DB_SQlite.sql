
/* TO DO 
    OK Récupérer tous les albums
    OK Récupérer tous les albums dont le titre contient "Great" (indice)
    OK Donner le nombre total d'albums contenus dans la base (sans regarder les id bien sûr)
    OK Supprimer tous les albums dont le nom contient "music"
    OK Récupérer tous les albums écrits par AC/DC
    OK Récupérer tous les titres des albums de AC/DC
    OK Récupérer la liste des titres de l'album "Let There Be Rock"
    Afficher le prix de cet album ainsi que sa durée totale
    Afficher le coût de l'intégralité de la discographie de "Deep Purple"
    Créer l'album de ton artiste favori en base, en renseignant correctement les trois tables albums, artists et tracks
*/

/* 1) Collect all albums */
SELECT * FROM albums;

/* 2) Collect all albums that includs "great" */
SELECT * FROM albums
WHERE Title LIKE '%great%';

/* OPTIONNAL : Find the name of the column */
    .header on
    SELECT * FROM albums LIMIT 1;

/* 3) Count total number of albums in the database */
SELECT COUNT (AlbumId)
FROM albums;
/* ==> 347 */

/* 4) Delete albums that includes Music */
DELETE FROM albums 
WHERE Title LIKE '%music%';
/* ==> all albums now 343 (4 deleted)*/

/* 5) Collect all albums written by AC/DC */
SELECT (Title)
FROM albums
INNER JOIN artists
ON albums.ArtistId=artists.ArtistId
WHERE artists.Name = 'AC/DC';

/* 6) Collect all the tracks of ACDC albums */
SELECT (Name)
FROM tracks
INNER JOIN albums
ON tracks.AlbumId=albums.AlbumId
WHERE albums.Title = 'For Those About To Rock We Salute You' OR albums.Title = 'Let There Be Rock' ;

/* OTHER METHOD */
SELECT tracks.Name
FROM tracks
INNER JOIN albums ON tracks.AlbumId=albums.AlbumId
INNER JOIN artists ON artists.ArtistId = albums.ArtistId
WHERE artists.Name='AC/DC';

/* 7) Collect all the tracks of ACDC album Let There Be Rock */
SELECT (Name)
FROM tracks
INNER JOIN albums
ON tracks.AlbumId=albums.AlbumId
WHERE albums.Title = 'Let There Be Rock' ;

/* 8) Price & Duration of album Let There Be Rock */
SELECT SUM(Milliseconds), SUM(UnitPrice) FROM tracks
INNER JOIN albums ON tracks.AlbumId=albums.albumId
WHERE albums.Title="Let There Be Rock";

/* 9) Price DeepPurple albums */
SELECT SUM(UnitPrice)
FROM tracks
INNER JOIN albums ON tracks.AlbumId=albums.AlbumId
INNER JOIN artists ON artists.ArtistId = albums.ArtistId
WHERE artists.Name='Deep Purple';

/* 10) Create album with the 3 tables artists, album and tracks values */

INSERT INTO artists (name) VALUES ('The Beatles');
INSERT INTO albums (Title, ArtistId) VALUES ('Abbey Road', (SELECT ArtistId FROM artists WHERE artists.name = 'The Beatles'));

INSERT INTO tracks (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES ('Come Together', (SELECT AlbumId FROM albums WHERE albums.Title = 'Abbey Road'), (SELECT MediaTypeId FROM media_types WHERE media_types.Name = 'MPEG audio file'), (SELECT GenreId FROM genres WHERE genres.Name = 'Rock'), 'John Lennon', 258000, 4371533, 0.99 );