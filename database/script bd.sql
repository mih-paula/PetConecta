CREATE DATABASE petconecta;

USE petconecta;

CREATE TABLE ong(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(150) NOT NULL,
cnpj  VARCHAR(18) UNIQUE,
email VARCHAR(150),
telefone VARCHAR(20),
data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
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
data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP 
);


CREATE TABLE animal(
id_animal  INT PRIMARY KEY AUTO_INCREMENT,
id_ong  INT NOT NULL, FOREIGN KEY (id_ong) REFERENCES ong(id),
nome VARCHAR(100),
tipo ENUM('AVE','FELINO','CANINO') NOT NULL,
especie_raca VARCHAR(100) NOT NULL,       
sexo ENUM('FEMEA','MACHO') NOT NULL,
data_estimada_nascimento DATE,                  
peso DECIMAL(6,2),
status  ENUM('ATIVO','ARQUIVADO') NOT NULL DEFAULT 'ATIVO', 
disponivel_adocao BOOLEAN NOT NULL DEFAULT TRUE,
data_chegada DATE NOT NULL,
adicionado_por INT NOT NULL, FOREIGN KEY (adicionado_por) REFERENCES usuario(id_usuario),
editado_por  INT NULL, FOREIGN KEY (editado_por) REFERENCES usuario(id_usuario),
ultima_edicao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE prontuario(
id_pront INT PRIMARY KEY AUTO_INCREMENT,
id_animal INT NOT NULL UNIQUE, FOREIGN KEY (id_animal) REFERENCES animal(id_animal),
estado_saude ENUM('DOENTE', 'SAUDAVEL', 'EM_TRATAMENTO', 'CRITICO') NOT NULL DEFAULT 'SAUDAVEL',
castrado ENUM('SIM','NAO', 'NAO_SE_APLICA') NOT NULL DEFAULT 'NAO_SE_APLICA'
);

CREATE TABLE historico(
id_historico INT PRIMARY KEY AUTO_INCREMENT,
tipo ENUM('CONSULTA','EXAME','ACIDENTE','ATUALIZACAO_SAUDE', 'ADOCAO', 'OBITO') NOT NULL,
descricao TEXT,
id_animal INT NOT NULL, FOREIGN KEY (id_animal) REFERENCES animal(id_animal) ON DELETE CASCADE,
id_pront INT NULL, FOREIGN KEY (id_pront) 	REFERENCES  prontuario(id_pront) ON DELETE CASCADE,
id_responsavel INT NULL, FOREIGN KEY (id_responsavel) REFERENCES usuario(id_usuario)
);

CREATE TABLE vacina(
id_vacina INT PRIMARY KEY AUTO_INCREMENT,
id_pront INT NOT NULL, FOREIGN KEY (id_pront) REFERENCES  prontuario(id_pront),
vacina VARCHAR(100) NOT NULL,
data_vacina Date
);

CREATE TABLE doenca(
id_doenca INT PRIMARY KEY AUTO_INCREMENT,
id_pront INT NOT NULL, FOREIGN KEY (id_pront) REFERENCES prontuario(id_pront),
nome_doenca VARCHAR(100) NOT NULL,
situacao_doenca ENUM('GRAVE', 'MODERADO')
);

CREATE TABLE prescricao(
id_prescricao INT PRIMARY KEY AUTO_INCREMENT,
id_pront INT NOT NULL, FOREIGN KEY (id_pront) REFERENCES prontuario(id_pront),
medicamento VARCHAR(100) NOT NULL, 
frequencia VARCHAR(100) NOT NULL, 
data_inicio DATE, 
data_final DATE
);

CREATE TABLE endereco(
id_endereco INT PRIMARY KEY AUTO_INCREMENT,
uf VARCHAR(2) NOT NULL,
cidade  VARCHAR(100) NOT NULL,
bairro VARCHAR(100) NOT NULL,
rua VARCHAR(150) NOT NULL,
numero_casa INT
);

CREATE TABLE arquivamento(
id_arquivamento INT PRIMARY KEY AUTO_INCREMENT,
tipo ENUM('ADOCAO','OBITO') NOT NULL,
data_arquivamento DATE NOT NULL,
arquivado_por INT NOT NULL, FOREIGN KEY (arquivado_por) REFERENCES usuario(id_usuario),
id_animal INT NOT NULL UNIQUE, FOREIGN KEY (id_animal) REFERENCES animal(id_animal)
);

CREATE TABLE arquivamento_adocao(
id_arquivamento INT PRIMARY KEY, FOREIGN KEY (id_arquivamento) REFERENCES arquivamento(id_arquivamento),
data_adocao DATE NOT NULL
);


CREATE TABLE arquivamento_obito(
id_arquivamento INT PRIMARY KEY, FOREIGN KEY (id_arquivamento) REFERENCES arquivamento(id_arquivamento),
causa_morte VARCHAR(255) NOT NULL,
data_obito DATE NOT NULL
);

CREATE TABLE adotante(
id_adotante INT PRIMARY KEY AUTO_INCREMENT, 
id_arquivamento_adocao INT NOT NULL UNIQUE, FOREIGN KEY (id_arquivamento_adocao) REFERENCES arquivamento_adocao(id_arquivamento),
nome_completo VARCHAR(100) NOT NULL, 
telefone VARCHAR(20) NOT NULL
); 

ALTER TABLE ong
ADD id_endereco INT UNIQUE,
ADD FOREIGN KEY(id_endereco) REFERENCES endereco(id_endereco);

ALTER TABLE adotante 
ADD id_endereco INT UNIQUE,
ADD FOREIGN KEY(id_endereco) REFERENCES endereco(id_endereco);

ALTER TABLE prontuario 
ADD COLUMN IF NOT EXISTS descricao TEXT NOT NULL AFTER id_animal;