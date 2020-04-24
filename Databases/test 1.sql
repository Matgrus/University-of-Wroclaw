-- Mateusz Gruszecki, MPy
-- Zadanie 1
-- 	Wypisz wszystkie daty utworzenia postów, których treść (body) zawiera słowo Turing.
-- 	Wyniki posortuj wg dat od najnowszych.

select creationdate from posts where body like '%Turing%' order by creationdate desc;

-- Zadanie 2
-- 	Wypisz id oraz title postów, które:
-- 	- zostały napisane po 10 października 2018,
-- 	- w miesiącach od września do grudnia włącznie.
-- 	- ich title nie jest nullem,
-- 	- ich score jest nie niższy niż 9.
-- 	Wyniki posortuj alfabetycznie wg tytułów.

select id, title from posts 
where title is not null and score >= 9 and date(creationdate) > '2018-10-10' 
and date_part('month', creationdate) between 9 and 12 order by title asc;

-- Zadanie 3
-- 	Wypisz displayname oraz reputation użytkowników, którzy są właścicielami posta spełniającego oba poniższe warunki:
-- 	- w treści posta występuje fragment deterministic,
-- 	- do posta napisano komentarz, w którego tekście występuje fragment deterministic.
-- 	Zadbaj, aby wyniki się nie powtarzały oraz były posortowane malejąco wg reputacji.

select distinct displayname, reputation from users 
join posts on (owneruserid = users.id) 
join comments on (comments.postid = posts.id) 
where body like '%deterministic%' and comments.text like '%deterministic%' order by reputation desc;

-- Zadanie 4
-- 	Wypisz displayname osób, które nigdy nie napisały żadnego komentarza ale napisały jakiś post. 
-- 	Zadbaj, aby wyniki się nie powtarzały oraz były posortowane alfabetycznie.
-- 	Wypisz tylko pierwsze 10 krotek.

(select distinct displayname from users join posts on (posts.owneruserid = users.id))
except
(select distinct displayname from users join comments on (comments.userid = users.id)) 
order by displayname asc limit 10;
