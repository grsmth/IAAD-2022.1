begin;
create schema startup;
use startup;

create table startup(
id_startup CHAR(5) NOT NULL, 
nome_startup VARCHAR(21) NOT NULL,
cidade_sede VARCHAR(30) NOT NULL
);

create table programador(
id_programador CHAR(5) NOT NULL,
id_startup CHAR(5) REFERENCES startup(id_startup) ON UPDATE CASCADE,
nome_programador VARCHAR(22),
genero CHAR(1),
data_nascimento date NOT NULL,
email VARCHAR(30) unique NOT NULL,
PRIMARY KEY (id_programador)
);

create table linguagem_programacao(
id_linguagem CHAR(5) NOT NULL,
nome_linguagem VARCHAR(15) NOT NULL,
ano_lancamento CHAR(4) NOT NULL,
PRIMARY KEY (id_linguagem)
);

create table programador_linguagem(
id_programador CHAR(5) NOT NULL,
id_linguagem CHAR(5)
);

insert into startup values
('10001','Tech4Toy','Porto Alegre'),
('10002','Smart123','Belo Horizonte'),
('10003','knowledgeUp','Rio de Janeiro'),
('10004','BSI Next Level','Recife'),
('10005','QualiHealth','São Paulo'),
('10006','ProEdu','Florianópolis');

insert into programador values
('30001','10001','João Pedro','M','1993-06-23','joaop@mail.com'),
('30002','10042','Paula Silva','F','1986-01-10','paulas@mail.com'),
('30003','10003','Renata Vieira','F','1991-07-05','renatav@mail.com'),
('30004','10004','Felipe Santos','M','1976-11-25','felipes@mail.com'),
('30005','10001','Ana Cristina','F','1968-02-19','anac@mail.com'),
('30006','10004','Alexandre Alves','M','1988-07-07','alexandrea@mail.com'),
('30007','10002','Laura Marques','F','1987-10-04','lauram@mail.com');

insert into linguagem_programacao values
('20001','Python','1991'),
('20002','PHP','1995'),
('20003','Java','1995'),
('20004','C','1972'),
('20005','JavaScript','1995'),
('20006','Dart','2011');

insert into programador_linguagem values
('30001','20001'),
('30001','20002'),
('30002','20003'),
('30003','20004'),
('30003','20005'),
('30004','20005'),
('30007','20001'),
('30007','20002');

ALTER TABLE programador_linguagem ADD FOREIGN KEY (id_linguagem) REFERENCES linguagem_programacao(id_linguagem);
ALTER TABLE programador_linguagem ADD FOREIGN KEY (id_programador) REFERENCES programador(id_programador) ON DELETE CASCADE; 
commit;