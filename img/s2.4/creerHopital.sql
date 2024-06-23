-- Cas    : ( HLSMPC )
-- Auteur : CAUVIN Pierre, CAZO Joey, GUELLE Clément
-- Date   : lun. 13 mai
-- Objectif : Création de la base de donnée


-- Suppression des tables

drop table if exists HOPITAL cascade;
drop table if exists LABORATOIRE cascade;
drop table if exists SERVICE cascade;
drop table if exists MEDECIN cascade;
drop table if exists PATIENT cascade;
drop table if exists CONSULTE cascade;


------------------------------------------------------------------------------------------------------------------------


-- Création des tables

create table HOPITAL
(
    idHop       SERIAL primary key,
    nom_hop     varchar(50),
    adresse_hop varchar(100),
    tel_hop     varchar(10) check (length(tel_hop) = 10)
);

create table LABORATOIRE
(
    idLab   SERIAL primary key,
    nom_lab varchar(19),
    idHop   integer references HOPITAL (idHop)
);

create table SERVICE
(
    idServ   SERIAL primary key,
    nom_serv varchar(50),
    nb_lits  integer check (nb_lits > 0),
    idHop    integer references HOPITAL (idHop)
);

create table MEDECIN
(
    idMed    SERIAL primary key,
    nom_med  varchar(50),
    mail_med varchar(100),
    spec     varchar(18),
    fct      varchar(10) check (fct in ('CONSULTANT', 'CHERCHEUR', 'PRATICIEN')),
    idLab    integer references LABORATOIRE (idLab),
    idServ   integer references SERVICE (idServ),
    idHop    integer references HOPITAL (idHop)
);

create table PATIENT
(
    idPat       SERIAL primary key,
    nom_pat     varchar(50),
    prenom_pat  varchar(50),
    adresse_pat varchar(100),
    date_nais   date
);

create table CONSULTE
(
    idPat        integer references PATIENT (idPat),
    idMed        integer references MEDECIN (idMed),
    date_consult date,
    primary key (idPat, idMed, date_consult)
);

