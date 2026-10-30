CREATE DATABASE petconecta;

USE petconecta;

CREATE TABLE ong(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(150) NOT NULL,
cnpj  VARCHAR(18),
email VARCHAR(150),
telefone VARCHAR(20),
endereco_ong VARCHAR(255),
data_cadastro DATE
);

CREATE TABLE endereco_ong(
id_endereco INT PRIMARY KEY AUTO_INCREMENT,
id_ong INT NOT NULL, FOREIGN KEY (id_ong) REFERENCES ong(id),
uf VARCHAR(150) NOT NULL,
cidade  VARCHAR(18) NOT NULL,
bairro VARCHAR(150) NOT NULL,
rua VARCHAR(20) NOT NULL,
numero_casa INT
);


CREATE TABLE usuario(
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
id_ong INT NOT NULL, FOREIGN KEY (id_ong) REFERENCES ong(id),
perfil ENUM('VOLUNTARIO','COORDENADOR') NOT NULL DEFAULT 'VOLUNTARIO',
nome_completo VARCHAR(150) NOT NULL,
telefone VARCHAR(20) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
senha_hash VARCHAR(255) NOT NULL,
ativo BOOLEAN NOT NULL DEFAULT TRUE,
data_criacao DATE
);

CREATE TABLE coordenador(
id_usuario INT NOT NULL, FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);


CREATE TABLE voluntario(
id_usuario INT NOT NULL, FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);


CREATE TABLE animal(
id_animal  INT PRIMARY KEY AUTO_INCREMENT,
id_ong  INT NOT NULL, FOREIGN KEY (id_ong) REFERENCES ong(id),
nome VARCHAR(20),
tipo ENUM('AVE','FELINO','CANINO') NOT NULL,
especie_raca VARCHAR(100) NOT NULL,       
sexo ENUM('FEMEA','MACHO') NOT NULL,
idade INT,                  
peso DECIMAL(6,2),
disponivel_adocao BOOLEAN NOT NULL DEFAULT TRUE,
data_chegada DATE NOT NULL,
adicionado_por INT NOT NULL, FOREIGN KEY (adicionado_por) REFERENCES usuario(id),
editado_por  INT NULL, FOREIGN KEY (editado_por) REFERENCES usuario(id),
ultima_edicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP  
);

CREATE TABLE saude_animal(
id INT PRIMARY KEY AUTO_INCREMENT,
id_animal INT NOT NULL, FOREIGN KEY (id_animal) REFERENCES animal(id),
estado_saude ENUM('DOENTE', 'SAUDAVEL') NOT NULL DEFAULT 'SAUDAVEL',
castrado ENUM('SIM','NAO', 'NAO SE APLICA') NOT NULL DEFAULT 'NAO SE APLICA'
);

CREATE TABLE vacina_animal(
id_vacina INT AUTO_INCREMENT,
id_saude INT NOT NULL, FOREIGN KEY (id_saude) REFERENCES saude(id),
vacina VARCHAR(100) NOT NULL,
data_vacina Date
);

CREATE TABLE doenca_sim(
id_doenca INT AUTO_INCREMENT,
id_saude INT NOT NULL, FOREIGN KEY (id_saude) REFERENCES saude(id),
doenca VARCHAR(100) NOT NULL,
prescricao VARCHAR(100)
);



CREATE TABLE historico(
id_historico  INT PRIMARY KEY AUTO_INCREMENT,
titulo ENUM('CONSULTA','EXAME','ACIDENTE','ATUALIZACAO') NOT NULL,
descricao TEXT,
status  ENUM('ATIVO','ADOTADO','OBITO') NOT NULL DEFAULT 'ATIVO', 
id_animal INT NOT NULL, FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE CASCADE,
id_saude INT NOT NULL, FOREIGN KEY (id_saude) REFERENCES saude_animal(id) ON DELETE CASCADE,
id_responsavel INT NULL, FOREIGN KEY (id_responsavel) REFERENCES usuario(id)
);

CREATE TABLE arquivamento_animal(
id_aquivamento INT PRIMARY KEY AUTO_INCREMENT,
tipo ENUM('ADOCAO','OBITO') NOT NULL,
data_arquivamento DATE NOT NULL,
arquivado_por INT NOT NULL, FOREIGN KEY (arquivado_por) REFERENCES usuario(id),
id_animal INT NOT NULL, FOREIGN KEY (id_animal) REFERENCES animal(id)
);


CREATE TABLE arquivamento_adocao(
id_arquivamento INT PRIMARY KEY, FOREIGN KEY (id_arquivamento) REFERENCES arquivamento_animal(id),
nome_completo VARCHAR(150) NOT NULL,
endereco_residencia VARCHAR(255) NOT NULL,
contato VARCHAR(50) NOT NULL
);

CREATE TABLE endereco_tutor(
id_endereco_tutor INT PRIMARY KEY AUTO_INCREMENT,
id_aquivamento_adocao INT NOT NULL, FOREIGN KEY (id_aquivamento_adocao) REFERENCES aquivamento_adocao(id),
uf VARCHAR(150) NOT NULL,
cidade  VARCHAR(18) NOT NULL,
bairro VARCHAR(150) NOT NULL,
rua VARCHAR(20) NOT NULL,
numero_casa INT
);


CREATE TABLE arquivamento_obito(
id_arquivamento INT PRIMARY KEY, FOREIGN KEY (id_arquivamento) REFERENCES arquivamento_animal(id),
causa_morte VARCHAR(255) NOT NULL,
data_obito DATE NOT NULL
);

