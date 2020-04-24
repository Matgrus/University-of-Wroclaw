-- Zadanie 1
-- 	Podaj (uporządkowane alfabetycznie, zapisane z polskimi literami i oddzielone przecinkami - bez spacji)
-- 	nazwiska prowadzących ćwiczenia z Matematyki dyskretnej (M) w semestrze zimowym 2017/2018.

SELECT nazwisko
FROM uzytkownik JOIN grupa USING (kod_uz)
      JOIN przedmiot_semestr USING (kod_przed_sem)
      JOIN semestr USING (semestr_id)
      JOIN przedmiot USING (kod_przed)
WHERE przedmiot.nazwa='Matematyka dyskretna (M)'
      AND rodzaj_zajec='c'
      AND semestr.nazwa='Semestr zimowy 2017/2018';

-- Zadanie 2
-- 	Podaj imię i nazwisko osoby (oddzielone 1 spacją), która jako pierwsza zapisała się na wykład z Matematyki dyskretnej (M) w semestrze zimowym 2017/2018.

SELECT imie,nazwisko,data
FROM uzytkownik JOIN wybor USING (kod_uz)
      JOIN grupa USING (kod_grupy)
      JOIN przedmiot_semestr USING (kod_przed_sem)
      JOIN przedmiot USING (kod_przed)
      JOIN semestr USING (semestr_id)
WHERE przedmiot.nazwa='Matematyka dyskretna (M)'
      AND semestr.nazwa='Semestr zimowy 2017/2018'
      AND rodzaj_zajec='w'
ORDER BY data;

-- Zadanie 3
-- 	Przez ile dni (zaokrągl wynik w górę) studenci zapisywali się na wykład z Matematyki dyskretnej (M) w semestrze zimowym 2017/2018.

select max(data)-min(data) from uzytkownik
join wybor using (kod_uz)
join grupa using (kod_grupy)
join przedmiot_semestr using (kod_przed_sem)
join przedmiot using (kod_przed)
join semestr using (semestr_id) where
przedmiot.nazwa = 'Matematyka dyskretna (M)' and 
rodzaj_zajec = 'w' and
semestr.nazwa = 'Semestr zimowy 2017/2018';

-- Zadanie 4
-- 	Do ilu przedmiotów obowiązkowych jest repetytorium?

SELECT distinct przedmiot.kod_przed, przedmiot.nazwa
FROM przedmiot JOIN przedmiot_semestr USING(kod_przed)
      JOIN grupa USING(kod_przed_sem)
WHERE rodzaj_zajec='e' AND rodzaj='o';

-- Zadanie 5
-- 	Ile osób prowadziło ćwiczenia do przedmiotów obowiązkowych w semestrach zimowych? Do odpowiedzi wliczamy sztucznych użytkowników (o “dziwnych” nazwiskach).

select distinct uzytkownik.kod_uz, imie, nazwisko from uzytkownik join 
grupa using (kod_uz)
join przedmiot_semestr using (kod_przed_sem)
join semestr using (semestr_id)
join przedmiot using (kod_przed)
where semestr.nazwa like '%zimowy%' and przedmiot.rodzaj = 'o';

-- Zadanie 6
-- 	Podaj nazwy wszystkich przedmiotów (w kolejności alfabetycznej, oddzielone przecinkami, a wewnątrz nazw pojedyńczymi spacjami),
-- 	do których zajęcia prowadził użytkownik o nazwisku Urban.

select distinct nazwa from przedmiot 
join przedmiot_semestr using (kod_przed)
join grupa using (kod_przed_sem)
join uzytkownik using (kod_uz)
where nazwisko = 'Urban' order by 1 asc;

-- Zadanie 7
-- 	Ile jest w bazie osób o nazwisku Kabacki z dowolnym numerem na końcu?

SELECT imie, nazwisko
FROM uzytkownik
WHERE nazwisko like 'Kabacki%';

-- Zadanie 8
-- 	Ile osób co najmniej dwukrotnie się zapisało na Algorytmy i struktury danych (M) w różnych semestrach (na dowolne zajęcia)?

SELECT distinct imie, nazwisko, u.kod_uz FROM uzytkownik u
      JOIN wybor w1 USING(kod_uz)
      JOIN grupa g1 USING(kod_grupy)
      JOIN przedmiot_semestr ps1 USING(kod_przed_sem)
      JOIN przedmiot p1 USING (kod_przed)
      JOIN wybor w2 on(u.kod_uz=w2.kod_uz)
      JOIN grupa g2 on(g2.kod_grupy=w2.kod_grupy)
      JOIN przedmiot_semestr ps2
            ON (g2.kod_przed_sem=ps2.kod_przed_sem)
      JOIN przedmiot p2 ON (p2.kod_przed=ps2.kod_przed)
WHERE p2.nazwa=p1.nazwa
      AND p1.nazwa ='Algorytmy i struktury danych (M)'
      AND ps1.kod_przed_sem<>ps2.kod_przed_sem;

-- Zadanie 9
-- 	W którym semestrze (podaj numer) było najmniej przedmiotów obowiązkowych (rozważ tylko semestry, gdy był co najmniej jeden)?

select semestr.semestr_id, count(przedmiot.nazwa) from semestr
join przedmiot_semestr using (semestr_id)
join przedmiot using (kod_przed)
where przedmiot.rodzaj = 'o' group by semestr.semestr_id;

-- Zadanie 10
-- 	Ile grup ćwiczeniowych z Logiki dla informatyków  było w semestrze zimowym  2017/2018?

select przedmiot.nazwa, semestr.nazwa from grupa 
join przedmiot_semestr using (kod_przed_sem)
join przedmiot using (kod_przed)
join semestr using (semestr_id)
where przedmiot.nazwa = 'Logika dla informatyków' and semestr.nazwa = 'Semestr zimowy 2017/2018' and grupa.rodzaj_zajec in ('c', 'C');

-- Zadanie 11
-- 	W którym semestrze (podaj numer) było najwięcej przedmiotów obowiązkowych?

select semestr.semestr_id, count(przedmiot.nazwa) from semestr
join przedmiot_semestr using (semestr_id)
join przedmiot using (kod_przed)
where przedmiot.rodzaj = 'o' group by semestr.semestr_id;

-- Zadanie 12
-- 	Ile przedmiotów ma w nazwie dopisek '(ang.)'?

select count(*) from przedmiot where przedmiot.nazwa like '%(ang.)%';

-- Zadanie 13
-- 	W jakim okresie (od dnia do dnia) studenci zapisywali się na przedmioty w semestrze zimowym 2016/2017? Podaj odpowiedź w formacie rrrr-mm-dd,rrrr-mm-dd.

SELECT DISTINCT CAST(data AS date)
FROM wybor
      JOIN grupa USING (kod_grupy)
      JOIN przedmiot_semestr USING (kod_przed_sem)
WHERE semestr_id=32
ORDER BY 1;

-- Zadanie 14
-- 	Ile przedmiotów typu kurs nie miało edycji w żadnym semestrze (nie występują w tabeli przedmiot_semestr)?

(SELECT kod_przed FROM przedmiot WHERE rodzaj='k')
EXCEPT
(SELECT kod_przed FROM przedmiot_semestr);

-- Zadanie 15
-- 	Ile grup ćwiczenio-pracowni prowadziła P. Kanarek?

select grupa.kod_grupy from grupa
join uzytkownik using (kod_uz)
where rodzaj_zajec in('r', 'R') and nazwisko = 'Kanarek';

-- Zadanie 16
-- 	Ile grup z Logiki dla informatyków prowadził W. Charatonik?

select grupa.kod_grupy from grupa
join uzytkownik using (kod_uz) join przedmiot_semestr using (kod_przed_sem) join przedmiot using (kod_przed)
where nazwa = 'Logika dla informatyków' and nazwisko = 'Charatonik';

-- Zadanie 17
-- 	Ile osób uczęszczało dwa razy na Bazy danych?

SELECT distinct w1.kod_uz
FROM wybor w1, wybor w2,
      grupa g1, grupa g2,
      przedmiot_semestr ps1, przedmiot_semestr ps2
WHERE g1.kod_grupy=w1.kod_grupy
      AND g1.kod_przed_sem=ps1.kod_przed_sem
      AND g2.kod_grupy=w2.kod_grupy
      AND g2.kod_przed_sem=ps2.kod_przed_sem
      AND w1.kod_uz=w2.kod_uz
      AND g1.rodzaj_zajec='w'
      AND g2.rodzaj_zajec='w'
      AND ps1.kod_przed=12
      AND ps2.kod_przed=1
      AND ps1.kod_przed_sem<ps2.kod_przed_sem;

-- Zadanie 18
-- 	Ile osób zapisało sie na jakiś przedmiot w każdym z semestrów zapisanych w bazie?

select semestr.nazwa, count(wybor.kod_uz) from semestr
join przedmiot_semestr using (semestr_id)
join grupa using (kod_przed_sem)
join wybor using (kod_grupy)
group by semestr.nazwa;
