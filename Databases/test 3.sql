-- Mateusz Gruszecki, mpy
-- Zadanie 1
-- 	Uznajemy, że dany post A jest wyczerpującą odpowiedzią na inny post B, jeśli B.AcceptedAnswerID=A.id.
-- 	Utwórz ranking użytkowników, którzy wyczerpująco odpowiedzieli na najwięcej pytań.
-- 	W tym celu zdefiniuj perspektywę ranking z polami: displayname, liczba_odpowiedzi taką,
-- 	że użytkownik z danym displayname udzielił liczba_odpowiedzi wyczerpujących odpowiedzi.
-- 	Perspektywa powinna być posortowana według liczba_odpowiedzi malejąco, a w drugiej kolejności wg displayname alfabetycznie.

create view ranking (displayname, liczba_odpowiedzi) as
select users.displayname, count(p1.acceptedanswerid) as liczba from posts p1 
join posts p2 on (p1.acceptedanswerid = p2.id) 
join users on (p2.owneruserid = users.id) 
group by users.displayname order by liczba desc, displayname asc;

-- Zadanie 2
-- 	Wyświetl id, displayname i reputation użytkowników, którzy:
-- 	- nie dostali nigdy odznaki Enlightened
-- 	- ale mają więcej upvotes niż średnia liczba upvotes użytkowników z tą odznaką (uwaga: weź pod uwagę, że jeden użytkownik może dostać jedną odznakę wielokrotnie)
-- 	- oraz napisali więcej niż jeden komentarz pod postami stworzonymi w 2020 r.
-- 	Wynik uporządkuj rosnąco względem daty założenia konta użytkownika.

with b1 as
((select users.id, users.displayname, users.reputation from users)
 except 
(select users.id, users.displayname, users.reputation from users 
join badges on (userid = users.id) 
where name = 'Enlightened')),
b2 as
(select users.id, users.displayname, users.reputation from users 
join comments on (userid = users.id) 
join posts on (comments.postid = posts.id) 
where extract(year from posts.creationdate) = 2020 
group by users.id, users.displayname, users.reputation having count(comments.id) > 1),
srednia as
(select avg(upvotes) from 
(select distinct users.id, users.displayname, users.reputation, users.upvotes from users 
join badges on (userid = users.id) 
where name = 'Enlightened') pom)
(select users.id, users.displayname, users.reputation from users 
where users.upvotes > (select * from srednia) 
and users.id in ((select id from b1) intersect (select id from b2)) 
order by users.creationdate);

-- Zadanie 3
-- 	Znajdź użytkowników (id, displayname), którzy mają pośredni kontakt z rekurencją.
-- 	Mówimy, że użytkownik ma pośredni kontakt z rekurencją, jeśli:
-- 	- w body któregoś posta użył słowa recurrence lub
-- 	- napisał komentarz do posta osoby, która ma pośredni kontakt z rekurencją.

with recursive res(id, displayname) as (
(select distinct users.id, users.displayname from users join posts on (posts.owneruserid = users.id) where posts.body like '%recurrence%')
union
(select users.id, users.displayname from res join posts on (posts.owneruserid = res.id) join comments on (comments.postid = posts.id) join users on (users.id = comments.userid)))
select * from res;
