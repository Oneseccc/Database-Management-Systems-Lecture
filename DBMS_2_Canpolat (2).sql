/*==============================================================*/
/* DBMS name:      ORACLE Version 19c                           */
/* Created on:     18-06-2023 23:47:39                          */
/*==============================================================*/


alter table CLASSROOM
   drop constraint FK_CLASSROO_CLASSROOM_COURSE;

alter table CLASSROOM
   drop constraint FK_CLASSROO_DEPARTMEN_DEPARTME;

alter table COURSE
   drop constraint FK_COURSE_DEPARTMEN_DEPARTME;

alter table COURSE_PROFESSOR
   drop constraint FK_COURSE_P_COURSE_PR_PROFESSO;

alter table ENROLLMENT
   drop constraint FK_ENROLLME_COURSE_EN_COURSE;

alter table ENROLLMENT
   drop constraint FK_ENROLLME_STUDENT_E_STUDENTS;

alter table MAJOR
   drop constraint FK_MAJOR_DEAPRTMEN_DEPARTME;

alter table PROFESSOR
   drop constraint FK_PROFESSO_DEPARTMEN_DEPARTME;

alter table STUDENTS
   drop constraint FK_STUDENTS_STUDENTS__MAJOR;

drop index CLASSROOM_COURSE_FK;

drop index DEPARTMENT_CLASSROOM_FK;

drop table CLASSROOM cascade constraints;

drop index DEPARTMENT_COURSE_FK;

drop table COURSE cascade constraints;

drop index COURSE_PROFESSOR_FK;

drop table COURSE_PROFESSOR cascade constraints;

drop table DEPARTMENT cascade constraints;

drop index COURSE_ENROLLMENT_FK;

drop index STUDENT_ENROLLMENT_FK;

drop table ENROLLMENT cascade constraints;

drop index DEAPRTMENT_MAJOR_FK;

drop table MAJOR cascade constraints;

drop index DEPARTMENT_PROFESSOR_FK;

drop table PROFESSOR cascade constraints;

drop index STUDENTS_MAJOR_FK;

drop table STUDENTS cascade constraints;

/*==============================================================*/
/* Table: CLASSROOM                                             */
/*==============================================================*/
create table CLASSROOM (
   CLASSROOM_ID         VARCHAR2(5)           not null,
   DEPARTMENT_NAME      VARCHAR2(50)          not null,
   COURSE_ID            VARCHAR2(5),
   CAPACITY             INTEGER               not null,
   CLASS_BUILDING       VARCHAR2(30)          not null,
   constraint PK_CLASSROOM primary key (CLASSROOM_ID)
);

/*==============================================================*/
/* Index: DEPARTMENT_CLASSROOM_FK                               */
/*==============================================================*/
create index DEPARTMENT_CLASSROOM_FK on CLASSROOM (
   DEPARTMENT_NAME ASC
);

/*==============================================================*/
/* Index: CLASSROOM_COURSE_FK                                   */
/*==============================================================*/
create index CLASSROOM_COURSE_FK on CLASSROOM (
   COURSE_ID ASC
);

/*==============================================================*/
/* Table: COURSE                                                */
/*==============================================================*/
create table COURSE (
   COURSE_ID            VARCHAR2(5)           not null,
   DEPARTMENT_NAME      VARCHAR2(50),
   COURSE_NAME          VARCHAR2(20)          not null,
   COURSE_CREDITS       INTEGER               not null,
   constraint PK_COURSE primary key (COURSE_ID)
);

/*==============================================================*/
/* Index: DEPARTMENT_COURSE_FK                                  */
/*==============================================================*/
create index DEPARTMENT_COURSE_FK on COURSE (
   DEPARTMENT_NAME ASC
);

/*==============================================================*/
/* Table: COURSE_PROFESSOR                                      */
/*==============================================================*/
create table COURSE_PROFESSOR (
   PROFESSOR_ID         VARCHAR2(5)           not null,
   COURSE_ID            VARCHAR2(5)           not null,
   constraint PK_COURSE_PROFESSOR primary key (PROFESSOR_ID, COURSE_ID)
);

/*==============================================================*/
/* Index: COURSE_PROFESSOR_FK                                   */
/*==============================================================*/
create index COURSE_PROFESSOR_FK on COURSE_PROFESSOR (
   PROFESSOR_ID ASC
);

/*==============================================================*/
/* Table: DEPARTMENT                                            */
/*==============================================================*/
create table DEPARTMENT (
   DEPARTMENT_NAME      VARCHAR2(50)          not null,
   BUILDING             VARCHAR2(100)         not null,
   constraint PK_DEPARTMENT primary key (DEPARTMENT_NAME)
);

/*==============================================================*/
/* Table: ENROLLMENT                                            */
/*==============================================================*/
create table ENROLLMENT (
   GRADE                FLOAT                 not null,
   ENROLLMENT_ID        VARCHAR2(5)           not null,
   STUDENTID            VARCHAR2(5)           not null,
   COURSE_ID            VARCHAR2(5)           not null,
   constraint PK_ENROLLMENT primary key (ENROLLMENT_ID)
);

/*==============================================================*/
/* Index: STUDENT_ENROLLMENT_FK                                 */
/*==============================================================*/
create index STUDENT_ENROLLMENT_FK on ENROLLMENT (
   STUDENTID ASC
);

/*==============================================================*/
/* Index: COURSE_ENROLLMENT_FK                                  */
/*==============================================================*/
create index COURSE_ENROLLMENT_FK on ENROLLMENT (
   COURSE_ID ASC
);

/*==============================================================*/
/* Table: MAJOR                                                 */
/*==============================================================*/
create table MAJOR (
   MAJOR_NAME           VARCHAR2(30)          not null,
   DEPARTMENT_NAME      VARCHAR2(50)          not null,
   constraint PK_MAJOR primary key (MAJOR_NAME)
);

/*==============================================================*/
/* Index: DEAPRTMENT_MAJOR_FK                                   */
/*==============================================================*/
create index DEAPRTMENT_MAJOR_FK on MAJOR (
   DEPARTMENT_NAME ASC
);

/*==============================================================*/
/* Table: PROFESSOR                                             */
/*==============================================================*/
create table PROFESSOR (
   PROFESSOR_ID         VARCHAR2(5)           not null,
   DEPARTMENT_NAME      VARCHAR2(50)          not null,
   PROFESSOR_FIRST_NAME VARCHAR2(20)          not null,
   PROFESSOR_LAST_NAME  VARCHAR2(20)          not null,
   PROFESSOR_HIRE_DATE  DATE                  not null,
   constraint PK_PROFESSOR primary key (PROFESSOR_ID)
);

/*==============================================================*/
/* Index: DEPARTMENT_PROFESSOR_FK                               */
/*==============================================================*/
create index DEPARTMENT_PROFESSOR_FK on PROFESSOR (
   DEPARTMENT_NAME ASC
);

/*==============================================================*/
/* Table: STUDENTS                                              */
/*==============================================================*/
create table STUDENTS (
   STUDENTID            VARCHAR2(5)           not null,
   MAJOR_NAME           VARCHAR2(30),
   STUDENTFIRSTNAME     VARCHAR2(20)          not null,
   STUDENTLASTNAME      VARCHAR2(20)          not null,
   STUDENT_DATE_OF_BIRTH DATE                  not null,
   constraint PK_STUDENTS primary key (STUDENTID)
);

/*==============================================================*/
/* Index: STUDENTS_MAJOR_FK                                     */
/*==============================================================*/
create index STUDENTS_MAJOR_FK on STUDENTS (
   MAJOR_NAME ASC
);

alter table CLASSROOM
   add constraint FK_CLASSROO_CLASSROOM_COURSE foreign key (COURSE_ID)
      references COURSE (COURSE_ID);

alter table CLASSROOM
   add constraint FK_CLASSROO_DEPARTMEN_DEPARTME foreign key (DEPARTMENT_NAME)
      references DEPARTMENT (DEPARTMENT_NAME);

alter table COURSE
   add constraint FK_COURSE_DEPARTMEN_DEPARTME foreign key (DEPARTMENT_NAME)
      references DEPARTMENT (DEPARTMENT_NAME);

alter table COURSE_PROFESSOR
   add constraint FK_COURSE_P_COURSE_PR_PROFESSO foreign key (PROFESSOR_ID)
      references PROFESSOR (PROFESSOR_ID);

alter table ENROLLMENT
   add constraint FK_ENROLLME_COURSE_EN_COURSE foreign key (COURSE_ID)
      references COURSE (COURSE_ID);

alter table ENROLLMENT
   add constraint FK_ENROLLME_STUDENT_E_STUDENTS foreign key (STUDENTID)
      references STUDENTS (STUDENTID);

alter table MAJOR
   add constraint FK_MAJOR_DEAPRTMEN_DEPARTME foreign key (DEPARTMENT_NAME)
      references DEPARTMENT (DEPARTMENT_NAME);

alter table PROFESSOR
   add constraint FK_PROFESSO_DEPARTMEN_DEPARTME foreign key (DEPARTMENT_NAME)
      references DEPARTMENT (DEPARTMENT_NAME);

alter table STUDENTS
   add constraint FK_STUDENTS_STUDENTS__MAJOR foreign key (MAJOR_NAME)
      references MAJOR (MAJOR_NAME);

