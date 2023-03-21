--Primary Key ve Foreign Key Practice
Create table student(
st_no char(4) PRIMARY KEY,
isim varchar(10),
soyisim varchar(20),
tel varchar(11),
email varchar(20),
sehir varchar(20)    
);
SELECT * FROM student;
INSERT INTO student VALUES ('1234','Erol','Evren','053213546','erol@gmail.com','Ankara');
INSERT INTO student VALUES ('1235','Berk','Can','05322564','berk@gmail.com','Bursa');
INSERT INTO student VALUES ('1236','Rümeysa','Kaya','05325465','rümeysa@gmail.com','Izmir');
INSERT INTO student VALUES ('1237','Ahmet','Erkan','053215467','ahmet@gmail.com','Istanbul');
INSERT INTO student VALUES ('1238','Emre','Can','0532165466','emre@gmail.com','Burdur');
Create table notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real,
finalnotu real,
FOREIGN KEY (st_no) references student (st_no)    
);
INSERT INTO notlar VALUES ('1234','1. Dönem',75.5,80,85.5);
INSERT INTO notlar VALUES ('1235','1. Dönem',70,65,82.5);
INSERT INTO notlar VALUES ('1236','1. Dönem',65,95,70);
INSERT INTO notlar VALUES ('1237','1. Dönem',55,95,70);
INSERT INTO notlar VALUES ('1238','1. Dönem',0,50,85);
INSERT INTO notlar VALUES ('1234','2. Dönem',65,80.5,75);
INSERT INTO notlar VALUES ('1239','2. Dönem',55,75,95);
--DQL->Data Query Lang. -> WHERE koşulu
--Student tablosundan Berk isimli öğrencinin tel ve email bilgilerini listeleyiniz
SELECT * FROM student 
SELECT isim,tel,email FROM student WHERE isim='Berk';
--Öğrenci numarası 1236 olan öğrencinin tüm bilgilerini listeleyiniz
SELECT * FROM student WHERE st_no = '1236';
--Öğrenci numarası 1236 olan öğrencinin isim,tel ve email bilgilerini listeleyiniz
SELECT isim,tel,email FROM student WHERE st_no = '1236'
--Öğrenci numarası 1238 olan öğrencinin notlarını listeleyiniz
SELECT * FROM NOTLAR
WHERE st_no='1238';
--Öğrenci numarası 1234 olan öğrencinin notları
SELECT * FROM NOTLAR
WHERE st_no='1234';
--CHECK CONSTRANT-->Bir sütunu sınırlandırmak için kullanılır
--Constraint atamaları tablo oluşturulurken yapılmalı. Sonrasında ALTER table ile yapılan değişiklikler karışıklığa yol açar
Create table notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real check (ikincivizenotu>45),
finalnotu real check (finalnotu>45),
FOREIGN KEY (st_no) references student (st_no)    
);
INSERT INTO notlar VALUES ('1234','1. Dönem',75.5,80,85.5);
INSERT INTO notlar VALUES ('1235','1. Dönem',70,65,82.5);
INSERT INTO notlar VALUES ('1236','1. Dönem',65,95,70);
INSERT INTO notlar VALUES ('1237','1. Dönem',55,95,70);
INSERT INTO notlar VALUES ('1238','1. Dönem',0,50,85);
INSERT INTO notlar VALUES ('1234','2. Dönem',65,80.5,75);
INSERT INTO notlar VALUES ('1235','2. Dönem',55,46,50);
select * from notlar
--Notlar tablosundan 80'nin üstündeki ikinci vizenotları listelyiniz
SELECT ikincivizenotu FROM notlar WHERE ikincivizenotu > 80;
--Notlar tablosundan ilkvize notu 65'in altında olanları listeleyiniz
SELECT ilkvizenotu FROM notlar WHERE ilkvizenotu<65;
--DML -> DELETE komutu -> Tablo içindeki verileri siler
--SYNTAX
--DELETE FROM tablo_adi
--Eğer istediğimiz veriyi silmek istersek DELETE FROM tablo_adi WHERE sütun_adi=veri
DELETE FROM notlar; -- Notlar tablosundaki tüm veriler silindi
--Notlar tablosunda öğrenci numarası 1234 olan verinin tüm notlarını siliniz
DELETE FROM notlar WHERE st_no = '1234';
--Student tablosundan öğrenci numarası 1234 olan verinin tüm bilgilerini siliniz
DELETE FROM student WHERE st_no = '1234';
--İlişkili tablolarda child tablodan veri silmeden parent tablodan silemeyiz. Eğer o veriyi silmek istiyorsak
--önce child tablodan sonra parent tablodan silebiliriz.
--NOT: Child tabloda olan bir veriyi Parent tablodan silmeye çalışalırsak
--ERROR:  update or delete on table "student" violates foreign key constraint "notlar_st_no_fkey" on table "notlar"
--hatayı alırız
DELETE FROM student WHERE st_no = '1235';
SELECT * FROM student 
select * from notlar
--TRUNCATE -> Bu komut ile tablodaki tüm verileri silebiliriz.Yanliz şartlı silme yapamayız
TRUNCATE TABLE notlar;
-- ON DELETE CASCADE -->Bu komut sayesinde parent tablodan istediğimiz veriyi silebiliriz.
--Parent tablodan sildiğimiz zaman child tablodan da silinir
Create table notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real check (ikincivizenotu>45),
finalnotu real check (finalnotu>45),
FOREIGN KEY (st_no) references student (st_no) ON DELETE CASCADE    
);
INSERT INTO notlar VALUES ('1234','1. Dönem',75.5,80,85.5);
INSERT INTO notlar VALUES ('1235','1. Dönem',70,65,82.5);
INSERT INTO notlar VALUES ('1236','1. Dönem',65,95,70);
INSERT INTO notlar VALUES ('1237','1. Dönem',55,95,70);
INSERT INTO notlar VALUES ('1238','1. Dönem',0,50,85);
INSERT INTO notlar VALUES ('1234','2. Dönem',65,80.5,75);
INSERT INTO notlar VALUES ('1235','2. Dönem',55,46,50);
select * from notlar;
--Student tablosundan 1234 öğrenci numaralı öğrencinin tüm verilerini siliniz
DELETE FROM student WHERE st_no = '1234' 
/*
    ON DELETE CASCADE komutu kullanmadan parent tabloyu tamamen kaldırmak istersek,
önce child table'ı kaldırmamız gerekir.
    ON DELETE CASCADE komutunu child table oluştururken kullandıysak
-*- DROP TABLE parent_tablo_ismi CASCADE -*- yazarak kaldırabiliriz    
*/
DROP TABLE tablo_adi --> tabloyu tamamen database kaldırma komutu
DROP TABLE student CASCADE;
select * from student
-- IN CONDITION
CREATE TABLE musteriler(
urun_id int,  
musteri_isim varchar(50),  
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (20, 'John', 'Apple');  
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');  
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');  
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');  
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');  
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');
select * from musteriler
--AND ->Her iki şartı birden sağlaması gerekir
--OR -> Tek bir şartı sağlasa yeterlidir
--Ürün ismi orange ile Apple olan müşteri isimlerini listeleyiniz
SELECT musteri_isim,urun_isim FROM musteriler WHERE urun_isim='Orange' or urun_isim='Apple';
--2. YOL --> IN CONDITION KULLANIMI
SELECT musteri_isim,urun_isim FROM musteriler WHERE urun_isim IN ('Orange','Apple');
--Müsteri ismi Amy olan ile urun_ismi Palm olan verileri listeleyiniz
SELECT musteri_isim,urun_isim From musteriler WHERE musteri_isim='Mark' and urun_isim='Orange';
--NOT IN
--Ürün ismi orange ile Apple olmayan müsteri ve ürün isimlerini listeleyiniz
SELECT musteri_isim,urun_isim FROM musteriler WHERE urun_isim NOT IN ('Orange','Apple');
--BETWEEN CONDITION
--Urün id değerleri 20 ile 40 arasında olan tüm verileri listeleyiniz
SELECT * FROM musteriler WHERE urun_id>=20 and urun_id<=40;
--BETWEEN ile ;
SELECT * FROM musteriler WHERE urun_id BETWEEN 20 and 40
--NOT BETWEEN
--Urün id değerleri 20 ile 40 arasında olmayan tüm verileri listeleyiniz
SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 and 40
/*
Practice 6
id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
D ile Y arasındaki personel bilgilerini listeleyiniz
D ile Y arasında olmayan personel bilgilerini listeleyiniz
Maaşı 70000 ve ismi Sena olan personeli listeleyiniz
*/
Drop table personel
CREATE table personel
(
id char(4),
isim varchar(50),
maas int
);
insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);
Select * from personel;
--id'si 1003 ile 1005 arasında olan personellerin bilgilerini listeleyiniz
SELECT * FROM personel WHERE id BETWEEN '1003' and '1005';
--D ile Y arasındaki personellerin bilgilerini listeleyiniz
SELECT * FROM personel WHERE isim BETWEEN 'Derya Soylu' and 'Yavuz Bal'
--D ile Y arasında olmayan personellerin bilgilerini listeleyiniz
SELECT * FROM personel WHERE isim NOT BETWEEN 'Derya Soylu' and 'Yavuz Bal'
--Maaşı 70000 ve ismi Sena olan personelleri listeleyiniz
SELECT * from personel WHERE maas=70000 or isim = 'Sena Beyaz'
--SUBQUERY(Alt Sorgu)
CREATE TABLE calisanlar2 
(
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
select * from calisanlar2
--Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.
SELECT isyeri,isim,maas FROM calisanlar2 
WHERE isyeri IN (SELECT marka_isim from markalar WHERE calisan_sayisi>15000);
--marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
SELECT isim,maas,sehir FROM calisanlar2 
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE marka_id>101);
--AGGREGATE METHOD->(sum(),count(),min(),max(),avg()->ortalama)
--Calisanlar tablosundaki en yüksek maası listeleyiniz
SELECT max(maas) as en_yuksek_maas FROM calisanlar2
--En düşük maas
Select min(maas) as en_dusuk_maas FROM calisanlar2
--Calisanlar tablosunda kaç kişi olduğunu listeleyiniz
SELECT count(isim) as kisi_sayisi FROM calisanlar2 --count(*) komutuda aynı sonucu verir tablodaki satırları sayar
--Calisanlar tablosundaki maaş ortalamasını listeleyiniz
SELECT avg(maas) FROM calisanlar2
--avg() methodda çıkan sonucu yuvarlamak için;
SELECT round(avg(maas)) FROM calisanlar2
SELECT round(avg(maas),2) as maas_ortalamalari FROM calisanlar2
SELECT * from markalar
-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
SELECT marka_id,marka_isim,(SELECT count(sehir) FROM calisanlar2 WHERE marka_isim=isyeri) as sehir_sayisi 
FROM markalar;
--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
SELECT marka_isim,calisan_sayisi,(SELECT sum(maas) FROM calisanlar2 WHERE marka_isim=isyeri) as toplam_maas FROM markalar
--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
SELECT marka_isim,calisan_sayisi,
(SELECT max(maas) FROM calisanlar2 WHERE marka_isim=isyeri) as en_yuksek_maas,
(SELECT min(maas) FROM calisanlar2 WHERE marka_isim=isyeri) as en_dusuk_maas FROM markalar
--EXISTS CONDITION->Eğer iki tablodaki sütunlar aynı ise EXISTS CONDITION kullanılır
CREATE TABLE mart
(   
urun_id int,    
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');
CREATE TABLE nisan 
(   
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');
select * from mart
select * from nisan 
/*
  MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
  URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
  MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız. 
*/
SELECT urun_id,musteri_isim FROM mart 
WHERE exists (SELECT urun_id FROM nisan WHERE mart.urun_id=nisan.urun_id); 
/*
--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
*/
SELECT urun_isim,musteri_isim FROM nisan
WHERE exists (SELECT urun_isim FROM mart WHERE mart.urun_isim=nisan.urun_isim);
--DML--> UPDATE --
--SYNTAX
   --Eğer bir soruda bir veriyi değiştiriniz gibi bir soruyla karşılaşırsak
   --Önce UPDATE tablo_adi
   --     SET sütun_adi              
