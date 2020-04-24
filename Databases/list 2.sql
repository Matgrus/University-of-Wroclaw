-- Zadanie 1
-- 	Wykonaj następujące operacje zmiany schematu i zawartości tabeli semestr:
-- 	- Zdefiniuj dziedzinę semestry z dwiema wartościami: 'zimowy' i 'letni' oraz niedopuszczalną wartością pustą. 
-- 	- Zdefiniuj sekwencję numer_semestru i nadaj jej wartość równą pierwszej nieużywanej liczbie w kolumnie semestr_id.
-- 	- Do tabeli semestr dodaj dwa nowe atrybuty:
-- 	  - semestr – kolumnę typu semestry;
-- 	  - rok – kolumnę typu tekstowego opisującą rok akademicki w formacie: '2016/2017';
-- 	- Wypełnij kolumny semestr i rok rozbijając nazwę każdego semestru na typ semestru i rok akademicki (sprawdź w dokumentacji PostgreSQL, jakie funkcje tekstowe są dostępne).
-- 	- Usuń z tabeli semestr kolumnę nazwa.
-- 	- Dodaj do kolumn semestr i rok wartości domyślne, które dla bieżącej daty od stycznia do czerwca (włącznie) ustawiają domyślny semestr letni
-- 	  i rok (x-1)/x; a dla  daty od lipca do grudnia (włącznie) - semestr zimowy i rok x/(x+1) (sprawdź w dokumentacji PostgreSQL dostępne funkcje daty i czasu).

CREATE DOMAIN semestry AS text
CHECK (VALUE IN ('zimowy','letni')) NOT NULL;

CREATE SEQUENCE numer_semestru;
SELECT setval('numer_semestru',max(semestr_id)) FROM semestr;
ALTER TABLE semestr ALTER COLUMN semestr_id
   SET DEFAULT nextval('numer_semestru');
ALTER SEQUENCE numer_semestru OWNED BY semestr.semestr_id;

ALTER TABLE semestr ADD COLUMN semestr semestry DEFAULT 'zimowy';
ALTER TABLE semestr ADD COLUMN rok char(9);

UPDATE semestr SET semestr='letni' WHERE nazwa LIKE '%letni%';
UPDATE semestr SET rok = substring(nazwa FROM position('/' IN nazwa)-4 FOR 9);

ALTER TABLE semestr DROP COLUMN nazwa;

ALTER TABLE semestr ALTER COLUMN semestr DROP DEFAULT;
ALTER TABLE semestr ALTER COLUMN semestr SET DEFAULT
 CASE WHEN extract(month FROM current_date) BETWEEN 1 AND 6
   THEN 'letni' ELSE 'zimowy'
 END;
ALTER TABLE semestr ALTER COLUMN rok SET DEFAULT
 CASE WHEN extract(month FROM current_date) BETWEEN 1 AND 6
   THEN extract(year FROM current_date)-1||'/'||extract(year FROM current_date)
   ELSE extract(year FROM current_date)||'/'||extract(year FROM current_date)+1
 END;

-- Zadanie 2
-- 	Dodaj nowy semestr letni i zimowy na rok akademicki 2018/2019:
-- 	- Zdefiniuj sekwencje numer_przedmiot_semestr i numer_grupy nadając im odpowiednio maksymalny numer kod_przed_sem i kod_grupy.
-- 	- Utwórz w zdefiniowanych semestrach edycje wszystkich przedmiotów typu obowiązkowego i podstawowego, które odbyły się w roku akademickim 2016/2017.
-- 	  Tworząc edycje używaj sekwencji, by nadać im unikalny kod.
-- 	- Dla każdego przedmiotu w semestrze zdefiniuj grupę wykładową, bez terminu, bez prowadzącego i bez sali z limitem (max_osoby) równym 100.
-- 	  Jeśli w zdefiniowaniu grupy przeszkadzają Ci jakieś więzy tabeli, to je usuń. Dodając grupy używaj sekwencji numer_grupy.
-- 	- Sprawdź, czy udało Ci się zdefiniować wymagane grupy, czyli zadaj zapytanie wyszukujące je.

INSERT INTO semestr(semestr,rok) VALUES
   ('zimowy','2018/2019'),
   ('letni','2018/2019');
CREATE SEQUENCE numer_przedmiot_semestr;
SELECT setval('numer_przedmiot_semestr',max(kod_przed_sem)) FROM przedmiot_semestr;
ALTER TABLE przedmiot_semestr
   ALTER COLUMN kod_przed_sem
   SET DEFAULT nextval('numer_przedmiot_semestr');
ALTER SEQUENCE numer_przedmiot_semestr
   OWNED BY przedmiot_semestr.kod_przed_sem;
CREATE SEQUENCE numer_grupy;
SELECT setval('numer_grupy',max(kod_grupy)) FROM grupa;
ALTER TABLE grupa
   ALTER COLUMN kod_grupy
   SET DEFAULT nextval('numer_grupy');
ALTER SEQUENCE numer_grupy OWNED BY grupa.kod_grupy;

INSERT INTO przedmiot_semestr    
   (semestr_id,kod_przed,strona_domowa, angielski)
   SELECT s1.semestr_id, p.kod_przed, strona_domowa, angielski
  FROM semestr s1,
        przedmiot p JOIN
        przedmiot_semestr ps USING(kod_przed) JOIN
        semestr s USING(semestr_id)
   WHERE rodzaj IN ('p', 'o') AND
         s.rok='2016/2017' AND
         s.semestr=s1.semestr AND
         s1.rok='2018/2019';

INSERT INTO grupa(kod_przed_sem,max_osoby,rodzaj_zajec)
   SELECT kod_przed_sem,100,'w'
   FROM przedmiot_semestr JOIN semestr USING(semestr_id)
   WHERE rok='2018/2019';
ALTER TABLE grupa ALTER COLUMN kod_uz DROP NOT NULL;
INSERT INTO grupa(kod_przed_sem,max_osoby,rodzaj_zajec)
   SELECT kod_przed_sem,100,'w'
   FROM przedmiot_semestr JOIN semestr USING(semestr_id)
   WHERE rok='2018/2019';

SELECT kod_grupy, nazwa, rodzaj_zajec, max_osoby
FROM grupa JOIN
     przedmiot_semestr USING(kod_przed_sem) JOIN
     przedmiot USING(kod_przed) JOIN
     semestr USING(semestr_id)
WHERE rok='2018/2019';

-- Zadanie 3
-- 	- Załóż tabele: pracownik oraz student. Dla każdej tabeli zdefiniuj właściwe dla niej pola występujące w tabeli uzytkownik.
-- 	- Wpisz do tabeli pracownik wszystkie osoby, które kiedykolwiek prowadziły zajęcia.
-- 	- Wpisz do tabeli student osoby, które kiedykolwiek uczęszczały na zajęcia.
-- 	- Przekieruj klucze obce wskazujące na tabelę uzytkownik tak, by wskazywały teraz odpowiednio na tabele pracownik i student. Usuń tabelę uzytkownik.

CREATE TABLE pracownik (LIKE uzytkownik);
ALTER TABLE pracownik DROP COLUMN semestr;
ALTER TABLE pracownik ADD CONSTRAINT pk_pracownik
   PRIMARY KEY(kod_uz);
CREATE TABLE student (LIKE uzytkownik);
ALTER TABLE student ADD CONSTRAINT pk_student
   PRIMARY KEY(kod_uz);

INSERT INTO pracownik(kod_uz, imie, nazwisko)
SELECT kod_uz, imie, nazwisko FROM uzytkownik
WHERE kod_uz IN (SELECT kod_uz FROM grupa);

INSERT INTO student(kod_uz, imie, nazwisko,semestr)
SELECT kod_uz, imie, nazwisko, semestr FROM uzytkownik
WHERE kod_uz IN (SELECT kod_uz FROM wybor);

ALTER TABLE wybor DROP CONSTRAINT fk_wybor_uz;
ALTER TABLE wybor ADD CONSTRAINT fk_wybor_st
   FOREIGN KEY (kod_uz) REFERENCES student(kod_uz) DEFERRABLE;
ALTER TABLE grupa DROP CONSTRAINT fk_grupa_uz;
ALTER TABLE grupa ADD CONSTRAINT fk_grupa_pr
   FOREIGN KEY (kod_uz)
   REFERENCES pracownik(kod_uz)
   DEFERRABLE;
DROP TABLE uzytkownik;

-- Zadanie 4
-- 	Podaj kody, imiona i nazwiska osób, które prowadziły jakiś wykład, ale nigdy  nie prowadziły żadnego seminarium (nie patrzymy, czy zajęcia były w tym samym  semestrze).
-- 	Zapisz powyższe zapytanie używając różnicy zbiorów. Czy potrafisz do tego celu użyć złączenia zewnętrznego?
-- 	Uwaga: W tym zapytaniu nie trzeba usuwać powtórzeń z wyniku, bo operacje teoriomnogościowe (UNION, EXCEPT i INTERSECT) automatycznie je usuwają.
-- 	W zapytaniu warto pamiętać o ujęciu odejmowanych relacji w nawiasy, choć nie zawsze jest to konieczne.
-- 	Uchroni nas o przed "nieprzewidywalną" kolejnością wykonywania ciągu operacji UNION/EXCEPT/INTERSECT/JOIN – system wykonuje łańcuch takich operacji
-- 	od lewej do prawej (jeśli nie ma nawiasów), co nie zawsze jest zgodne z intuicją, która podpowiada, że złączenia mogłyby mieć większy priorytet niż dodawanie/odejmowanie zbiorów.

( SELECT uzytkownik.kod_uz, imie,nazwisko
FROM grupa JOIN uzytkownik USING(kod_uz)
WHERE rodzaj_zajec='w' )
EXCEPT
( SELECT uzytkownik.kod_uz, imie,nazwisko
FROM grupa JOIN uzytkownik USING(kod_uz)
WHERE rodzaj_zajec='s' );

-- Zadanie 5
-- 	Dla każdego przedmiotu typu kurs z bazy danych podaj jego nazwę oraz liczbę osób, które na niego uczęszczały.
-- 	Uwzględnij w odpowiedzi kursy, na które nikt  nie uczęszczał – w tym celu użyj złączenia zewnętrznego (LEFT JOIN lub RIGHT JOIN).

SELECT przedmiot.nazwa, COUNT(DISTINCT wybor.kod_uz) FROM
przedmiot
 LEFT JOIN przedmiot_semestr USING(kod_przed)
 LEFT JOIN grupa USING(kod_przed_sem)
 LEFT JOIN wybor USING(kod_grupy)
WHERE rodzaj='k'
GROUP BY przedmiot.kod_przed, przedmiot.nazwa;

-- Zadanie 6
-- 	Podaj kody, imiona i nazwiska wszystkich prowadzących, którzy w jakiejś prowadzonej przez siebie grupie mieli więcej zapisanych osób, niż wynosił limit max_osoby dla tej grupy.
-- 	Do zapisania zapytania użyj GROUP BY i HAVING.

SELECT DISTINCT uzytkownik.kod_uz,imie,nazwisko FROM
 wybor JOIN grupa USING(kod_grupy)
 JOIN uzytkownik ON (uzytkownik.kod_uz=grupa.kod_uz)
GROUP BY grupa.kod_grupy,
 uzytkownik.kod_uz, imie, nazwisko, max_osoby
HAVING max_osoby < COUNT(*);
