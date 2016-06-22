CREATE TABLE Rotulo(
	codigo int primary key GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(50) not null,
	validade varchar(50),

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
	telefone varchar(20),
	identidade varchar(30),
	nascimento varchar(10),
	cpf varchar(30)
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
	abertura varchar(50) not null,
	fechamento varchar(50) not null,
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
	horariofuncionamento_abertura varchar(30),
	horariofuncionamento_fechamento varchar(30),

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

INSERT INTO Ingrediente (NOME) VALUES('Água');
INSERT INTO Ingrediente (NOME) VALUES('Malte');
INSERT INTO Ingrediente (NOME) VALUES('Lúpulo');
INSERT INTO Ingrediente (NOME) VALUES('Fermento');

INSERT INTO Estilo (NOME, DESCRICAO) VALUES('Larger Pilsen', 'Estilo de cervejas douradas, brilhantes, que apresentam leve amargor.');
INSERT INTO Estilo (NOME, DESCRICAO) VALUES('ALE STOUT', 'Estilo de cerveja típico do reino unido e irlanda, a marca mais conhecido é a irlandesa Guinness.');
INSERT INTO Estilo (NOME, DESCRICAO) VALUES('LAGER BOCK', 'Estilo de cervejas em sua maioria avermelhadas, mas temos as versões claras (Heller Bock) e também escuras (Dunkler Bock).');
INSERT INTO Estilo (NOME, DESCRICAO) VALUES('ALE DUBBEL', 'Estilo típico belga, de coloração marrom, desperta aromas frutados, médio e corpo e equilibrado sabor.');

INSERT INTO Pais (NOME) VALUES('BRASIL');
INSERT INTO Pais (NOME) VALUES('INGLATERRA');
INSERT INTO Pais (NOME) VALUES('BELGICA');
INSERT INTO Pais (NOME) VALUES('ALEMANHA');

INSERT INTO Cervejaria (NOME) VALUES('Cervejaria Colorado');
INSERT INTO Cervejaria (NOME) VALUES('Wells & Youngs');
INSERT INTO Cervejaria (NOME) VALUES('Einbecker Brauhaus');
INSERT INTO Cervejaria (NOME) VALUES('Brouwerij Van Steenberge');

INSERT INTO Rotulo (NOME, VALIDADE, temperatura_maxima, temperatura_minima, teor_alcoolico, estilo_cod, pais_origem_cod, cervejaria_cod) VALUES('Colorado', '12 meses', -10, 25, 9, 1, 3, 1);
INSERT INTO Rotulo (NOME, VALIDADE, temperatura_maxima, temperatura_minima, teor_alcoolico, estilo_cod, pais_origem_cod, cervejaria_cod) VALUES('Youngs Double', '12 meses', -10, 25, 9, 1, 1, 2);
INSERT INTO Rotulo (NOME, VALIDADE, temperatura_maxima, temperatura_minima, teor_alcoolico, estilo_cod, pais_origem_cod, cervejaria_cod) VALUES('Einbecker', '6 meses', -15, 10, 6, 2, 1, 3);
INSERT INTO Rotulo (NOME, VALIDADE, temperatura_maxima, temperatura_minima, teor_alcoolico, estilo_cod, pais_origem_cod, cervejaria_cod) VALUES('Abdij van Roosenberg', '6 meses', -15, 10, 6, 3, 2, 3);

INSERT INTO Dia (NOME) VALUES('SEGUNDA');
INSERT INTO Dia (NOME) VALUES('TERCA');
INSERT INTO Dia (NOME) VALUES('QUARTA');
INSERT INTO Dia (NOME) VALUES('QUINTA');
INSERT INTO Dia (NOME) VALUES('SEXTA');
INSERT INTO Dia (NOME) VALUES('SABADO');
INSERT INTO Dia (NOME) VALUES('DOMINGO');

INSERT INTO Tipo_Comida (NOME) VALUES('COMIDA BRASILEIRA');
INSERT INTO Tipo_Comida (NOME) VALUES('COMIDA MEXICANA');
INSERT INTO Tipo_Comida (NOME) VALUES('PETISCOS');
INSERT INTO Tipo_Comida (NOME) VALUES('JAPONESA');

INSERT INTO Pessoa(nome, telefone, identidade, nascimento, cpf) values ('Capelão', '21945851208', '251631850', '1995-12-18', '15625225745');
INSERT INTO Pessoa(nome, telefone, identidade, nascimento, cpf) values ('Zé', '31974421564', '521596158', '1990-11-20', '20153201574');
INSERT INTO Pessoa(nome, telefone, identidade, nascimento, cpf) values ('José', '21971181380', '263096845', '1991-02-02', '20165486520');
INSERT INTO Pessoa(nome, telefone, identidade, nascimento, cpf) values ('Wesley', '21920158750', '586231568', '1920-01-01', '15462520315');
INSERT INTO Pessoa (nome, telefone, identidade, nascimento, cpf) VALUES('Stephenie Friedman','21945822258', '403289440', '1990-03-02', '104825243');
INSERT INTO Pessoa (nome, telefone, identidade, nascimento, cpf) VALUES('Mayra Hepp', '21952202157' ,'911225341', '1952-12-18', '126227998');
INSERT INTO Pessoa (nome, telefone, identidade, nascimento, cpf) VALUES('Elephteria Spicer', '21584420650' ,'2977269', '1965-06-18', '366605427');


INSERT INTO Estabelecimento(nome) values ('Bar do Capelão');
INSERT INTO Estabelecimento(nome) values ('Bar dos Zé');
INSERT INTO Estabelecimento(nome) values ('Bar Sem Nome');
INSERT INTO Estabelecimento(nome) values ('Bar e Restaurante Urca');

INSERT INTO Funcao (nome) values ('Garçom');
INSERT INTO Funcao (nome) values ('Gerente');
INSERT INTO Funcao (nome) values ('Cozinheiro');
INSERT INTO Funcao (nome) values ('Administração');

INSERT INTO Propriedade(pessoa_cod, estabelecimento_cod) values (1, 2);
INSERT INTO Propriedade(pessoa_cod, estabelecimento_cod) values (1, 1);
INSERT INTO Propriedade(pessoa_cod, estabelecimento_cod) values (2, 1);

INSERT INTO Pessoa_Funcao(pessoa_cod, funcao_cod) values (1, 3);
INSERT INTO Pessoa_Funcao(pessoa_cod, funcao_cod) values (2, 1);
INSERT INTO Pessoa_Funcao(pessoa_cod, funcao_cod) values (1, 2);

INSERT INTO Estado (nome) values ('Rio de Janeiro');
INSERT INTO Estado (nome) values ('São Paulo');

INSERT INTO Cidade (nome, estado_cod) values('Rio de Janeiro', 1);
INSERT INTO Cidade (nome, estado_cod) values('Angra dos Reis', 2);
INSERT INTO Cidade (nome, estado_cod) values('Cabo Frio', 2);

INSERT INTO Endereco (cep, rua, cidade_cod) values (21051360, 'Rua Lago Verde', 1);

INSERT INTO HorarioFuncionamento (dia_cod, ABERTURA,FECHAMENTO) VALUES('1', '18', '00');
INSERT INTO HorarioFuncionamento (dia_cod, ABERTURA,FECHAMENTO) VALUES('2', '16', '03');
INSERT INTO HorarioFuncionamento (dia_cod, ABERTURA,FECHAMENTO) VALUES('2', '22', '03');
INSERT INTO HorarioFuncionamento (dia_cod, ABERTURA,FECHAMENTO) VALUES('1', '21', '00');

INSERT INTO Rotulo_Ingrediente (rotulo_codigo, ingrediente_cod) VALUES('1', '3');
INSERT INTO Rotulo_Ingrediente (rotulo_codigo, ingrediente_cod) VALUES('2', '3');
INSERT INTO Rotulo_Ingrediente (rotulo_codigo, ingrediente_cod) VALUES('3', '2');
INSERT INTO Rotulo_Ingrediente (rotulo_codigo, ingrediente_cod) VALUES('2', '1');
INSERT INTO Rotulo_Ingrediente (rotulo_codigo, ingrediente_cod) VALUES('4', '3');
INSERT INTO Rotulo_Ingrediente (rotulo_codigo, ingrediente_cod) VALUES('2', '4');
INSERT INTO Rotulo_Ingrediente (rotulo_codigo, ingrediente_cod) VALUES('1', '4');

INSERT INTO Rotulo_Pais_Producao (pais_cod, rotulo_codigo) VALUES('1', '2');
INSERT INTO Rotulo_Pais_Producao (pais_cod, rotulo_codigo) VALUES('3', '3');
INSERT INTO Rotulo_Pais_Producao (pais_cod, rotulo_codigo) VALUES('4', '1');

INSERT INTO Rotulo_Estabelecimento (rotulo_codigo, estabelecimento_cod) VALUES('3', '3');
INSERT INTO Rotulo_Estabelecimento (rotulo_codigo, estabelecimento_cod) VALUES('3', '2');
INSERT INTO Rotulo_Estabelecimento (rotulo_codigo, estabelecimento_cod) VALUES('1', '4');
INSERT INTO Rotulo_Estabelecimento (rotulo_codigo, estabelecimento_cod) VALUES('1', '3');
INSERT INTO Rotulo_Estabelecimento (rotulo_codigo, estabelecimento_cod) VALUES('2', '2');
INSERT INTO Rotulo_Estabelecimento (rotulo_codigo, estabelecimento_cod) VALUES('2', '1');
INSERT INTO Rotulo_Estabelecimento (rotulo_codigo, estabelecimento_cod) VALUES('4', '1');
INSERT INTO Rotulo_Estabelecimento (rotulo_codigo, estabelecimento_cod) VALUES('4', '3');


INSERT INTO Estabelecimento_HorarioFuncionamento (estabelecimento_cod, horariofuncionamento_abertura, horariofuncionamento_fechamento) VALUES('1', '18', '00');
INSERT INTO Estabelecimento_HorarioFuncionamento (estabelecimento_cod, horariofuncionamento_abertura, horariofuncionamento_fechamento) VALUES('2', '16', '03');
INSERT INTO Estabelecimento_HorarioFuncionamento (estabelecimento_cod, horariofuncionamento_abertura, horariofuncionamento_fechamento) VALUES('3', '22', '03');
INSERT INTO Estabelecimento_HorarioFuncionamento (estabelecimento_cod, horariofuncionamento_abertura, horariofuncionamento_fechamento) VALUES('4', '22', '03');

INSERT INTO Estabelecimento_TipoComida (tipo_comida_cod, estabelecimento_cod) VALUES('1', '3');
INSERT INTO Estabelecimento_TipoComida (tipo_comida_cod, estabelecimento_cod) VALUES('2', '3');
INSERT INTO Estabelecimento_TipoComida (tipo_comida_cod, estabelecimento_cod) VALUES('3', '2');
INSERT INTO Estabelecimento_TipoComida (tipo_comida_cod, estabelecimento_cod) VALUES('4', '2');
INSERT INTO Estabelecimento_TipoComida (tipo_comida_cod, estabelecimento_cod) VALUES('3', '1');
INSERT INTO Estabelecimento_TipoComida (tipo_comida_cod, estabelecimento_cod) VALUES('2', '1');


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
