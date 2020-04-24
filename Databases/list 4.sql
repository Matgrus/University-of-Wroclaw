-- Zadanie 1
-- 	Napisz funkcję SQL pierwszy_zapis(int,int), która dla zadanych jako argumenty kodu użytkownika oraz numeru semestru, poda czas najwcześniejszego
-- 	zapisu na zajęcia tego użytkownika w tym semestrze.
-- 	Wykorzystaj funkcję pierwszy_zapis, by podać nazwiska wszystkich osób o nazwisku na ‘A’, które zapisały się na jakieś
-- 	zajęcia w ‘’Semestrze zimowym 2016/2017’’ wraz z czasem ich pierwszego zapisu w tym semestrze. Posortuj wynik rosnąco według czasu i usuń z niego powtórzenia, jeśli to potrzebne.

CREATE FUNCTION pierwszy_zapis(int,int)
     RETURNS wybor.data%TYPE 
AS $X$
    SELECT min(data)
    FROM wybor
         JOIN grupa USING(kod_grupy)
         JOIN przedmiot_semestr USING(kod_przed_sem)
    WHERE wybor.kod_uz=$1 AND semestr_id=$2;
$X$ LANGUAGE SQL STABLE;

SELECT DISTINCT
u.nazwisko,pierwszy_zapis(u.kod_uz,s.semestr_id)
FROM uzytkownik u JOIN wybor w USING(kod_uz)
    JOIN grupa g USING(kod_grupy)
    JOIN przedmiot_semestr ps USING(kod_przed_sem)
    JOIN semestr s USING(semestr_id)
WHERE s.nazwa='Semestr zimowy 2016/2017’ AND
      u.nazwisko LIKE ’A%’
ORDER BY 2;

-- Zadanie 2
-- 	Napisz funkcję plan_zajec_prac(int,int) - pierwszy argument to kod pracownika, a drugi, to kod semestru.
-- 	Funkcja ma zwracać wszystkie zajęcia danego pracownika w danym semestrze wraz z nazwą przedmiotu, rodzajem zajęć, terminem, salą i liczbą osób zapisanych na zajęcia.
-- 	Zobacz plan zajęć użytkownika 187 w semestrze 39.

CREATE TYPE plan_zajec_typ AS 
(nazwa text,
 rodzaj_zajec char,
 termin text,
 sala text,
 liczba_osob int);

CREATE OR REPLACE FUNCTION plan_zajec(int,int) RETURNS SETOF plan_zajec_typ AS
$X$
 SELECT 
       p.nazwa::text, g.rodzaj_zajec::char,
       g.termin::text, g.sala::text, COUNT(*)::int
 FROM przedmiot p JOIN
       przedmiot_semestr PS USING(kod_przed) JOIN
       grupa g USING(kod_przed_sem) JOIN
       semestr s USING(semestr_id)
 WHERE g.kod_uz=$1 AND s.semestr_id=$2
 GROUP BY p.nazwa, g.rodzaj_zajec, g.termin, g.sala;
$X$ LANGUAGE SQL;

SELECT plan_zajec(187,39);

-- Zadanie 3
-- 	Na liście SQL3 w zadaniu 8 tworzyliśmy tabele, które pozwalały zapisywać studentów na praktyki.
-- 	Napisz funkcję przydziel_praktyki() (bez argumentów i niezwracającą wartości), która wykona zadanie 8.6 z poprzedniej listy, czyli wypełni wszystkie
-- 	wolne miejsca na praktykach studentami, którzy jeszcze nie zaliczyli praktyki i są na semestrze między 6 a 10.

CREATE OR REPLACE FUNCTION przydziel_praktyki() RETURNS VOID
AS $X$
DECLARE osoba student;
       ofertap int;
BEGIN
  FOR osoba IN
      SELECT *
      FROM student
      WHERE kod_uz NOT IN
           (SELECT student FROM praktyki)
            AND semestr BETWEEN 6 AND 10
 LOOP
    SELECT max(kod_oferty) INTO ofertap
    FROM oferta_praktyki
   WHERE liczba_miejsc>0;
    IF (ofertap IS NULL) THEN EXIT; END IF;
    UPDATE oferta_praktyki
    SET liczba_miejsc=liczba_miejsc-1
   WHERE kod_oferty=ofertap;
    INSERT INTO praktyki(student,oferta)
    VALUES(osoba.kod_uz,ofertap);
 END LOOP;
END
$X$ LANGUAGE plpgsql;

-- Zadanie 4
-- 	Napisz wyzwalacze, które będą pilnowały, by student zapisując się na zajęcia pomocnicze został także zapisany na wykład do przedmiotu.
-- 	- Przy zapisie studenta na zajęcia typu innego niż 'w', należy zapisać go także do grupy z rodzajem zajęć 'w' do tego samego przedmiotu,
-- 	  w tym samym semestrze (do wszystkich grup, jeśli jest ich więcej). Zwróć uwagę, by nie zapisać studenta na wykład, jeśli jest już na niego zapisany.
-- 	- Napisz też wyzwalacz dla sytuacji, gdy powstaje nowa grupa wykładowa, a być może wcześniej zostały otwarte grupy z innymi rodzajami zajęć do danego przedmiotu
-- 	  w danym semestrze - zapisz wszystkich na wykład.

CREATE OR REPLACE FUNCTION zapisz_tez_na_wyklad() RETURNS TRIGGER AS
$X$
   DECLARE 
      rz char;
      kps int;
      gw int;
   BEGIN
      SELECT rodzaj_zajec, kod_przed_sem INTO rz, kps
      FROM grupa WHERE kod_grupy = NEW.kod_grupy;
      IF (rz = 'w') THEN RETURN NEW; END IF;
      FOR gw IN
         (SELECT kod_grupy
          FROM grupa
          WHERE kod_przed_sem = kps AND rodzaj_zajec='w')
     LOOP
        IF NOT EXISTS(
               SELECT * FROM wybor
               WHERE kod_uz= NEW.kod_uz AND kod_grupy=gw)
        THEN
           INSERT INTO wybor(kod_uz,kod_grupy,data)
                       VALUES(NEW.kod_uz, gw, NEW.data);
        END IF;
     END LOOP;
     RETURN NEW;
  END
$X$ LANGUAGE plpgsql;

CREATE TRIGGER on_insert_to_wybor AFTER INSERT ON wybor FOR EACH ROW EXECUTE PROCEDURE zapisz_tez_na_wyklad();

CREATE OR REPLACE FUNCTION zapisz_wszystkich_na_wyklad()
   RETURNS TRIGGER AS $X$
   DECLARE st INT;
   BEGIN
      FOR st IN ((SELECT w.kod_uz
                  FROM wybor w JOIN grupa g USING(kod_grupy)
                  WHERE rodzaj_zajec<>'w' AND    
                        kod_przed_sem=new.kod_przed_sem)
                 EXCEPT
                 (SELECT w.kod_uz
                  FROM wybor w JOIN grupa g USING(kod_grupy)
                  WHERE rodzaj_zajec='w' AND
                        kod_przed_sem=new.kod_przed_sem))
      LOOP
         INSERT INTO wybor(kod_uz,kod_grupy,data)
            VALUES(st,new.kod_grupy,current_timestamp);
      END LOOP;
      RETURN NULL;
   END
$X$ LANGUAGE plpgsql;

CREATE TRIGGER on_insert_to_grupa AFTER INSERT ON grupa FOR EACH ROW WHEN (NEW.rodzaj_zajec='w') EXECUTE PROCEDURE zapisz_wszystkich_na_wyklad();
