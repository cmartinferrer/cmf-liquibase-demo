--liquibase formatted sql

--changeset user:1
INSERT INTO motorbike VALUES (1, 'BMW', 'F800GS');
--rollback DELETE FROM motorbike WHERE id = 1;
