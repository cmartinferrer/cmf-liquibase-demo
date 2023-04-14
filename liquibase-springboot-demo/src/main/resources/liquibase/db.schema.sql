--liquibase formatted sql

--changeset user:1
CREATE TABLE motorbike (
   id int,
   brand varchar(255),
   model varchar(255)
);
--rollback drop table motorbike;
