DROP DATABASE IF EXISTS TESTE;

CREATE DATABASE TESTE;

USE TESTE;

CREATE TABLE TB_USUARIO (
  USR_ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  USR_NOME VARCHAR(20) NOT NULL,
  USR_SENHA VARCHAR(50) NOT NULL,
  USR_CPF VARCHAR(25) NOT NULL,
  USR_TELEFONE VARCHAR(25),
  PRIMARY KEY (USR_ID),
  UNIQUE KEY UNI_USUARIO_NOME (USR_NOME)
);

CREATE TABLE TB_AUTORIZACAO (
  AUT_ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  AUT_NOME VARCHAR(20) NOT NULL,
  PRIMARY KEY (AUT_ID),
  UNIQUE KEY UNI_AUT_NOME (AUT_NOME)
);

CREATE TABLE TB_USUARIO_AUTORIZACAO (
  USR_ID BIGINT UNSIGNED NOT NULL,
  AUT_ID BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (USR_ID, AUT_ID),
  FOREIGN KEY AUT_USUARIO_FK (USR_ID) REFERENCES TB_USUARIO (USR_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY AUT_AUTORIZACAO_FK (AUT_ID) REFERENCES TB_AUTORIZACAO (AUT_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE TB_CARRO (
  CAR_ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  CAR_NOME VARCHAR(100) NOT NULL,
  CAR_KM VARCHAR(500) NOT NULL,
  CAR_CATEGORIA VARCHAR(20),
  CAR_MODELO VARCHAR(20),
  CAR_ANO INT(4),
  CAR_FABRICANTE VARCHAR(20),
  CAR_COR VARCHAR(20),
  CAR_DISPONIVEL BOOLEAN,
  PRIMARY KEY (CAR_ID)
);





INSERT INTO TB_USUARIO(USR_NOME, USR_SENHA, USR_CPF) VALUES('teste', CONCAT('{MD5}', MD5('teste')), '123123123123');
INSERT INTO TB_USUARIO(USR_NOME, USR_SENHA, USR_CPF) VALUES('admin', CONCAT('{MD5}', MD5('admin')), '123123123123');
INSERT INTO TB_AUTORIZACAO(AUT_NOME) VALUES('ROLE_USUARIO');
INSERT INTO TB_AUTORIZACAO(AUT_NOME) VALUES('ROLE_ADMIN');
INSERT INTO TB_USUARIO_AUTORIZACAO(USR_ID, AUT_ID)
SELECT USR_ID, AUT_ID
FROM TB_USUARIO, TB_AUTORIZACAO
WHERE USR_NOME = 'teste'
AND AUT_NOME = 'ROLE_USUARIO';
INSERT INTO TB_USUARIO_AUTORIZACAO(USR_ID, AUT_ID)
SELECT USR_ID, AUT_ID
FROM TB_USUARIO, TB_AUTORIZACAO
WHERE USR_NOME = 'admin';