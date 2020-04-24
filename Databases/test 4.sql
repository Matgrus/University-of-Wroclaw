-- Mateusz Gruszecki, mpy
-- Zadanie 1
-- 	- Dodaj do tabeli comments kolumnę lasteditdate typu timestamp z więzem NOT NULL i domyślną wartością now().
-- 	  Wypełnij ją obecnymi wartościami creationdate.
-- 	- Utwórz tabelę commenthistory z kolumnami id SERIAL PRIMARY KEY, commentid integer, creationdate timestamp oraz text text.

alter table comments add column lasteditdate timestamp not null default now();
update comments set lasteditdate=creationdate;
create table commenthistory(id serial primary key, commentid integer, creationdate timestamp, text text);

-- Zadanie 2
-- 	Napisz wyzwalacz, który zostanie uruchomiony przy każdej próbie wykonania operacji UPDATE na tabeli comments i sprawi, że:
-- 	- jakiekolwiek zmiany pola creationdate zostaną zignorowane, tzn. po operacji ma pozostać dotychczasowa wartość tego pola,
-- 	- w przypadku próby zmiany id, postid lub lasteditdate powinien być zgłoszony błąd za pomocą RAISE EXCEPTION,
-- 	- jeśli operacja zmienia pole text to:
-- 	    - w wyniku tej operacji lasteditdate ma przyjąć wartość now(),
-- 	    - do tabeli commenthistory zostanie dodana krotka z opisem starej wersji: commentid powinna przyjąć wartość id zmienianego komentarza,
-- 	      creationdate – dotychczasową wartość lasteditdate, a text – dotychczasową wartość text.

create or replace function comments_fun() returns trigger as $x$
begin
if(new.creationdate <> old.creationdate)
then return null; end if;
if(new.id <> old.id or new.postid <> old.postid or new.lasteditdate <> old.lasteditdate)
then raise exception 'do not change id, postid or lasteditdate'; end if;
if(new.text <> old.text)
then insert into commenthistory(commentid, creationdate, text) values(old.id, old.lasteditdate, old.text);
new.lasteditdate=now();
end if;
return new;
end
$x$ language plpgsql;

create trigger comments_trigger before update on comments for each row execute procedure comments_fun();

-- Zadanie 3
-- 	Aplikacja obsługująca forum dodaje komentarze za pomocą polecenia
-- 	  INSERT INTO
-- 	  comments(id, postid, score, text, creationdate, userid, userdisplayname)
-- 	  VALUES (...)
-- 	nie biorąc pod uwagę powyższych zmian, tj. nie ustawia wartości lasteditdate.
-- 	W efekcie pole to przyjmuje obecnie ustawioną wartość domyślną – now(). 
-- 	Okazało się, że czasem powoduje to różnicę pomiędzy wartościami lasteditdate oraz creationdate (ustalaną po stronie aplikacji), która jest kłopotliwa.
-- 	W jaki sposób sprawić, aby wartość lasteditdate dla każdego nowododanego komentarza początkowo była równa creationdate?
-- 	Oczywiście nie masz dostępu do kodu aplikacji i nie możesz go zmieniać. Napisz odpowiedni kod SQL.

create or replace function comments_insert_fun() returns trigger as $x$
begin
new.lasteditdate = new.creationdate;
return new;
end
$x$ language plpgsql;

create trigger comments_insert_trigger before insert on comments for each row execute procedure comments_insert_fun();
