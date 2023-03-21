--DML-->Data Manupulatin Lang.INSERT UPDATE DELETE--
--UPDATE
--SYNTAX
   --Eğer bir soruda bir veriyi değiştiriniz gibi bir soruyla karşılaşırsak
   --Önce UPDATE tablo_adi
   --     SET sütun_adi 
select * from personel  
--Personel tablosunda id si 1001 olan öğrencinin ismini Erol Evren olarak değiştiriniz
UPDATE personel
SET isim = 'Erol Evren'--> WHERE şartı kullanmadan update işlemi yaptığımızda bütün sütunu set değeriyle değiştirdi
WHERE id='1001';
CREATE TABLE hastaneler
(
id char(5) primary key, 
isim char(30),
sehir char(15),
ozel char(1)
); 
insert into hastaneler values('H101', 'Aci Madem Hastanesi', 'Istanbul', 'Y');
insert into hastaneler values('H102', 'HasZeki Hastanesi', 'Istanbul', 'N');
insert into hastaneler values('H103', 'Medikol Hastanesi', 'Izmir', 'Y');
insert into hastaneler values('H104', 'Memoryil Hastanesi', 'Ankara', 'Y');
CREATE TABLE hastalar(
  kimlik_no CHAR(11) PRIMARY Key,
  isim CHAR(50) ,
  teshis  CHAR(20)
  );
  insert INTO hastalar values('12345678901','Ali Can','Gizli Seker');
  insert INTO hastalar values('45678901121','Ayse Yilmaz','Hipertansiyon');
  insert INTO hastalar values('78901123451','Steve Jobs','Pankreatit');
  insert INTO hastalar values('12344321251','Tom Hanks','COVID 19');
   
create table bolumler(
bolum_id char(5),
bolum_adi char(20)
);
insert into bolumler values('DHL','Dahiliye');
insert into bolumler values('KBB','Kulak Burun Bogaz');
insert into bolumler values('NRJ','Noroloji');
insert into bolumler values('GAST','Gastoroloji');
insert into bolumler values('KARD','Kardioloji');
insert into bolumler values('PSK','Psikiyatri');
insert into bolumler values('GOZ','Goz Hastaliklari');
create table hasta_kayitlar(
kimlik_no char(11) Primary key,
hasta_ismi char(20),
hastane_adi char(50),
bolum_adi char(20),
teshis char(20)
);
insert into hasta_kayitlar values('1111','NO NAME','','','');
insert into hasta_kayitlar values('2222','NO NAME','','','');
insert into hasta_kayitlar values('3333','NO NAME','','','');
insert into hasta_kayitlar values('4444','NO NAME','','','');
insert into hasta_kayitlar values('5555','NO NAME','','','');
/*
hasta_kayıtlar tablosundaki ‘3333’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : ‘Salvadore Dali’ ismi ile
hastane_adi: ‘John Hopins’
bolum_adi: ‘Noroloji’
teshis: ‘Parkinson’
kimlik_no: ‘99991111222’
*/
SELECT * from hasta_kayitlar;
UPDATE hasta_kayitlar
SET hasta_ismi='Salvadore Dali',
    hastane_adi='John Hopins',
    bolum_adi='Noroloji',
    teshis='Parkinson',
    kimlik_no='99991111222'
WHERE kimlik_no='3333';
/*
hasta_kayıtlar tablosundaki ‘1111’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : hastalar tablosundaki kimlik nosu ‘12345678901’ olan kişinin ismi ile
hastane_adi: hastaneler tablosundaki 'H104' bolum_id kodlu hastanenin ismi ile
bolum_adi: bolumler tablosundaki 'DHL' bolum_id kodlu bolum_adi ile
teshis: hastalar tablosundaki 'Ali Can' isimli hastanın teshis bilgisi ile
kimlik_no: hastalar tablosundaki 'Ali Can' isimli hastanın kimlik_no kodu ile
*/
UPDATE hasta_kayitlar
SET hasta_ismi=(SELECT isim FROM hastalar WHERE kimlik_no='12345678901'),
    hastane_adi=(SELECT isim FROM hastaneler WHERE id='H104'),
    bolum_adi=(SELECT bolum_adi FROM bolumler WHERE bolum_id='DHL'),
    teshis=(SELECT teshis FROM hastalar WHERE isim='Ali Can'),
    kimlik_no=(SELECT kimlik_no FROM hastalar WHERE isim='Ali Can')
WHERE kimlik_no='1111';
--ALIES
select hasta_ismi as isim from hasta_kayitlar
--IS NULL CONDITION
CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir'); 
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');  
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');
SELECT * from insanlar
--İnsanlar tablosunda name değeri null olan tüm verileri listeleyiniz
SELECT * FROM insanlar WHERE name IS NULL
--İnsanlar tablosunda name değeri null olmayan tüm verileri listeleyiniz
SELECT * FROM insanlar WHERE name is not null
--Insanlar tablosunda name değeri null olan verilerin yerine 'isim girilmemis' yazdıralım
UPDATE insanlar
SET name = 'isim girilmemis'
WHERE name IS NULL
--ORDER BY KOMUTU
--asc->Küçükten büyüğe yada alfabetik olarak sıralar.Defaut olarak yazmadan kullanılır
--Desc->Büyükten küçüğe yada tersten sıralama yapar 
DROP TABLE insanlar
CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
select * from insanlar
--Insanlar tablosunda adres sütununu alfabetik olarak sıralı şekilde tüm verileri listeleyiniz 
SELECT * FROM insanlar ORDER BY adres asc
--Insanlar tablosundaki soyisim sütununu tersten sıralayınız
SELECT * FROM insanlar ORDER BY soyisim DESC
--Insanlar tablosunda isim ve soyisimleri önce isme göre natural sıralama sonra soyisme göre tersten sıralayınız
SELECT * FROM insanlar ORDER BY isim ASC, soyisim DESC
--isim ve soyisim sütunlarını soyisim kelime uzunluğuna göre sıralayınız
SELECT * FROM insanlar ORDER BY LENGTH (soyisim);
--isim ve soyisim sütunlarını birleştiriniz
SELECT ssn,CONCAT (isim,' ',soyisim,' ',adres) as isim_soyisim_adres FROM insanlar ORDER BY LENGTH (isim)
--GROUP BY
create table sirket(
isim varchar(20),    
sehir varchar(20),
maas int    
);
insert into sirket values ('erol','burdur',1000);
insert into sirket values ('erol','antalya',2000);
insert into sirket values ('erol','izmir',1500);
insert into sirket values ('ahmet','bursa',900);
insert into sirket values ('ahmet','izmir',2500);
insert into sirket values ('ahmet','istanbul',1800);
insert into sirket values ('mert','trabzon',1200);
insert into sirket values ('mert','istanbul',1000);
insert into sirket values ('mert','antep',2000);
insert into sirket values ('mert','tokat',3000);
insert into sirket values ('eda','antep',1200);
insert into sirket values ('eda','urfa',1500);
insert into sirket values ('erol','usak',2000);
insert into sirket values ('erol','burdur',900);
select * from sirket
--Şirkette çalışanların isimlerini listeleyiniz
select isim from sirket 
GROUP BY isim;
--Şirkette kim hangi şehirde çalışıyor listeleyiniz
SELECT isim,sehir FROM sirket
GROUP BY isim,sehir order by isim
--GROUP BY KOMUTU AGGREGATE METHOTLARLA KULLANIMI
--Şirkette çalışanların toplam maaşını listeleyiniz
SELECT isim,sum(maas) as toplam_maas FROM sirket
GROUP BY isim
--Şirkette çalişanların en yüksek maas ve en düşük maaslarını listeleyiniz
SELECT isim,max(maas) as enyuksekmaas,min(maas) as endusukmaas,round(avg(maas),2) as maasort FROM sirket
group by isim
--Tabloda kim kaç ilde çaliştiğini listeleyiniz
SELECT isim,count(sehir) as calistigi_iller FROM sirket
GROUP BY isim order by isim
--HAVING --> Sadece Group by komutu ile kullanılır. Gruplamadan sonra bir şart var ise WHERE komutu kullanamayız
            --Onun yerine aynı anlama gelen HAVING komutu kullanılır
--Toplam maası 7000'in altında olan kişileri listeleyiniz
SELECT isim,sum(maas) as toplam_maas FROM sirket
GROUP By isim
HAVING sum(maas)<7000;
--Sehirlere göre ortama maaslari 2000'in altındakileri ortalama maaşlarına göre büyükten küçüğe listeleyiniz
SELECT sehir,round(avg(maas)) as ortalama_maas FROM sirket 
GROUP by sehir
HAVING avg(maas)<2000 order by ortalama_maas desc;
select * from sirket order by isim;


--GROUP BY
create table sirket(
isim varchar(20),    
sehir varchar(20),
maas int    
);
insert into sirket values ('erol','burdur',1000);
insert into sirket values ('erol','antalya',2000);
insert into sirket values ('erol','izmir',1500);
insert into sirket values ('ahmet','bursa',900);
insert into sirket values ('ahmet','izmir',2500);
insert into sirket values ('ahmet','istanbul',1800);
insert into sirket values ('mert','trabzon',1200);
insert into sirket values ('mert','istanbul',1000);
insert into sirket values ('mert','antep',2000);
insert into sirket values ('mert','tokat',3000);
insert into sirket values ('eda','antep',1200);
insert into sirket values ('eda','urfa',1500);
insert into sirket values ('erol','usak',2000);
insert into sirket values ('erol','burdur',900);
select * from sirket
--Şirkette çalışanların isimlerini listeleyiniz
select isim from sirket 
GROUP BY isim;
--Şirkette kim hangi şehirde çalışıyor listeleyiniz
SELECT isim,sehir FROM sirket
GROUP BY isim,sehir order by isim
--GROUP BY KOMUTU AGGREGATE METHOTLARLA KULLANIMI
--Şirkette çalışanların toplam maaşını listeleyiniz
SELECT isim,sum(maas) as toplam_maas FROM sirket
GROUP BY isim
--Şirkette çalişanların en yüksek maas ve en düşük maaslarını listeleyiniz
SELECT isim,max(maas) as enyuksekmaas,min(maas) as endusukmaas,round(avg(maas),2) as maasort FROM sirket
group by isim
--Tabloda kim kaç ilde çaliştiğini listeleyiniz
SELECT isim,count(sehir) as calistigi_iller FROM sirket
GROUP BY isim order by isim
--HAVING --> Sadece Group by komutu ile kullanılır. Gruplamadan sonra bir şart var ise WHERE komutu kullanamayız
            --Onun yerine aynı anlama gelen HAVING komutu kullanılır
--Toplam maası 7000'in altında olan kişileri listeleyiniz
SELECT isim,sum(maas) as toplam_maas FROM sirket
GROUP By isim
HAVING sum(maas)<7000;
--Sehirlere göre ortama maaslari 2000'in altındakileri ortalama maaşlarına göre büyükten küçüğe listeleyiniz
SELECT sehir,round(avg(maas)) as ortalama_maas FROM sirket 
GROUP by sehir
HAVING avg(maas)<2000 order by ortalama_maas desc;
select * from sirket order by isim