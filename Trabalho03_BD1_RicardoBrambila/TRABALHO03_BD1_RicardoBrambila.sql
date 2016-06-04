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



Endereco(*codigo*, cidade_cod, cep, rua);
    cep default 00000000;
    rua nao nulo;
    cidade_cod referencia Cidade(codigo);

Cidade(*codigo*, nome, estado_cod);
	estado_cod referencia Estado(codigo);

Estado(*codigo*, nome);
	nome chave candidata;

HorarioFuncionamento(*abertura*, *fechamento*, dia_cod);
    dia_cod referencia Dia(codigo);

Dia(*codigo*, nome);
    nome chave candidata;