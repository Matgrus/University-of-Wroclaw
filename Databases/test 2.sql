-- Mateusz Gruszecki, mpy
-- Zadanie 1
-- 	Przyjmijmy, że post p jest duplikatem jakiegoś posta r jeśli w tabeli postlinks istnieje wpis z postid równym id posta p,
-- 	relatedpostid równym id posta r oraz z linktypeid wynoszącym 3.
-- 	Dla każdego użytkownika wypisz jego id, displayname, reputation oraz sumaryczną liczbę jego postów, które są duplikatami innych postów.
-- 	Uwzględnij wyłącznie użytkowników, dla których powyższa liczba jest większa od zera.
-- 	Wyniki posortuj w pierwszej kolejności malejąco względem ostatniej kolumny (tj. wg sumarycznej liczby jego postów, które są duplikatami innych postów),
-- 	a następnie alfabetycznie wg drugiej kolumny (tj. displayname użytkownika).
-- 	Wypisz nie więcej niż pierwsze 20 wyników.

select users.id, displayname, reputation, count(distinct posts.id) as suma from users
join posts on (owneruserid = users.id) 
join postlinks on (postid = posts.id) 
where linktypeid = 3 
group by users.id, displayname, reputation 
order by suma desc, displayname asc limit 20;

-- Zadanie 2
-- 	Dla każdego użytkownika posiadającego odznakę Fanatic (wg badges) wypisz jego id, displayname, 
-- 	reputation oraz sumaryczną liczbę komentarzy do jego postów oraz średni score tych komentarzy.
-- 	Zostaw tylko te wyniki, dla których sumaryczna liczba komentarzy nie przekracza 100.
-- 	Wyniki posortuj w pierwszej kolejności malejąco względem przedostatniej kolumny (tzn. sumarycznej liczby komentarzy), 
-- 	a następnie alfabetycznie wg drugiej kolumny (tj. displayname użytkownika). Wypisz nie więcej niż pierwsze 20 wyników.

select users.id, displayname, reputation, count(comments.id) as suma, avg(comments.score) as srednia from users join badges on (userid = users.id) 
left join posts on (owneruserid = users.id) 
left join comments on (postid = posts.id) 
where badges.name = 'Fanatic' 
group by users.id, displayname, reputation 
having count(comments.id) <= 100 
order by suma desc, displayname asc limit 20;

-- Zadanie 3
-- 	Spraw aby atrybut id tabeli users był jej kluczem głównym.
-- 	Dodaj klucz obcy, który wymusi aby w tabeli badges wszystkie niepuste wartości userid występowały jako id w tabeli users.
-- 	Usuń kolumnę viewcount tabeli posts.
-- 	Usuń wszystkie krotki z tabeli posts takie, że ich body jest pustym napisem lub nullem.

alter table users add primary key (id);
alter table badges add constraint fk_users_id foreign key (userid) references users(id) deferrable;
alter table posts drop column viewcount;
delete from posts where body is null or body = '';

-- Zadanie 4
-- 	Przepisz wszystkie komentarze z tabeli comments do tabeli posts dbając o następujące szczegóły.
-- 	Nie zmieniaj zawartości tabeli comments ani krotek z obecnego stanu tabeli posts.
-- 	Dla każdego przepisywanego komentarza:
-- 	- zadbaj aby jego id było unikalne (a w szczególności różne od id wszystkich dotychczasowych postów) - w tym celu
-- 	  wykorzystaj odpowiednio zdefiniowaną sekwencję, powiąż tę sekwencję z kolumną posts.id,
-- 	- ustaw posttypeid na 3, a parentid na obecny postid,
-- 	- przepisz userid na owneruserid,
-- 	- przepisz text na body,
-- 	- przepisz bez zmian score oraz creationdate.
-- 	Pozostałym atrybutom ustaw wartość NULL.

create sequence new_id;
select setval('new_id', max(id)) from posts;
alter table posts alter column id set default nextval('new_id');
alter sequence new_id owned by posts.id;
insert into posts
(posttypeid, parentid, owneruserid, body, score, creationdate)
select 3, comments.postid, comments.userid, comments.text, comments.score, comments.creationdate from comments;

