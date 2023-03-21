--LIKE CONDITION
--ismi v ile baslayan personeli listeleyiniz
SELECT * from personel1 WHERE isim iLIKE 'v%'
--sonu n ile biten personelin tüm bilgilerini listeleyiniz
SELECT * from personel1 WHERE isim iLIKE '%n'
--isminin içinde tm olan personelin tüm bilgilerini listeleyiniz
SELECT * from personel1 WHERE isim LIKE '%tm%'
CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  
Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3);  
INSERT INTO kelimeler VALUES (1003, 'hit', 3);  
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);  
INSERT INTO kelimeler VALUES (1008, 'hct', 3);  
INSERT INTO kelimeler VALUES (1005, 'adem', 4);  
INSERT INTO kelimeler VALUES (1006, 'selim', 5);  
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1011, 'EROL', 4);
INSERT INTO kelimeler VALUES (1009, 'EVREN', 5);
INSERT INTO kelimeler VALUES (1010, 'ADEM', 4);
SELECT * FROM kelimeler;
--REGEXP LIKE(MySQL) -->PGAdmin AltGr+Ü tuşu ile ~ bu karakteri kullanıyoruz
--LIKE -> ~~
--SORU  : Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini  yazdiran
--QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ 'h[ai]t';
--UPPER-LOWER-INITCAP
--Kelime sütunundaki bütün dataları büyük yazdırın -->UPPER
SELECT UPPER(kelime) as kelime FROM kelimeler
--Kelimeler sütunundaki tüm dataları küçük yazdıralım
SELECT LOWER(kelime) as kelime FROM kelimeler
--Kelimer sütunundaki tüm dataların ilk harfini büyük yazalım
SELECT INITCAP(kelime) as kelime FROM kelimeler
--Kelimeler sütunundaki Erol ismini küçük harflerle listeleyiniz
SELECT lower(kelime) as kelime FROM kelimeler WHERE kelime='EROL'
--Kelimeler tablosunda kelime sütunundaki tüm verileri kalıcı olarak küçük harf yapınız
UPDATE kelimeler
SET kelime = lower(kelime);
--DISTINCT
CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (30, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (40, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (50, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (60, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (70, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (80, 'Elif', 'Elma');
select urun_isim from musteri_urun
--Müsteri_urun tablosundan müsteri isimlerini tekrarsız(group) listeleyiniz
SELECT DISTINCT(musteri_isim) FROM musteri_urun
--Group By ile çözümü;
select musteri_isim from musteri_urun
group by musteri_isim
--Müsteri_urun tablosundaki meyve çeşitlerini listeleyiniz
SELECT DISTINCT(urun_isim) FROM musteri_urun
--Müşteri urun tablosunda kaç çeşit meyve satılıyor listeleyiniz
select count(DISTINCT urun_isim) as urun_cesit_sayisi from musteri_urun
--FETCH NEXT (SAYI) ROW ONLY- OFFSET
--Musteri urun tablosundan son 3 kaydı listeleyiniz 
--limit ile çözümü
SELECT * FROM musteri_urun
ORDER BY urun_id desc limit 1
--FETCH NEXT (SAYI) ROW ONLY ile çözümü
SELECT * FROM musteri_urun
ORDER BY urun_id desc 
FETCH NEXT 1 ROW ONLY
--Musteri urun tablosundan bastan 3. kaydı listeleyiniz
SELECT * FROM musteri_urun
OFFSET 2 limit 1
--Musteri urun tablosundan 4. 5. 6. kaydı listeleyiniz
SELECT * FROM musteri_urun
order by urun_id
OFFSET 3 limit 3
--FETCH NEXT ile çözümü;
SELECT * FROM musteri_urun
order by urun_id
OFFSET 3 ROW FETCH NEXT 3 ROW ONLY
--ALTER TABLE -->Tablodaki sütun,sütunların data typeleri ve tablonun kendisine müdahale edebilmek için ALTER komutu kullanırız
--ADD
/*SYNTAX
ALTER TABLE tablo_adı
ADD sütun_adi
*/
SELECT * FROM musteri_urun
--Yeni bir sütun ekleme
ALTER TABLE musteri_urun
ADD kasa_sayisi varchar(5);
ALTER TABLE musteri_urun
ADD sehir varchar(20) default 'Ankara';
--urun_id sütununa primary key ekleyelim
/*
 NOT: Constraintler genellikle tablo oluşturulur atanmalı. Constarint olmayan bir tabloya sonradan constraint eklemek
ilişkili tablolarda karışıklığa yol açabilir
*/
ALTER TABLE musteri_urun
ADD constraint pk primary key (urun_id);
--DROP
--Eğer bir sütunu yada constraint'i silmek isterseniz DROP komutu kullanılır ve DROP komutundan sonra 
--Constraint yazıp constraint ismini belirtmemiz gerekir
ALTER TABLE musteri_urun
DROP constraint pk;
--Sehir sütununu silelim
ALTER TABLE musteri_urun
DROP sehir
SELECT * FROM meyveler
--RENAME
ALTER TABLE musteri_urun
rename urun_isim to meyve
ALTER TABLE musteri_urun
RENAME to meyveler -->Tablo ismi meyveler olarak değişti
--TYPE/SET
ALTER TABLE meyveler
alter kasa_sayisi TYPE char(10);
alter meyve SET NOT NULL
--SET
ALTER TABLE meyveler
alter meyve SET NOT NULL; -->meyve isimli sütuna NOT NULL ataması yaptık
--DATA TYPE DEĞİŞTİRME
ALTER TABLE meyveler
ALTER kasa_sayisi TYPE int using(kasa_sayisi::int);
drop table 
--Transaction BLOCK
CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
select * from ogrenciler2
delete from ogrenciler2
rollback to x;
COMMIT;
--Interview
Create table isci(
id char(2),
isim varchar(10),
maas int    
);
insert into isci values ('10','Erol',1000);
insert into isci values ('11','Evren',1500);
insert into isci values ('12','Emre',2000);
create table isci_adres(
id char(2),
sehir varchar(20),
tel varchar(15)    
);
insert into isci_adres values ('10','Burdur','0523125465');
insert into isci_adres values ('11','Ankara','0546532133');
insert into isci_adres values ('12','Bursa','0213213545');
select * from isci
--Personellerin isim ve sehirlerini listeleyiniz
SELECT isci.isim,isci_adres.sehir FROM
isci full join isci_adres ON isci.id=isci_adres.id
--Ankarada çalışan personelin id ve ismini listeleyiniz
SELECT id,isim FROM isci WHERE id in
(SELECT id FROM isci_adres WHERE sehir='Ankara')
