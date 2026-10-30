CREATE DATABASE petconecta;

USE petconecta;

CREATE TABLE ong(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(150) NOT NULL,
cnpj  VARCHAR(18) UNIQUE,
email VARCHAR(150),
telefone VARCHAR(20),
data_cadastro DATE
);

CREATE TABLE endereco(
id_endereco INT PRIMARY KEY AUTO_INCREMENT,
id_ong INT NOT NULL, FOREIGN KEY (id_ong) REFERENCES ong(id),
id_tutor INT NOT NULL, FOREIGN KEY (id_tutor) REFERENCES tutor(id),
uf VARCHAR(150) NOT NULL,
cidade  VARCHAR(100) NOT NULL,
bairro VARCHAR(100) NOT NULL,
rua VARCHAR(150) NOT NULL,
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
ultima_edicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP  
);

CREATE TABLE saude(
id INT PRIMARY KEY AUTO_INCREMENT,
id_animal INT NOT NULL, FOREIGN KEY (id_animal) REFERENCES animal(id_animal),
estado_saude ENUM('DOENTE', 'SAUDAVEL', 'EM_TRATAMENTO', 'CRITICO') NOT NULL DEFAULT 'SAUDAVEL',
castrado ENUM('SIM','NAO', 'NAO SE APLICA') NOT NULL DEFAULT 'NAO SE APLICA'
);

CREATE TABLE vacina(
id_vacina INT PRIMARY KEY AUTO_INCREMENT,
id_saude INT NOT NULL, FOREIGN KEY (id_saude) REFERENCES saude(id),
vacina VARCHAR(100) NOT NULL,
data_vacina Date
);

CREATE TABLE doenca(
id_doenca INT PRIMARY KEY AUTO_INCREMENT,
id_saude INT NOT NULL, FOREIGN KEY (id_saude) REFERENCES saude_animal(id),
nome_doenca VARCHAR(100) NOT NULL,
situacao_doenca ENUM('GRAVE', 'MODERADO')
);

CREATE TABLE prescricao(
id_prescricao INT PRIMARY KEY AUTO_INCREMENT,
id_animal INT NOT NULL, FOREIGN KEY (id_animal) REFERENCES animal(id),
medicamento VARCHAR(100) NOT NULL, 
frequencia VARCHAR(100) NOT NULL, 
data_inicio DATE, 
data_final DATE
);



CREATE TABLE historico(
id_historico INT PRIMARY KEY AUTO_INCREMENT,
tipo ENUM('CONSULTA','EXAME','ACIDENTE','ATUALIZACAO_SAUDE', 'ADOCAO', 'OBITO') NOT NULL,
descricao TEXT,
id_animal INT NOT NULL, FOREIGN KEY (id_animal) REFERENCES animal(id_animal) ON DELETE CASCADE,
id_saude INT NOT NULL, FOREIGN KEY (id_saude) REFERENCES saude_animal(id) ON DELETE CASCADE,
id_responsavel INT NULL, FOREIGN KEY (id_responsavel) REFERENCES usuario(id_usuario)
);

CREATE TABLE arquivamento(
id_arquivamento INT PRIMARY KEY AUTO_INCREMENT,
tipo ENUM('ADOCAO','OBITO') NOT NULL,
data_arquivamento DATE NOT NULL,
arquivado_por INT NOT NULL, FOREIGN KEY (arquivado_por) REFERENCES usuario(id_usuario),
id_animal INT NOT NULL, FOREIGN KEY (id_animal) REFERENCES animal(id_animal)
);


CREATE TABLE arquivamento_adocao(
id_arquivamento_adocao INT PRIMARY KEY, FOREIGN KEY (id_arquivamento) REFERENCES arquivamento(id_arquivamento),
nome_completo VARCHAR(150) NOT NULL,
contato VARCHAR(50) NOT NULL
);

CREATE TABLE tutor(
id_tutor INT PRIMARY KEY, 
id_arquivamento_adocao INT NOT NULL, FOREIGN KEY (id_arquivamento_adocao) REFERENCES arquivamento_adocao(id_arquivamento),
nome_completo VARCHAR(100) NOT NULL, 
telefone VARCHAR(20) NOT NULL
);


CREATE TABLE arquivamento_obito(
id_arquivamento_obito INT PRIMARY KEY, FOREIGN KEY (id_arquivamento) REFERENCES arquivamento(id_arquivamento),
causa_morte VARCHAR(255) NOT NULL,
data_obito DATE NOT NULL
);

