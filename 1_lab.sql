CREATE
DATABASE lab1;
CREATE TABLE clients
(
    client_id   SERIAL PRIMARY KEY,
    first_name  VARCHAR(60),
    last_name   VARCHAR(60),
    email       VARCHAR(100),
    date_joined DATE
);

ALTER TABLE clients
    ADD COLUMN status INT;

ALTER TABLE clients
ALTER COLUMN status TYPE BOOLEAN USING status::BOOLEAN;

ALTER TABLE clients
    ALTER COLUMN status SET DEFAULT TRUE;

CREATE TABLE orders
(
    order_id   SERIAL PRIMARY KEY,
    order_name VARCHAR(100),
    client_id  INT REFERENCES clients (client_id)
);

DROP TABLE orders;
DROP DATABASE lab1;