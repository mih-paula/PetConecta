CREATE DATABASE petconecta;

USE petconecta;

CREATE TABLE ong(
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
cnpj  VARCHAR(18) NOT NULL,
email VARCHAR(150),
telefone VARCHAR(20),
cidade VARCHAR(100),
uf VARCHAR(3),
endereco VARCHAR(255),
data_cadastro   DATE
);


CREATE TABLE usuario(
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
telefone VARCHAR(20) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
senha_hash VARCHAR(255) NOT NULL,
perfil ENUM('VOLUNTARIO','COORDENADOR') NOT NULL DEFAULT 'VOLUNTARIO',
ativo BOOLEAN NOT NULL DEFAULT TRUE,
data_criacao DATE,
id_ong INT NOT NULL,
FOREIGN KEY (id_ong) REFERENCES ong(id)
);


CREATE TABLE animal(
id  INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('AVE','FELINO','CANINO') NOT NULL,
especie_raca VARCHAR(100) NOT NULL,       
sexo ENUM('FEMEA','MACHO') NOT NULL,
idade INT,                  
peso DECIMAL(6,2),
castrado ENUM('SIM','NAO','NAO_SE_APLICA') NOT NULL DEFAULT 'NAO',
disponivel_adocao BOOLEAN NOT NULL DEFAULT TRUE,
data_chegada DATE NOT NULL, 
id_ong  INT NOT NULL,
FOREIGN KEY (id_ong) REFERENCES ong(id)
);

CREATE TABLE saude_animal(
id INT AUTO_INCREMENT PRIMARY KEY,
estado_saude ENUM('DOENTE', 'SAUDAVEL') NOT NULL DEFAULT 'SAUDAVEL',
vacina VARCHAR(100) NOT NULL,
doenca VARCHAR(100),
prescricao VARCHAR(100),
id_animal INT NOT NULL,
FOREIGN KEY (id_animal) REFERENCES animal(id)
);



CREATE TABLE historico(
id  INT AUTO_INCREMENT PRIMARY KEY,
titulo   ENUM('CONSULTA','EXAME','ACIDENTE','ATUALIZACAO_SAUDE') NOT NULL,
descricao  TEXT,
status  ENUM('ATIVO','ADOTADO','OBITO') NOT NULL DEFAULT 'ATIVO', 
id_animal INT NOT NULL,
id_saude INT NOT NULL,
id_responsavel INT NULL,
  
adicionado_por INT NOT NULL,
editado_por  INT NULL,
ultima_edicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
  
FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE CASCADE,
FOREIGN KEY (id_saude) REFERENCES saude_animal(id) ON DELETE CASCADE,
FOREIGN KEY (id_responsavel) REFERENCES usuario(id),
FOREIGN KEY (adicionado_por) REFERENCES usuario(id),
FOREIGN KEY (editado_por)    REFERENCES usuario(id)
);

CREATE TABLE arquivamento_animal(
id INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('ADOCAO','OBITO') NOT NULL,
data_arquivamento DATE NOT NULL,
arquivado_por INT NOT NULL,
id_animal   INT NOT NULL,
FOREIGN KEY (id_animal)     REFERENCES animal(id),
FOREIGN KEY (arquivado_por) REFERENCES usuario(id)
);

CREATE TABLE arquivamento_adocao(
id_arquivamento INT PRIMARY KEY,
nome_completo VARCHAR(150) NOT NULL,
endereco_residencia VARCHAR(255) NOT NULL,
contato VARCHAR(50) NOT NULL,
FOREIGN KEY (id_arquivamento) REFERENCES arquivamento_animal(id)
);

CREATE TABLE arquivamento_obito(
id_arquivamento  INT PRIMARY KEY,
data_obito       DATE NOT NULL,
causa_morte      VARCHAR(255) NOT NULL,
FOREIGN KEY (id_arquivamento) REFERENCES arquivamento_animal(id)
);

