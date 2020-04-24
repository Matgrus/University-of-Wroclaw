-- Zadanie 1
-- 	Podaj kody, imiona i nazwiska wszystkich osób, które chodziły na dowolne zajęcia z Algorytmów i struktur danych,
-- 	a w jakimś semestrze późniejszym (o większym  numerze) chodziły na zajęcia z Matematyki dyskretnej.
-- 	Za AiSD oraz MD uznaj  wszystkie przedmioty, których nazwa zaczyna się od podanych nazw. Zapisz to  zapytanie używając operatora IN z podzapytaniem.

select distinct student.kod_uz, imie, nazwisko from student
join wybor using (kod_uz)
join grupa using (kod_grupy)
join przedmiot_semestr using (kod_przed_sem)
join przedmiot using (kod_przed)
where nazwa like 'Algorytmy i struktury danych%' and student.kod_uz in
(select wybor.kod_uz from wybor join grupa using (kod_grupy) join przedmiot_semestr ps2 using (kod_przed_sem) join przedmiot using (kod_przed)
where nazwa like 'Matematyka dyskretna%' and ps2.semestr_id > przedmiot_semestr.semestr_id);

-- Zadanie 2
-- 	Podaj nazwę przedmiotu podstawowego, na wykład do którego chodziło najwięcej różnych osób.
-- 	Użyj w tym celu zapytania z GROUP BY i HAVING (z warunkiem używającym ponownie GROUP BY).

SELECT przedmiot.nazwa FROM przedmiot
 JOIN przedmiot_semestr USING(kod_przed)
 JOIN grupa USING(kod_przed_sem)
 JOIN wybor USING(kod_grupy)
WHERE rodzaj='p' AND rodzaj_zajec='w'
GROUP BY przedmiot.nazwa, przedmiot.kod_przed
HAVING COUNT(DISTINCT wybor.kod_uz) >=
 ALL
 (SELECT COUNT(DISTINCT wybor.kod_uz)
 FROM przedmiot
 JOIN przedmiot_semestr USING(kod_przed)
 JOIN grupa USING(kod_przed_sem)
 JOIN wybor USING(kod_grupy)
 WHERE rodzaj='p' AND rodzaj_zajec='w'
 GROUP BY przedmiot.kod_przed);

-- Zadanie 3
-- 	Dla każdego semestru letniego podaj jego numer oraz nazwisko osoby, która jako pierwsza zapisała się na zajęcia w tym semestrze.
-- 	Jeśli w semestrze było kilka osób, które zapisały się jednocześnie: podaj wszystkie podaj tę o najwcześniejszym leksykograficznie nazwisku.

SELECT distinct POM.semestr_id,nazwisko FROM
(SELECT semestr.semestr_id AS "semestr_id",
 MIN(data) AS "data"
 FROM semestr
 JOIN przedmiot_semestr USING(semestr_id)
 JOIN grupa USING(kod_przed_sem)
 JOIN wybor USING(kod_grupy)
 WHERE semestr.semestr = 'letni'
 GROUP BY semestr.semestr_id) POM 
 JOIN wybor USING(data)
 JOIN grupa USING(kod_grupy)
 JOIN przedmiot_semestr USING(kod_przed_sem,semestr_id)
 JOIN student ON wybor.kod_uz=student.kod_uz
 ORDER BY 1,2; 

-- Zadanie 4
-- 	Jaka jest średnia liczba osób zapisujących się na wykład w semestrze letnim 2016/2017?
-- 	Zapisz to zapytanie definiując najpierw pomocniczą relację (np. na liście from z aliasem),
-- 	w której dla każdego interesującego cię wykładu znajdziesz liczbę zapisanych na niego osób).

SELECT AVG(liczba) FROM (select grupa.kod_grupy, count(wybor.kod_uz) as liczba from grupa
join wybor using (kod_grupy)
join przedmiot_semestr using (kod_przed_sem)
join semestr using (semestr_id)
where rodzaj_zajec = 'w' and semestr.semestr = 'letni' and rok = '2016/2017' group by grupa.kod_grupy) tabela;

-- Zadanie 5
-- 	Kto prowadzi w jednym semestrze wykład do przedmiotu i co najmniej dwie grupy innych zajęć do tego przedmiotu (nie muszą być tego samego typu)?

SELECT DISTINCT p.kod_uz, imie, nazwisko FROM pracownik p
 JOIN grupa g1 USING(kod_uz)
 JOIN grupa g2 USING(kod_uz)
 JOIN grupa g3 USING(kod_uz)
WHERE g1.rodzaj_zajec='w'
 AND g1.kod_przed_sem = g2.kod_przed_sem
 AND g1.kod_przed_sem = g3.kod_przed_sem
 AND g2.rodzaj_zajec <>'w'
 AND g3.rodzaj_zajec <>'w'
 AND g3.kod_grupy <> g2.kod_grupy;

-- Zadanie 6
-- 	Podaj kody użytkowników, którzy uczęszczali w semestrze letnim 2016/2017 na wykład z 'Baz danych' i nie uczęszczali na wykład z 'Sieci komputerowych', i odwrotnie.
-- 	Sformułuj to zapytanie używając instrukcji WITH, by wstępnie  zdefiniować zbiory osób uczęszczających na każdy z wykładów.

WITH BD AS
( SELECT wybor.kod_uz FROM wybor JOIN grupa USING(kod_grupy)
 JOIN przedmiot_semestr USING(kod_przed_sem)
 JOIN przedmiot USING(kod_przed) 
 JOIN semestr USING(semestr_id)
 WHERE przedmiot.nazwa='Bazy danych' AND rodzaj_zajec='w' AND
 semestr.semestr = 'letni' and semestr.rok = '2016/2017'),
SK AS
( SELECT wybor.kod_uz FROM wybor JOIN grupa USING(kod_grupy)
 JOIN przedmiot_semestr USING(kod_przed_sem)
 JOIN przedmiot USING(kod_przed) 
 JOIN semestr USING(semestr_id)
WHERE przedmiot.nazwa='Sieci komputerowe' AND rodzaj_zajec='w'
AND semestr.semestr = 'letni' and semestr.rok = '2016/2017' )
((SELECT * FROM BD) EXCEPT (SELECT * FROM SK)) UNION
((SELECT * FROM SK) EXCEPT (SELECT * FROM BD));

-- Zadanie 7
-- 	- Zdefiniuj dziedzinę rodzaje_zajec tak, by nie dopuszczała wartości pustych i obejmowała wszystkie występujące w tej chwili rodzaje zajęć w wersji małej i dużej (litery).
-- 	- Zmień tabelę grupa tak, by używała zdefiniowanej dziedziny zamiast typu char(1) w kolumnie rodzaj_zajec.
-- 	- Zdefiniuj perspektywę obsada_zajec_view o polach: prac_kod, prac_nazwisko, przed_kod, przed_nazwa, rodzaj_zajec, liczba_grup, liczba_studentow.
-- 	  Pola prac_kod i prac_nazwa mają oznaczać prowadzącego zajęcia, a pola przed_kod i przed_nazwa - oczywiście przedmiot.
-- 	  Pole rodzaj_zajec ma być typu rodzaje_zajec. W polach liczba_grup i liczba_studentow mają być liczby (odpowiednio) grup i osób (z powtórzeniami),
-- 	  które uczęszczały na zajęcia danego typu do danego przedmiotu do danej osoby.
-- 	- Zdefiniuj tabelę obsada_zajec_tab o schemacie analogicznym, jak powyższa perspektywa. Wypełnij ją danymi.
-- 	- Korzystając z perspektywy znajdź dla każdego przedmiotu obowiązkowego i podstawowego osobę, która uczyła najwięcej osób tego przedmiotu.
-- 	  Następnie zrób to samo korzystając z tabeli i sprawdź czy występuje widoczna różnica w czasie wykonania.

CREATE DOMAIN rodzaje_zajec AS char(1) NOT NULL
CHECK (VALUE IN ('w','s','r','p','P','e','c','C','l','g'));

ALTER TABLE grupa ALTER COLUMN rodzaj_zajec
   TYPE rodzaje_zajec;

CREATE VIEW obsada_zajec_view
  (prac_kod, prac_nazwisko, przed_kod, przed_nazwa,
   rodzaj_zajec, liczba_grup, liczba_studentow)
AS
SELECT
   pr.kod_uz, nazwisko, p.kod_przed, p.nazwa, rodzaj_zajec,
   COUNT(DISTINCT kod_grupy), COUNT(w.kod_uz)
FROM pracownik pr JOIN
     grupa USING(kod_uz) JOIN
     wybor w USING(kod_grupy) JOIN
     przedmiot_semestr USING(kod_przed_sem) JOIN
     przedmiot p USING(kod_przed)
GROUP BY
     pr.kod_uz, nazwisko, p.kod_przed, nazwa, rodzaj_zajec;

CREATE TABLE obsada_zajec_tab(
   prac_kod int,
   prac_nazwisko text,
   przed_kod int,
   przed_nazwa text,
   rodzaj_zajec rodzaje_zajec,
   liczba_grup bigint,
   liczba_studentow bigint);
INSERT INTO obsada_zajec_tab
  SELECT
      pr.kod_uz, nazwisko, p.kod_przed, p.nazwa, rodzaj_zajec,
      count(DISTINCT kod_grupy), count(w.kod_uz)
  FROM pracownik pr JOIN
      grupa USING(kod_uz) JOIN
      wybor w USING(kod_grupy) JOIN
      przedmiot_semestr USING(kod_przed_sem) JOIN
      przedmiot p USING(kod_przed)
  GROUP BY
      pr.kod_uz, nazwisko, p.kod_przed, nazwa, rodzaj_zajec;

EXPLAIN ANALYZE SELECT prac_nazwisko, przed_nazwa
FROM obsada_zajec_view o JOIN przedmiot ON (kod_przed=przed_kod)
WHERE rodzaj IN ('o','p')
GROUP BY prac_kod,o.przed_kod, o.prac_nazwisko, przed_nazwa
HAVING sum(liczba_studentow)>=
 ALL(SELECT sum(liczba_studentow)
     FROM obsada_zajec_view o1 JOIN przedmiot ON (przed_kod=kod_przed)
     WHERE o1.przed_kod=o.przed_kod
     GROUP BY prac_kod);

EXPLAIN ANALYZE SELECT prac_nazwisko, przed_nazwa
FROM obsada_zajec_tab o JOIN przedmiot ON (kod_przed=przed_kod)
WHERE rodzaj IN ('o','p')
GROUP BY prac_kod,o.przed_kod, o.prac_nazwisko, przed_nazwa
HAVING sum(liczba_studentow)>=
 ALL(SELECT sum(liczba_studentow)
     FROM obsada_zajec_tab o1 JOIN przedmiot ON (przed_kod=kod_przed)
     WHERE o1.przed_kod=o.przed_kod
     GROUP BY prac_kod);

-- Zadanie 8
-- 	W tym zadaniu bazę danych uzupełnimy o dane o praktykach zawodowych.
-- 	- Załóż tabelę firma o atrybutach (pamiętaj o kluczach i ograniczeniach  NULL/NOT NULL):
-- 	  - kod_firmy - unikalny kod generowany przez sekwencję;
-- 	  - nazwa - pole niepuste,
-- 	  - adres - pole niepuste,
-- 	  - kontakt - pole niepuste.
-- 	- Wpisz krotki: (SNS, Wrocław, H.Kloss); (BIT, Kraków, R.Bruner); (MIT, Berlin, J.Kos);
-- 	- Załóż tabelę oferta_praktyki o atrybutach:
-- 	  - kod_oferty - automatycznie generowany unikalny klucz tablicy firma,
-- 	  - kod_firmy - klucz obcy do tablicy firmy;
-- 	  - semestr_id - klucz obcy do tablicy semestr;
-- 	  - liczba_miejsc - liczba dodatnia;
-- 	- Wpisz na semestr letni 2018/19 oferty: SNS (3 miejsca) i MIT (2 miejsca);
-- 	- Załóż tabelę praktyki o atrybutach:
-- 	  - student - kod studenta,
-- 	  - opiekun - kod pracownika i klucz obcy do tabeli pracownik,
-- 	  - oferta - kod oferty i klucz obcy do tabeli oferta_praktyki.
-- 	- (*) Wypełnij wszystkie wolne miejsca na praktykach studentami z semestru pomiędzy 6 i 10, którzy jeszcze nie zaliczyli praktyki.
-- 	- Sprawdź, ilu studentów z semestru od 6 do 10 nie zaliczyło jeszcze praktyki oraz, ile pozostało wolnych ofert praktyki na bieżący (największy) semestr w bazie.
-- 	- Usuń z bazy danych wszystkie oferty, do których nie została stworzona ani jedna praktyka i wszystkie firmy, których żadna oferta nie została wykorzystana.

CREATE TABLE firma
(kod_firmy SERIAL PRIMARY KEY,
nazwa text NOT NULL,
adres text NOT NULL,
kontakt text NOT NULL);

INSERT INTO firma(nazwa,adres,kontakt) VALUES
('SNS','Wrocław','H.Kloss'),
('BIT','Kraków','R.Bruner'),
('MIT','Berlin','J.Kos');

CREATE TABLE oferta_praktyki
( kod_oferty SERIAL PRIMARY KEY,
 kod_firmy int NOT NULL REFERENCES firma(kod_firmy),
 semestr_id int REFERENCES semestr(semestr_id),
 liczba_miejsc int);

INSERT INTO oferta_praktyki(kod_firmy,semestr_id,liczba_miejsc)
  SELECT kod_firmy,semestr_id,3
   FROM firma,semestr
   WHERE firma.nazwa='SNS' AND rok='2018/2019'
         AND semestr='letni';
INSERT INTO oferta_praktyki(kod_firmy,semestr_id,liczba_miejsc)
  SELECT kod_firmy,semestr_id,2
   FROM firma,semestr
   WHERE firma.nazwa='MIT' AND rok='2018/2019'
         AND semestr='letni';

CREATE TABLE praktyki
(student int NOT NULL REFERENCES student,
opiekun int REFERENCES pracownik,
oferta int NOT NULL REFERENCES oferta_praktyki);

BEGIN TRANSACTION;
INSERT INTO praktyki(student,oferta)
SELECT kod_uz,kod_oferty
FROM student s,oferta_praktyki o
WHERE kod_uz =
 (SELECT MAX(kod_uz) FROM student WHERE
  semestr BETWEEN 6 AND 10 AND kod_uz NOT IN
  (SELECT student FROM praktyki))
 AND
 kod_oferty =
 (SELECT MAX(kod_oferty) FROM oferta_praktyki
  WHERE liczba_miejsc > 0 AND semestr_id =
        (SELECT MAX(semestr_id) FROM semestr));

UPDATE oferta_praktyki SET liczba_miejsc = liczba_miejsc - 1
WHERE kod_oferty =
   (SELECT MAX(kod_oferty) FROM oferta_praktyki
   WHERE liczba_miejsc > 0 AND semestr_id =
      (SELECT MAX(semestr_id) FROM semestr));
COMMIT;

SELECT COUNT(*) FROM student
WHERE semestr BETWEEN 6 AND 10
     AND kod_uz NOT IN
     (SELECT student FROM praktyki);
SELECT SUM(liczba_miejsc)
FROM oferta_praktyki
WHERE semestr_id =
     (SELECT MAX(semestr_id) FROM semestr);

DELETE FROM oferta_praktyki
WHERE kod_oferty NOT IN
 (SELECT oferta FROM praktyki);
DELETE FROM firma
WHERE kod_firmy NOT IN
  (SELECT kod_firmy FROM oferta_praktyki);

-- Zadanie 9
-- 	- Zdefiniuj perspektywę plan_zajec, która pokaże dla każdej osoby, semestru i przedmiotu termin, w jaki osoba powinna uczęszczać na zajęcia z tego przedmiotu
-- 	  (także do jakiej sali i kto prowadzi zajęcia).
-- 	- Wykorzystaj perspektywę plan_zajec, by pokazać plan zajęć konkretnego studenta (wybierz dowolnie wg kodu) w konkretnym semestrze.
-- 	- Wykorzystaj perspektywę plan_zajec, by pokazać plan zajęć konkretnego pracownika (wybierz dowolnie wg kodu) w konkretnym semestrze.
-- 	- Wykorzystaj perspektywę plan_zajec, by pokazać plan w konkretnej sali w konkretnym semestrze.

CREATE VIEW plan_zajec(
 kod_stud,nazwisko_stud,
 semestr_id,rok,semestr,
 kod_przed, nazwa_przed,
 termin, sala, kod_prac, nazwisko_prac) AS
SELECT
 u1.kod_uz,u1.nazwisko,
 s.semestr_id,rok,s.semestr,
 p.kod_przed,p.nazwa,
 termin,sala,u2.kod_uz, u2.nazwisko
FROM student u1 JOIN wybor USING(kod_uz)
    JOIN grupa USING(kod_grupy)
    JOIN pracownik u2 ON (grupa.kod_uz=u2.kod_uz)
    JOIN przedmiot_semestr USING(kod_przed_sem)
    JOIN przedmiot p USING(kod_przed)
    JOIN semestr s USING(semestr_id);

SELECT
   nazwisko_stud,
   rok,
   semestr,
   nazwa_przed,
   termin,
   sala,
   nazwisko_prac
FROM plan_zajec
WHERE kod_stud = 3830 AND semestr_id = 39;

SELECT DISTINCT
   nazwisko_prac,rok,semestr,nazwa_przed,termin,sala
FROM plan_zajec
WHERE kod_prac = 187 AND semestr_id = 39;

SELECT DISTINCT nazwa_przed, termin, nazwisko_prac
FROM plan_zajec
WHERE semestr_id = 39 AND sala = '25';

