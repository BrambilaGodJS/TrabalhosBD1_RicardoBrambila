CREATE TABLE Dia(
	codigo int primary key AUTO_INCREMENT,
	nome varchar(32) not null UNIQUE
);

CREATE TABLE HorarioFuncionamento(
	abertura varchar(50) not null,
	fechamento varchar(50) not null,
	dia_cod int,

	primary key (abertura, fechamento),
	constraint dia_cod_fk foreign key(dia_cod) references Dia(codigo)
);

CREATE TABLE Estado(
	codigo int primary key AUTO_INCREMENT,
	nome varchar(64) not null UNIQUE
);

CREATE TABLE Cidade(
	codigo int primary key AUTO_INCREMENT,
	nome varchar(128),
	estado_cod int not null,

	constraint estado_cod_fk foreign key(estado_cod) references Estado(codigo)
);

CREATE TABLE Endereco(
	codigo int primary key AUTO_INCREMENT,
	cep int default 00000000,
	rua varchar(64) not null,
	cidade_cod int not null,

	constraint cidade_cod_fk foreign key(cidade_cod) references Cidade(codigo)
);

CREATE TABLE Tipo_Comida(
	codigo int primary key AUTO_INCREMENT,
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Funcao(
	codigo int primary key AUTO_INCREMENT,
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Pessoa(
	codigo int primary key AUTO_INCREMENT,
	nome varchar(128) not null UNIQUE,
	telefone varchar(20),
	identidade varchar(30),
	nascimento varchar(10),
	cpf varchar(30)
);

CREATE TABLE Estabelecimento(
	codigo int primary key AUTO_INCREMENT,
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Pais(
	codigo int primary key AUTO_INCREMENT,
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Cervejaria(
	codigo int primary key AUTO_INCREMENT,
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Ingrediente(
	codigo int primary key AUTO_INCREMENT,
	nome varchar(128) not null UNIQUE
);

CREATE TABLE Estilo(
	codigo int primary key AUTO_INCREMENT,
	nome varchar(128) not null UNIQUE,
	descricao varchar(1024)
);

CREATE TABLE Rotulo(
	codigo int primary key AUTO_INCREMENT,
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


CREATE TABLE Rotulo_Ingrediente(
	rotulo_codigo int,
	ingrediente_cod int,

	constraint ri_rotulo_codigo_fk foreign key(rotulo_codigo) references Rotulo(codigo),
	constraint ri_ingrediente_cod_fk foreign key(ingrediente_cod) references Ingrediente(codigo),
	constraint ri_rotulo_ingrediente_pk primary key (rotulo_codigo, ingrediente_cod)
);

CREATE TABLE Rotulo_Pais_Producao(
	rotulo_codigo int,
	pais_cod int,

	constraint rpp_rotulo_codigo_fk foreign key(rotulo_codigo) references Rotulo(codigo),
	constraint rpp_pais_cod_fk foreign key(pais_cod) references Pais(codigo),
	constraint rpp_rotulo_pais_producao_pk primary key (rotulo_codigo, pais_cod)
);


CREATE TABLE Rotulo_Estabelecimento(
	rotulo_codigo int,
	estabelecimento_cod int,

	constraint re_rotulo_codigo_fk foreign key (rotulo_codigo) references Rotulo(codigo),
	constraint re_estabelecimento_cod_fk foreign key (estabelecimento_cod) references Estabelecimento(codigo),
	constraint re_rotulo_estabelecimento_pk primary key (rotulo_codigo, estabelecimento_cod)
);

CREATE TABLE Propriedade(
	estabelecimento_cod int,
	pessoa_cod int,

	constraint p_estabelecimento_cod_fk foreign key (estabelecimento_cod) references Estabelecimento(codigo),
	constraint p_pessoa_cod_fk foreign key(pessoa_cod) references Pessoa(codigo),
	constraint p_propriedade_pk primary key (estabelecimento_cod, pessoa_cod)
);

CREATE TABLE Pessoa_Funcao(
	pessoa_cod int,
	funcao_cod int,

	constraint pf_pessoa_cod_fk foreign key(pessoa_cod) references Pessoa(codigo),
	constraint pf_funcao_cod_fk foreign key(funcao_cod) references Funcao(codigo),
	constraint pf_pessoa_funcao_pk primary key (pessoa_cod, funcao_cod)
);

CREATE TABLE Trabalha(
	estabelecimento_cod int,
	pessoa_cod int,
	funcao_cod int,

	constraint t_estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint t_pessoa_cod_fk foreign key(pessoa_cod) references Pessoa(codigo),
	constraint t_funcao_cod_fk foreign key(funcao_cod) references Funcao(codigo),
	constraint t_trabalha_pk primary key (estabelecimento_cod, pessoa_cod, funcao_cod)
);

CREATE TABLE Estabelecimento_TipoComida(
	estabelecimento_cod int,
	tipo_comida_cod int,

	constraint et_estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint et_tipo_comida_cod_fk foreign key(tipo_comida_cod) references Tipo_Comida(codigo),
	constraint et_estabelecimento_tipo_comida_pk primary key (estabelecimento_cod, tipo_comida_cod)
);

CREATE TABLE Estabelecimento_HorarioFuncionamento(
	estabelecimento_cod int,
	horariofuncionamento_abertura varchar(30),
	horariofuncionamento_fechamento varchar(30),

	constraint eh_estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint eh_horariofuncionamento_fk foreign key(horariofuncionamento_abertura, horariofuncionamento_fechamento) references HorarioFuncionamento(abertura, fechamento),
	constraint eh_estabelecimento_horario_funcionamento_pk primary key (estabelecimento_cod, horariofuncionamento_abertura, horariofuncionamento_fechamento)
);

CREATE TABLE Estabelecimento_Endereco(
	estabelecimento_cod int,
	endereco_cod int,

	constraint ee_estabelecimento_cod_fk foreign key(estabelecimento_cod) references Estabelecimento(codigo),
	constraint ee_endereco_cod_fk foreign key(endereco_cod) references Endereco(codigo),
	constraint ee_estabelecimento_endereco_pk primary key (estabelecimento_cod, endereco_cod)
);