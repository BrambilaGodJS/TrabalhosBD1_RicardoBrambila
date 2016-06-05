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
	constraint ingrediente_cod_fk foreign key(ingrediente_cod) references Ingrediente(codigo)
);

CREATE TABLE Rotulo_Pais_Producao(
	rotulo_codigo int,
	pais_cod int,

	constraint rotulo_codigo_fk foreign key(rotulo_codigo) references Rotulo(codigo),
	constraint pais_cod_fk foreign key(pais_cod) references Pais(codigo)
);


CREATE TABLE Rotulo_Estabelecimento(
	rotulo_codigo int,
	estabelecimento_cod int,

	constraint rotulo_codigo_fk foreign key (rotulo_codigo) references Rotulo(codigo),
	constraint estabelecimento_cod foreign key (estabelecimento_cod) references Estabelecimento(codigo)
);

CREATE TABLE Propriedade(
	estabelecimento_cod int,
	pessoa_cod int,

	constraint estabelecimento_cod_fk foreign key (estabelecimento_cod) references Estabelecimento(codigo),
	constraint pessoa_cod_fk foreign key(pessoa_cod) references Pessoa(codigo)
);

CREATE TABLE Pessoa_Funcao(
	pessoa_cod int,
	funcao_cod int,

	constraint pessoa_cod_fk foreign key(pessoa_cod) references Pessoa(codigo),
	constraint funcao_cod_fk foreign key(funcao_cod) references Funcao(codigo)
);

CREATE TABLE Trabalha(
	estabelecimento_cod int,
	pessoa_cod int,
	funcao_cod int,

	constraint estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint pessoa_cod_fk foreign key(pessoa_cod) references Pessoa(codigo),
	constraint funcao_cod_fk foreign key(funcao_cod) references Funcao(codigo)
);

CREATE TABLE Estabelecimento_TipoComida(
	estabelecimento_cod int,
	tipo_comida_cod int,

	constraint estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint tipo_comida_cod_fk foreign key(tipo_comida_cod) references Tipo_Comida(codigo)
);

CREATE TABLE Estabelecimento_HorarioFuncionamento(
	estabelecimento_cod int,
	horariofuncionamento_abertura time,
	horariofuncionamento_fechamento time,

	constraint estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint horariofuncionamento_abertura_fk foreign key(horariofuncionamento_abertura) references HorarioFuncionamento(abertura),
	constraint horariofuncionamento_fechamento foreign key(horariofuncionamento_fechamento) references HorarioFuncionamento(fechamento)
);

CREATE TABLE Estabelecimento_Endereco(
	estabelecimento_cod int,
	endereco_cod int,

	constraint estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint endereco_cod_fk foreign key(endereco_cod) references Endereco(codigo)
);


