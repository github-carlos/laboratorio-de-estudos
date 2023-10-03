CREATE TABLE Clients(
  id varchar(255),
  name varchar(255),
  email varchar(255),
  created_at date
);
CREATE TABLE Accounts(
  id varchar(255),
  client_id varchar(255),
  balance int,
  created_at date
);
CREATE TABLE Transactions(
  id varchar(255),
  account_id_from varchar(255),
  account_id_to varchar(255),
  amount int,
  created_at date
);

INSERT INTO Clients (id, name, email, created_at)
VALUES ("abcd", "Carlos Eduardo", "carlos@email.com", now());
INSERT INTO Accounts (id, client_id, balance, created_at)
VALUES ("7637aa59-f257-4c50-af91-96b9bcd84c0b", "abcd", 999999, now());
INSERT INTO Clients (id, name, email, created_at)
VALUES ("efgh", "José Rodrigues", "josé@email.com", now());
INSERT INTO Accounts (id, client_id, balance, created_at)
VALUES ("f22297c6-424f-4c4e-b32e-2eef3c6f8500", "efgh", 999999, now());