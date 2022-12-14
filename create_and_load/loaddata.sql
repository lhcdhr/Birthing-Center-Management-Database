-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

-- This is only an example of how you add INSERT statements to this file.
--   You may remove it.
INSERT INTO MYTEST01 (id, value) VALUES(4, 1300);
-- A more complex syntax that saves you typing effort.

INSERT INTO Mothers (QHCid,name,date_of_birth,address,phone,email,profession,bloodtype) VALUES
('PTUJ84302609', 'Victoria Gutierrez', '1990-02-02', '2952 Ste. Catherine Ouest', '514-780-3892', 'vicgui@gmail.com', 'Radio presenter','A')
, ('LXAI71980964','Tristin Sault','1990-07-13','3139 Papineau Avenue','514-889-5248','trissau@gmail.com','Cleaner','B')
, ('HKIT84373824','Liliana Dennel','1991-02-21','2752 avenue Royale','418-805-5049','lilden@hotmail.com','Engineer','A')
, ('FDTX93661074','Adrienne Hall','1993-11-01','1341 chemin Hudson','514-622-5485','adrhal@hotmail.com','Events organiser','A')
, ('ZPHO39304560','McKinley Foss','1996-02-09','3568 rue Levy','514-709-5044','mckfos@hotmail.com','Bank clerk','O')
, ('YGGE11172544','Felecia Delacroix','1996-03-29','4051 rue Fournier','450-966-4525','feldel@gmail.com','Programmer','AB')
, ('QIMA08748355','Marine Booth','1995-04-17','1393 Main St','306-925-0207','marboo@gmail.com','Librarian','O')
;

INSERT INTO Fathers (fid, QHCid, name, date_of_birth, address, phone, email, profession, bloodtype) VALUES
('F001','DRLO02635942','Bill Gutierrez','1988-02-23','2952 Ste. Catherine Ouest','306-332-2904','bilgui@gmail.com','Researcher','B')
,('F002','GRXL77859925','Otto Sault','1990-05-01','3139 Papineau Avenue','780-718-2921','ottsau@gmail.com','Security guard','A')
,('F003','ZOOQ44883719','Emmanuel Dennel','1991-04-29','2752 avenue Royale','416-242-7530','emmden@gmail.com','Waiter','AB')
,('F004','RKIC50369328','Matthias Hall','1991-10-11','1341 chemin Hudson','905-328-6654','methal@hotmail.com','Pilot','O')
,('F005','MKYJ94059629','Elvin Foss','1992-06-15','3568 rue Levy','416-375-3622','elvfos@hotmail.com','Lifeguard','B')
,('F006','LXYF68545375','Calvin Delacroix','1995-01-17','4051 rue Fournier','807-624-8182','caldel@gmail.com','Civil servant','A')
,('F007','CHNP56151998','Wallen Booth','1992-04-07','1393 Main St','780-886-1238','walboo@gmail.com','Salesperson','AB')
;

INSERT INTO Couples (cid, times_of_pregnancy, mother_QHCid, father_id) VALUES
('C001',3 ,'PTUJ84302609','F001')
,('C002',2 ,'LXAI71980964','F002')
,('C003',1 ,'HKIT84373824','F003')
,('C004',2 ,'FDTX93661074','F004')
,('C005',2 ,'ZPHO39304560','F005')
,('C006',1 ,'YGGE11172544','F006')
,('C007',2 ,'QIMA08748355','F007')
;
INSERT INTO Healthcare_Institutions (email, name, address, website) VALUES
('home@lacsaintlouis.com','Lac-Saint-Louis','3427 Papineau Avenue','www.lacsaintlouis.com')
,('help@wihteriver.com','White River Clinic','4366 rue Levy','www.whiteriver.com')
,('home@pinemedical.com','Pinevale Medical Clinic','3711 Sherbrooke Ouest','www.pinemedical.com')
,('help@littleriver.com','Little River Clinic','3918 Ste. Catherine Ouest','www.littleriver.com')
,('help@pinerest.com','Pine Rest Medical Clinic','2024 rue Ontario Ouest','www.pinerest.com')
,('info@heartstonemedical.com','Heartstone Medical Center','4499 Ste. Catherine Ouest','www.heartstonemedical.com')
,('info@broadwatermedical.com','Broadwater General Hospital','2872 chemin Hudson','www.broadwatermedical.com')
,('home@snowflakecommunity.com','Snowflake Community Hospital','2376 Saint-Denis Street','www.snowflakecommunity.com')
,('info@greatriver.com','Great River Hospital','802 Papineau Avenue','www.greatriver.com')
,('info@bellevue.com','Bellevue Hospital','4957 Duke Street','www.bellevue.com')
;

INSERT INTO Community_Clinics (email) VALUES
('home@lacsaintlouis.com'),
('help@wihteriver.com'),
('home@pinemedical.com'),
('help@littleriver.com'),
('help@pinerest.com')
;

INSERT INTO Birthing_Centers(email) VALUES
('info@heartstonemedical.com'),
('info@broadwatermedical.com'),
('home@snowflakecommunity.com'),
('info@greatriver.com'),
('info@bellevue.com')
;

INSERT INTO Midwives (practitioner_id, name, email, phone, associated_institution_email) VALUES
('PM0000','Marion Girard','marigira@midwives.com','289-347-9130','home@lacsaintlouis.com'),
('PM0001','Maisy Whitaker','maiswhit@midwives.com','204-797-5697','home@lacsaintlouis.com'),
('PM0002','Brook Longstaff','broolong@midwives.com','450-706-6279','help@wihteriver.com'),
('PM0003','Alesha Otis','alesotisz@midwives.com','819-825-2956','home@pinemedical.com'),
('PM0004','Cyriell Summerfield','cyrisumm@midwives.com','905-268-8944','info@heartstonemedical.com'),
('PM0005','Lyndsay Wayne','lyndwayn@midwives.com','403-544-5489','info@broadwatermedical.com'),
('PM0006','Sandra Danniell','sanddann@midwives.com','819-319-7906','home@snowflakecommunity.com'),
('PM0007','Jaquelyn Ely','jaquely@midwives.com','506-693-9780','info@greatriver.com')
;

INSERT INTO Pregnancies (cid, nth_pregnancy, num_babies,birthing_address, expected_time_frame, final_expected_due, practitioner_id, backup_practitioner_id) VALUES
('C001','1','1','2952 Ste. Catherine Ouest','2020-03-01','2021-04-01','PM0000','PM0001'),
('C001','2','1','2952 Ste. Catherine Ouest','2020-12-01','2021-11-01','PM0000','PM0002'),
('C001','3','1','2952 Ste. Catherine Ouest','2022-02-01','2022-03-01','PM0000','PM0003'),
('C002','1','1','4499 Ste. Catherine Ouest','2020-04-01','2020-05-01','PM0002','PM0004'),
('C002','2','2','4499 Ste. Catherine Ouest','2021-06-01','2022-07-03','PM0003','PM0005'),
('C005','1','1','2872 chemin Hudson','2021-03-01','2022-07-02','PM0005','PM0006'),
('C001','4','1','2952 Ste. Catherine Ouest','2022-07-07','2022-08-08','PM0000','PM0003')
;

INSERT INTO Babies (cid, nth_pregnancy, nth_baby, gender, bloodtype, date_of_birth, time_of_birth, name) VALUES
('C001','1','1','M','A','2021-04-02','12:00:00','John'),
('C001','2','1','F','A','2021-10-13','13:00:00','Mary'),
('C001','3','1','M','A','2022-05-02','14:00:00','Mike'),
('C002','1','1','F','B','2020-05-15','8:00:00','Jenny'),
('C002','2','1','F','B','2022-02-08','19:00:00','Alice'),
('C002','2','2','M','A','2022-02-08','19:15:00','Alex'),
('C005','1','1','F','O','2021-08-10','5:00:00','Jake'),
('C001','4','1','F','A',NULL,NULL,'Lucy')
;

INSERT INTO Info_Sessions (practitioner_id, inf_date, inf_time, language) VALUES
('PM0000','2020-01-01','14:00:00','English'),
('PM0000','2020-08-09','15:00:00','English'),
('PM0002','2020-11-11','16:00:00','French'),
('PM0003','2021-02-09','17:00:00','English'),
('PM0005','2021-07-09','18:00:00','French'),
('PM0005','2022-02-25','14:00:00','French')
;

INSERT INTO invites (practitioner_id, inf_date, inf_time, cid, nth_pregnancy) VALUES
('PM0000','2020-01-01','14:00:00','C001','1'),
('PM0000','2020-01-01','14:00:00','C002','1'),
('PM0000','2020-08-09','15:00:00','C002','2'),
('PM0002','2020-11-11','16:00:00','C001','2'),
('PM0005','2021-07-09','18:00:00','C005','1'),
('PM0005','2022-02-25','14:00:00','C001','3')
;

INSERT INTO registers (practitioner_id, inf_date, inf_time, cid, nth_pregnancy) VALUES
('PM0000','2020-01-01','14:00:00','C001','1'),
('PM0000','2020-01-01','14:00:00','C002','1'),
('PM0000','2020-08-09','15:00:00','C002','2'),
('PM0002','2020-11-11','16:00:00','C001','2'),
('PM0005','2021-07-09','18:00:00','C005','1'),
('PM0005','2022-02-25','14:00:00','C001','3')
;
INSERT INTO attends (practitioner_id, inf_date, inf_time, cid, nth_pregnancy) VALUES
('PM0000','2020-01-01','14:00:00','C001','1'),
('PM0000','2020-01-01','14:00:00','C002','1'),
('PM0000','2020-08-09','15:00:00','C002','2'),
('PM0002','2020-11-11','16:00:00','C001','2'),
('PM0005','2021-07-09','18:00:00','C005','1'),
('PM0005','2022-02-25','14:00:00','C001','3')
;

INSERT INTO Appointments (practitioner_id, app_date, app_time, cid, nth_pregnancy) VALUES
('PM0000','2020-02-08','14:00:00','C001','1'),
('PM0000','2020-03-20','14:00:00','C001','1'),
('PM0000','2021-01-10','14:00:00','C001','2'),
('PM0000','2021-05-15','14:00:00','C001','2'),
('PM0001','2020-01-01','16:00:00','C002','1'),
('PM0002','2020-02-02','17:00:00','C002','1'),
('PM0000','2022-03-23','14:00:00','C001','3'),
('PM0000','2022-03-24','14:00:00','C002','2')
;

INSERT INTO Notes (practitioner_id, app_date, app_time, n_time, date, contents) VALUES
('PM0000','2020-02-08','14:00:00','14:30:00','2020-02-08','generally good'),
('PM0000','2020-02-08','14:00:00','14:45:00','2020-02-08','need to sleep more'),
('PM0000','2020-03-20','14:00:00','14:20:00','2020-03-20','looks energetic'),
('PM0000','2021-01-10','14:00:00','14:15:00','2021-01-10','need more rest'),
('PM0000','2021-05-15','14:00:00','14:30:00','2021-05-15','need more nutrition'),
('PM0001','2020-01-01','16:00:00','16:30:00','2020-01-01','looks positive'),
('PM0002','2020-02-02','17:00:00','17:20:00','2020-02-02','need some exercise')
;


INSERT INTO Technicians (tech_id, name, phone) VALUES
('T00001','Colten Rogerson','420-153-6157'),
('T00002','Edythe Hobson','449-165-1392'),
('T00003','Hannah Monday','301-614-0489'),
('T00004','Windsor Sharman','317-596-0072'),
('T00005','Beth Richardson','147-410-4986'),
('T00006','Maxton David','120-433-9437')
;

INSERT INTO Tests (tid, type, sample_date, testee, conduct_date, result, practitioner_id, prescribe_date, tech_id, cid, nth_pregnancy) VALUES
('TEST0001','blood iron','2019-08-08','Victoria Gutierrez','2019-08-08','good','PM0000','2019-07-08','T00001','C001','1'),
('TEST0002','dating ultrasound','2019-09-09','Victoria Gutierrez','2019-09-09','see estimate for result','PM0000','2019-08-20','T00002','C001','1'),
('TEST0003','blood iron','2019-07-07','Tristin Sault','2019-07-07','good','PM0002','2019-06-07','T00001','C002','1'),
('TEST0004','dating ultrasound','2020-02-05','Tristin Sault','2020-03-02','see estimate for result','PM0002','2020-02-01','T00002','C002','1'),
('TEST0005','blood iron','2020-08-08','Victoria Gutierrez','2020-08-08','good','PM0000','2020-08-01','T00001','C001','2'),
('TEST0006','dating ultrasound','2020-06-07','Tristin Sault','2020-07-01','see estimate for result','PM0003','2020-05-01','T00002','C002','2'),
('TEST0007','dating ultrasound','2021-11-20','Victoria Gutierrez','2021-11-25','see midwife for result','PM0000','2020-10-30','T00002','C001','3'),
('TEST0008','dating ultrasound','2021-02-01','McKinley Foss','2021-02-03','see midwife for result','PM0005','2021-01-25','T00002','C005','1')
;

INSERT INTO Dating_Ultrasounds (tid, expected_due) VALUES
('TEST0002','2020-04-01'),
('TEST0004','2020-06-08'),
('TEST0006','2020-08-01'),
('TEST0007','2022-02-01'),
('TEST0008','2021-08-01')
;

INSERT INTO estimates (practitioner_id, cid, nth_pregnancy, last_menstrual, expected_due) VALUES
('PM0000','C001','1','2020-01-01','2021-04-01'),
('PM0000','C001','2','2020-02-02','2021-11-01'),
('PM0000','C001','3','2020-03-03','2022-03-01'),
('PM0002','C002','1','2020-04-04','2020-05-01'),
('PM0003','C002','2','2020-05-05','2022-07-03'),
('PM0005','C005','1','2020-06-06','2022-07-02')
;