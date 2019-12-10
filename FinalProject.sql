/*  Simran Bhamra and Anthony Hessler
    CS360- Database Analyisis & Design
    Final Project - Wellness Clinic
*/

--droppping and creating tables
drop table staff cascade constraints; 
create table staff(
    staffID     varchar(6) not null constraint staffID_pk primary key,
    staffType   char(3) 
);

drop table physician cascade constraints; 
create table physician(
    docLicNum       number(10) not null constraint docLicNum_pk primary key,
    email           varchar(20),
    telephone       number(10),
    staffID         varchar (6),
    constraint fk_staffID_d foreign key(staffID) 
    references staff(staffID)
);

drop table rNurse cascade constraints; 
create table rNurse(
    rnLicNum    number(10) not null constraint rnLicNum_pk primary key,
    staffID     varchar (6),
    constraint fk_staffID_rn foreign key(staffID) 
    references staff(staffID)
);

drop table npNurse cascade constraints;
create table npNurse(
    npLicNum    number(10) not null constraint npLicNum_pk primary key,
    staffID     varchar (6),
    constraint fk_staffID_np foreign key(staffID) 
    references staff(staffID)
);

drop table medTech cascade constraints;
create table medTech(
    medTechLicNum   number(10) not null constraint medTechLicNum_pk primary key,
    staffID         varchar (6),
    constraint fk_staffID_mt foreign key(staffID) 
    references staff(staffID)
);

drop table pharma cascade constraints;
create table pharma (
    pharmaLicNum    number(10) not null constraint pharmaTechLicNum_pk primary key,
    staffID         varchar (6),
    constraint fk_staffID_ph foreign key(staffID) 
    references staff(staffID)
);

drop table surgeon cascade constraints;
create table surgeon(
    surgeonLicNum   number(10) not null constraint surgeonLicNum_pk primary key,
    staffID         varchar (6),
    constraint fk_staffID_su foreign key(staffID) 
    references staff(staffID)
);

drop table reception cascade constraints;
create table reception(
    receptionID     number(10) not null constraint receptionID_pk primary key,
    staffID         varchar (6),
    constraint fk_staffID_recp foreign key(staffID) 
    references staff(staffID)
);

drop table bookKeep cascade constraints;
create table bookKeep(
    bookKeepID    number(10) not null constraint bookKeepID_pk primary key,
    staffID       varchar (6),
    constraint fk_staffID_bk foreign key(staffID) 
    references staff(staffID)
);

drop table officeAdmin cascade constraints;
create table officeAdmin(
    officeAdminID   number(10) not null constraint officeAdmin_pk primary key,
    staffID         varchar (6),
    constraint fk_staffID_oa foreign key(staffID) 
    references staff(staffID)
);

drop table patient cascade constraints;
create table patient(
    patientID       varchar(6) not null constraint patientID_pk primary key,
    patientName     varchar(50),
    abillityToPay   char(3),
    visitNo         number(3)
);

drop table diagnosis cascade constraints;
create table diagnosis(
    diagnosisID    varchar(6) not null constraint diagnosis_pk primary key,
    descrip        varchar(50),
    patientID      varchar(6),
    constraint fk_patientID_di  foreign key(patientID)
    references patient(patientID)
);

drop table visit cascade constraints;
create table visit(
    visitID         varchar(6) not null constraint visitID_pk primary key,
    visitType       varchar(20),
    diagnosisID     varchar(6),
    constraint fk_diagnosisID_vi foreign key(diagnosisID)
    references diagnosis(diagnosisID),
    patientID       varchar(6),
    constraint fk_patientID_vi  foreign key(patientID)
    references patient(patientID),
    docLicNum       number(10),
    constraint fk_docLicNum_vi foreign key(docLicNum)
    references physician(docLicNum)
);
    
    
drop table bill cascade constraints;
create table bill(
    billID      varchar(10) not null constraint billID_pk primary key,
    amount      number(7,2),
    payDate     date,
    payType     char(3),
    patientID   varchar(6),
    constraint fk_patientID_bi  foreign key(patientID)
    references patient(patientID),
    bookKeepID  number(10),
    constraint fk_bookKeepID_bi foreign key (bookKeepID)
    references bookKeep(bookKeepID)
);
    
drop table prescription cascade constraints;
create table prescription(
     drug        varchar(20)not null constraint drug_pk primary key,
    patientID   varchar(6),
    constraint fk_patientID_pr  foreign key(patientID)
    references patient(patientID),
    pharmaLicNum    number(10),
    constraint fk_pharmaID_pr foreign key (pharmaLicNum)
    references pharma(pharmaLicNum),
    amount      varchar(10),
    directions  varchar(50),
    drugForm    varchar(6),
    strength    varchar(8),
    rxNumber    number(6),
    dateFilled  date,
    oDate       date
    
);
    

drop table sched cascade constraints;
create table sched(
    schedID     varchar(6)  not null constraint sched_pk primary key,
    patientID   varchar(6),
    constraint fk_patientID_sc  foreign key(patientID)
    references patient(patientID), 
    apptType        varchar(20),
    apptDate        date,
    staffID         varchar(6),
    constraint fk_staffID_sc foreign key(staffID) 
    references staff(staffID)
);


drop table operatingRoomSch cascade constraints;
create table operatingroomsch(
    surgeryID       number(4) not null constraint oroomsch_pk primary key,
    surgerydate     date,
    surgerydescription     varchar(20),
    patientID       varchar(6),
    constraint fk_patientID_ors foreign key(patientID)
    references patient(patientID),
    
    surgeonLicNum number(10),
    constraint fk_surgeonLicNum_ors foreign key (surgeonLicNum)
    references surgeon(surgeonLicNum)
);

drop table operatingroomlog cascade constraints;
create table operatingroomlog (
    surgeryRoom     number(2) not null constraint surgeryRoom_pk primary key, 
    surgeryID       number(4) , 
    surgerydescription         varchar(20),
    sDateTimeOR       date,  
    patientID       varchar(6),
    constraint fk_patientID_orl foreign key(patientID)
    references patient(patientID),
    
    surgeonLicNum number(10),
    constraint fk_surgeonLicNum_orl foreign key (surgeonLicNum)
    references surgeon(surgeonLicNum),
    
    rnLicNum    number(10),
    constraint  fk_rnLicNum_orl foreign key(rnLicNum)
    references rNurse(rnLicNum),
    
    npLicNum    number(10),
    constraint  fk_npLicNum_orl foreign key(npLicNum)
    references npNurse(npLicNum),
    
    observations        varchar(200)
);

drop table dRoom cascade constraints;
create table dRoom (
    roomID      number(2) not null constraint droom_pk primary key,
     patientID       varchar(6),
    constraint fk_patientID_dr foreign key(patientID)
    references patient(patientID),
    delDate     date
);


drop table recRoom cascade constraints;
create table recRoom(
    recRoomID       number(2) not null constraint recroom_pk primary key,
    bedID           number(3),
    dateIn          date,
    dateOut         date,
    signPrac        varchar(50),
    checkupDes      varchar(200),
    patientID       varchar(6),
    constraint fk_patientID_rr foreign key(patientID)
    references patient(patientID),
    npLicNum    number(10),
    constraint  fk_npLicNum_rr foreign key(npLicNum)
    references npNurse(npLicNum)
    
); 

drop table monthlyReport cascade constraints;
create table monthlyReport(
    monthYear       char(7) not null constraint report_pk primary key,
    totalVisits     number(4),
    totalSurgery    number(4),
    totalDel         number(4),
    totalDrugs       number(4),
    avgTime          varchar(10)
);


--loading values into tables
insert into staff values ('A12345', 'PHY');
insert into staff values ('A23456', 'PHY');
insert into staff values ('I12345','RN');
insert into staff values('I23456','RN');
insert into staff values ('B12345','NP');
insert into staff values('B23456','NP');
insert into staff values('C12345' ,'MT');
insert into staff values('C23456','MT');
insert into staff values('D12345','PHR');
insert into staff values('D23456','PHR');
insert into staff values('E12345','SUG');
insert into staff values('E23456','SUG');
insert into staff values('F12345','BK');
insert into staff values('F23456','BK');
insert into staff values('G12345','REC');
insert into staff values('G23456','REC');
insert into staff values('H12345','OA');
insert into staff values('H23456','OA');

insert into physician values(1234567891,'eh9988@gmail.com',7217159984, 'A12345');
insert into physician values (2345678912,'ah8768@gmail.com',876172566, 'A23456');

insert into rNurse values(3456789123,'I12345');
insert into rNurse values (5678901234, 'I23456');

insert into npNurse values (3958672349, 'B12345');
insert into npNurse values(4859681230,'B23456');

insert into medTech values (0923899874, 'C12345');
insert into medTech values(3345900921, 'C23456');

insert into pharma values (2233111893, 'D12345');
insert into pharma values(2230099831,'D23456');

insert into surgeon values(2223987734,'E12345');
insert into surgeon values(2299330087,'E23456');

insert into reception values(2299008863,'G12345');
insert into reception values(8877440834,'G23456');

insert into bookKeep values(4510983450,'F12345');
insert into bookKeep values(4540983409,'F23456');

insert into officeAdmin values(4247755090,'H12345');
insert into officeAdmin values(8844509349, 'H23456');

insert into patient values('AB1234','Benjamin', 'OOP',4);
insert into patient values ('AB3456', 'Lily','INS',2);

insert into diagnosis values('C12345','sore throat','AB1234');
insert into diagnosis values('C23456','sprained ankle','AB3456');

insert into visit values('GH1234','Delivery', 'C12345','AB1234',1234567891);
insert into visit values('GH2345','Surgery', 'C23456','AB3456',2345678912);

insert into bill values(4325667744,200.10, '19-NOV-12','DBC','AB1234',4510983450);
insert into bill values(4455000912,0.0, '19-DEC-12', 'INS','AB3456',4510983450);

insert into prescription values('cought syrup','AB1234',2233111893, '250ml','Take twice a day','liquid','strong',876345,'12-NOV-19','10-NOV-19');
insert into prescription values('nothing - rice','AB3456',2230099831,'0g','Everyday for 3 hours','action','strong',000000,'25-NOV-19','20-NOV-19');

insert into sched values('SCH786','AB1234','online', '19-NOV-12','A12345');
insert into sched values('SCH345','AB3456','office 1','21-DEC-19','B12345');

insert into operatingroomsch values(5824, sysdate,'Appendectomy','AB1234',2223987734);

insert into operatingroomlog values(02, 5824, 'Appendectomy', sysdate, 'AB1234', 2223987734, 3456789123, 3958672349, 'Incredibly simple procedure');

insert into droom values(03, 'AB3456', sysdate);

insert into recroom values(04, 106, sysdate, '10-DEC-2019', 'Dr. Gupta', 'No medical checks performed', 'AB1234', 4859681230);

insert into monthlyreport values('NOV2019', 27, 2, 6, 18, '1d 3h 45m');

--Queries

--Operating Room Schedule
select *
from operatingroomsch;

--Operating Room Log (INCOMPLETE)
select *
from operatingroomlog;

--Daily Delivery Room Log 
select *
from droom;

-- Recovery Room Log (INCOMPLETE)
select *
from recroom;

-- Monthly Activity Report
select *
from monthlyreport;

--Triggers

set serveroutput on; 

drop table changelog;

create table changelog(
    change_date        date,
    chnage_desc        varchar2(50)
);

--trigger to update patient
create or replace trigger patient_update
    after update on patient
    for each row
declare
    v_action        varchar2(50);
begin 
    v_action := 'Updated patient on ' || to_char (sysdate, 'YYYY/MM/DD');
    insert into changelog values (sysdate, v_action);

end; 

--update patient name
update patient
set patientName = 'Lily Dog'
where patientName = 'Lily'; 

--Triggers to insert data into the staff table

create or replace trigger insert_physician
after insert on physician
for each row
declare
    v_staffid physician.staffid%type;
    v_action varchar2(50);
begin
    v_staffid := :new.staffid;
    insert into staff values(v_staffid, 'PHY');
end;
/

create or replace trigger insert_rNurse
after insert on rnurse
for each row
declare
    v_staffid rnurse.staffid%type;
    v_action varchar2(50);
begin
    v_staffid := :new.staffid;
    insert into staff values(v_staffid, 'RN');
end;
/

create or replace trigger insert_npNurse
after insert on npnurse
for each row
declare
    v_staffid npnurse.staffid%type;
    v_action varchar2(50);
begin
    v_staffid := :new.staffid;
    insert into staff values(v_staffid, 'NP');
end;
/

create or replace trigger insert_medTech
after insert on medtech
for each row
declare
    v_staffid medtech.staffid%type;
    v_action varchar2(50);
begin
    v_staffid := :new.staffid;
    insert into staff values(v_staffid, 'MT');
end;
/

create or replace trigger insert_pharma
after insert on pharma
for each row
declare
    v_staffid pharma.staffid%type;
    v_action varchar2(50);
begin
    v_staffid := :new.staffid;
    insert into staff values(v_staffid, 'PHR');
end;
/

create or replace trigger insert_surgeon
after insert on surgeon
for each row
declare
    v_staffid surgeon.staffid%type;
    v_action varchar2(50);
begin
    v_staffid := :new.staffid;
    insert into staff values(v_staffid, 'SUG');
end;
/

create or replace trigger insert_reception
after insert on reception
for each row
declare
    v_staffid reception.staffid%type;
    v_action varchar2(50);
begin
    v_staffid := :new.staffid;
    insert into staff values(v_staffid, 'REC');
end;
/

create or replace trigger insert_bookkeep
after insert on bookkeep
for each row
declare
    v_staffid bookkeep.staffid%type;
    v_action varchar2(50);
begin
    v_staffid := :new.staffid;
    insert into staff values(v_staffid, 'BK');
end;
/

create or replace trigger insert_officeadmin
after insert on officeadmin
for each row
declare
    v_staffid officeadmin.staffid%type;
    v_action varchar2(50);
begin
    v_staffid := :new.staffid;
    insert into staff values(v_staffid, 'OA');
end;
/

insert into officeAdmin values(6378391875, 'H98765');

--procedures 
--2 procedures with cursors  
create or replace procedure list_patient
is
    p_patientID     varchar(6);
    p_patientName   varchar(50); 
    cursor patient_cur is 
        select patientID, patientName from patient order by patientID; 
begin
    open patient_cur;
     dbms_output.put_line('Patient ID          Patient Name'); 
     dbms_output.put_line('--------------------------------');
    loop
        fetch patient_cur into p_patientID, p_patientName;
        exit when patient_cur%notfound; 
        dbms_output.put_line(p_patientID || '  '|| p_patientName ); 
    end loop;
    close patient_cur; 
end; 
/

create or replace procedure list_physician
is
  ph_physicianid          physician.doclicnum%type;
  ph_email                physician.email%type;
  ph_telephone            physician.telephone%type;
  ph_staffid              physician.staffid%type;

  cursor physician_cursor is  -- declaring a cursor
    select doclicnum,
           email,
           telephone,
           staffid
    from   physician;

begin
  open physician_cursor;    -- opening the cursor
  loop
    fetch physician_cursor  -- fetching records from the cursor
    into  
        ph_physicianid,      
        ph_email,       
        ph_telephone,
        ph_staffid;
    exit
  when physician_cursor%notfound;
  dbms_output.put_line('physician not found');

  end loop;
  close physician_cursor;  --closing the cursor
end;
/


--2 procedures without cursors
create or replace procedure select_prescription (
    p_rxNumber            in number
)
is 
    v_drug                  prescription.drug%type;
    v_patientID             prescription.patientID%type;
    v_pharmaLicNum          prescription.pharmaLicNum%type;
    v_amount                prescription.amount%type;
    v_directions            prescription.directions%type;
    v_drugForm              prescription.drugForm%type;
    v_strength              prescription.strength%type;
    v_dateFilled            prescription.dateFilled%type;
    v_oDate                 prescription.oDate%type;
begin
    select drug,patientID, pharmaLicNum,amount,directions,drugForm,strength,dateFilled, oDate
    into v_drug,v_patientID, v_pharmaLicNum,v_amount,v_directions,v_drugForm,v_strength,v_dateFilled, v_oDate
    from prescription 
    where rxNumber = p_rxNumber;
   DBMS_OUTPUT.PUT_LINE('Drug           :' || v_drug);
   DBMS_OUTPUT.PUT_LINE('Patient ID     :'|| v_patientID);
   DBMS_OUTPUT.PUT_LINE('Pharmacist     :'|| v_pharmaLicNum);
   DBMS_OUTPUT.PUT_LINE('Quantitiy      :'|| v_amount);
   DBMS_OUTPUT.PUT_LINE('Directions     :'|| v_directions);
   DBMS_OUTPUT.PUT_LINE('Drug form      :'|| v_drugForm);
   DBMS_OUTPUT.PUT_LINE('Strength       :'||v_strength);
   DBMS_OUTPUT.PUT_LINE('Date Filled    :'||v_dateFilled);
   DBMS_OUTPUT.PUT_LINE('Original Date  :'||v_oDate);
exception
    when no_data_found then
         DBMS_OUTPUT.PUT_LINE('Drug' || v_drug || ' not found');
end;
/

create or replace procedure select_visit (p_visitid in varchar)
is
    v_type          visit.visittype%type;
    v_diagnosis     visit.diagnosisid%type;
    v_patient       visit.patientid%type;
    v_physician     visit.doclicnum%type;
begin
    select visittype, diagnosisid, patientid, doclicnum
    into v_type, v_diagnosis, v_patient, v_physician
    from visit
    where visitid = p_visitid;
    
    dbms_output.put_line('Visit ID:     ' || p_visitid);
    dbms_output.put_line('Visit Type:     ' || v_type);
    dbms_output.put_line('Diagnosis ID:     ' || v_diagnosis);
    dbms_output.put_line('Patient ID:     ' || v_patient);
    dbms_output.put_line('Physician ID:     ' || v_physician);
exception
    when no_data_found then
         DBMS_OUTPUT.PUT_LINE('Visit' || p_visitid || ' not found');
end;
/