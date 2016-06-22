CREATE TABLE Rotulo(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),

	temperatura_minima int,
	temperatura_maxima int,
	teor_alcoolico double,

	estilo_cod int not null,
	cervejaria_cod int not null,
	pais_origem_cod int not null,

	constraint estilo_cod_fk foreign key(estilo_cod) references Estilo(codigo),
	constraint cervejaria_cod_fk foreign key(cervejaria_cod) references Cervejaria(codigo),
	constraint pais_origem_cod_fk foreign key(pais_origem_cod) references Pais(codigo)
);

CREATE TABLE Estilo(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(128) not null UNIQUE,
	descricao varchar(1024)
);

CREATE TABLE Ingrediente(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Cervejaria(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Pais(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Estabelecimento(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Pessoa(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(128) not null UNIQUE,
	telefone varchar(20)
);

CREATE TABLE Funcao(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Tipo_Comida(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Endereco(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	cep int default 00000000,
	rua varchar(64) not null,
	cidade_cod int not null,

	constraint cidade_cod_fk foreign key(cidade_cod) references Cidade(codigo)
);

CREATE TABLE Cidade(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(128),
	estado_cod int not null,

	constraint estado_cod_fk foreign key(estado_cod) references Estado(codigo)
);

CREATE TABLE Estado(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(64) not null UNIQUE
);

CREATE TABLE HorarioFuncionamento(
	abertura time not null,
	fechamento time not null,
	dia_cod int,

	primary key (abertura, fechamento),
	constraint dia_cod_fk foreign key(dia_cod) references Dia(codigo)
);

CREATE TABLE Dia(
	codigo int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(32) not null UNIQUE
);


CREATE TABLE Rotulo_Ingrediente(
	rotulo_codigo int,
	ingrediente_cod int,

	constraint rotulo_codigo_fk foreign key(rotulo_codigo) references Rotulo(codigo),
	constraint ingrediente_cod_fk foreign key(ingrediente_cod) references Ingrediente(codigo),
	constraint rotulo_ingrediente_pk primary key (rotulo_codigo, ingrediente_cod)
);

CREATE TABLE Rotulo_Pais_Producao(
	rotulo_codigo int,
	pais_cod int,

	constraint rotulo_codigo_fk foreign key(rotulo_codigo) references Rotulo(codigo),
	constraint pais_cod_fk foreign key(pais_cod) references Pais(codigo),
	constraint rotulo_pais_producao_pk primary key (rotulo_codigo, pais_cod)
);


CREATE TABLE Rotulo_Estabelecimento(
	rotulo_codigo int,
	estabelecimento_cod int,

	constraint rotulo_codigo_fk foreign key (rotulo_codigo) references Rotulo(codigo),
	constraint estabelecimento_cod_fk foreign key (estabelecimento_cod) references Estabelecimento(codigo),
	constraint rotulo_estabelecimento_pk primary key (rotulo_codigo, estabelecimento_cod)
);

CREATE TABLE Propriedade(
	estabelecimento_cod int,
	pessoa_cod int,

	constraint estabelecimento_cod_fk foreign key (estabelecimento_cod) references Estabelecimento(codigo),
	constraint pessoa_cod_fk foreign key(pessoa_cod) references Pessoa(codigo),
	constraint propriedade_pk primary key (estabelecimento_cod, pessoa_cod)
);

CREATE TABLE Pessoa_Funcao(
	pessoa_cod int,
	funcao_cod int,

	constraint pessoa_cod_fk foreign key(pessoa_cod) references Pessoa(codigo),
	constraint funcao_cod_fk foreign key(funcao_cod) references Funcao(codigo),
	constraint pessoa_funcao_pk primary key (pessoa_cod, funcao_cod)
);

CREATE TABLE Trabalha(
	estabelecimento_cod int,
	pessoa_cod int,
	funcao_cod int,

	constraint estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint pessoa_cod_fk foreign key(pessoa_cod) references Pessoa(codigo),
	constraint funcao_cod_fk foreign key(funcao_cod) references Funcao(codigo),
	constraint trabalha_pk primary key (estabelecimento_cod, pessoa_cod, funcao_cod)
);

CREATE TABLE Estabelecimento_TipoComida(
	estabelecimento_cod int,
	tipo_comida_cod int,

	constraint estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint tipo_comida_cod_fk foreign key(tipo_comida_cod) references Tipo_Comida(codigo),
	constraint estabelecimento_tipo_comida_pk primary key (estabelecimento_cod, tipo_comida_cod)
);

CREATE TABLE Estabelecimento_HorarioFuncionamento(
	estabelecimento_cod int,
	horariofuncionamento_abertura time,
	horariofuncionamento_fechamento time,

	constraint estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint horariofuncionamento_fk foreign key(horariofuncionamento_abertura, horariofuncionamento_fechamento) references HorarioFuncionamento(abertura, fechamento)
	constraint estabelecimento_horario_funcionamento_pk primary key (estabelecimento_cod, horariofuncionamento_abertura, horariofuncionamento_fechamento)
);

CREATE TABLE Estabelecimento_Endereco(
	estabelecimento_cod int,
	endereco_cod int,

	constraint estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint endereco_cod_fk foreign key(endereco_cod) references Endereco(codigo),
	constraint estabelecimento_endereco_pk primary key (estabelecimento_cod, endereco_cod)
);



-- --------------------------------------------- INSERTS ----------------------------------------------------

INSERT INTO Pessoa(nome, telefone) values ('Capelão', '21945851208');
INSERT INTO Pessoa(nome, telefone) values ('Zé', '31974421564');
INSERT INTO Pessoa(nome, telefone) values ('José', '21971181380');
INSERT INTO Pessoa(nome, telefone) values ('Wesley', '21920158750');

INSERT INTO Estabelecimento(nome) values ('Bar do Capelão');
INSERT INTO Estabelecimento(nome) values ('Bar dos Zé');
INSERT INTO Estabelecimento(nome) values ('Bar Sem Nome');

INSERT INTO Funcao (nome) values ('Garçom');
INSERT INTO Funcao (nome) values ('Gerente');

INSERT INTO Propriedade(pessoa_cod, estabelecimento_cod) values ((
	SELECT p.codigo from Pessoa p where p.nome = 'Capelão'
),(
	SELECT e.codigo from Estabelecimento e where e.nome = 'Bar do Capelão'
));

INSERT INTO Propriedade(pessoa_cod, estabelecimento_cod) values ((
	SELECT p.codigo from Pessoa p where p.nome = 'Zé'
),(
	SELECT e.codigo from Estabelecimento e where e.nome = 'Bar dos Zé'
));

INSERT INTO Propriedade(pessoa_cod, estabelecimento_cod) values ((
	SELECT p.codigo from Pessoa p where p.nome = 'José'
),(
	SELECT e.codigo from Estabelecimento e where e.nome = 'Bar dos Zé'
));

INSERT INTO Pessoa_Funcao(pessoa_cod, funcao_cod) values ((
	SELECT p.codigo from Pessoa p where p.nome = 'José'
),(
	SELECT f.codigo from Funcao f where f.nome = 'Gerente'
));

INSERT INTO Pessoa_Funcao(pessoa_cod, funcao_cod) values ((
	SELECT p.codigo from Pessoa p where p.nome = 'Zé'
),(
	SELECT f.codigo from Funcao f where f.nome = 'Gerente'
));

INSERT INTO Pessoa_Funcao(pessoa_cod, funcao_cod) values ((
	SELECT p.codigo from Pessoa p where p.nome = 'Wesley'
),(
	SELECT f.codigo from Funcao f where f.nome = 'Garçom'
));

INSERT INTO Estado (nome) values ('Rio de Janeiro');
INSERT INTO Estado (nome) values ('São Paulo');

INSERT INTO Cidade (nome, estado_cod) values('Rio de Janeiro', (SELECT e.codigo from Estado e where e.nome = 'Rio de Janeiro'));
INSERT INTO Cidade (nome, estado_cod) values('Angra dos Reis', (SELECT e.codigo from Estado e where e.nome = 'Rio de Janeiro'));
INSERT INTO Cidade (nome, estado_cod) values('Cabo Frio', (SELECT e.codigo from Estado e where e.nome = 'Rio de Janeiro'));

INSERT INTO Endereco (cep, rua, cidade_cod) values (21051360, 'Rua Lago Verde', (SELECT c.codigo from Cidade c where c.nome = 'Rio de Janeiro'));


-- --------------------------------------------- UPDATES ----------------------------------------------------


UPDATE Estabelecimento e set e.nome = 'Bar do Capelão V2' where e.nome = 'Bar do Capelão';

UPDATE Propriedade p set p.estabelecimento_cod = (SELECT e.codigo from Estabelecimento e where e.nome = 'Bar Sem Nome') where p.pessoa_cod = (SELECT pes.codigo from Pessoa pes where pes.nome = 'José');
UPDATE Propriedade p set p.estabelecimento_cod = (SELECT e.codigo from Estabelecimento e where e.nome = 'Bar Sem Nome') where p.pessoa_cod = (SELECT pes.codigo from Pessoa pes where pes.nome = 'Zé');

UPDATE Endereco e set e.cep = '22052360' where e.cidade_cod = (SELECT est.codigo from Estado est where est.nome = 'Rio de Janeiro');



-- --------------------------------------------- DELETES ----------------------------------------------------

DELETE FROM Propriedade where pessoa_cod = (select p.codigo from Pessoa p where p.nome = 'Capelão');
DELETE FROM Propriedade where pessoa_cod IN (
	select p.codigo from Pessoa p where p.nome = 'Capelão',
	select p.codigo from Pessoa p where p.nome = 'Wesley'
);

DELETE FROM Endereco;

-- --------------------------------------------- ALTER ----------------------------------------------------

ALTER TABLE Estabelecimento_Endereco DROP constraint endereco_cod_fk;
ALTER TABLE Estabelecimento_Endereco ADD constraint endereco_cod_fk foreign key(endereco_cod) references Endereco(codigo) on DELETE cascade;

ALTER TABLE Estabelecimento_TipoComida DROP constraint tipo_comida_cod_fk;
ALTER TABLE Estabelecimento_TipoComida ADD constraint tipo_comida_cod_fk foreign key(tipo_comida_cod) references Tipo_Comida(codigo) on DELETE set null;
