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
	nome varchar(128) not null UNIQUE
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
	abertura int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	fechamento int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	dia_cod int,

	primary key (abertura, fechamento),
	constraint dia_cod_fk foreign key(dia_cod) references Dia(codigo)
);

CREATE TABLE Dia(
	codigo int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nome varchar(32) not null UNIQUE
);

