--liquibase formatted sql

--changeset user:1
INSERT INTO motorbike VALUES (1, 'BMW', 'F800GS');
INSERT INTO motorbike VALUES (2, 'BMW', 'R1250GS');
--rollback DELETE FROM motorbike WHERE id in (1,2);
