CREATE DATABASE petconecta;

USE petconecta;


CREATE TABLE ong (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  nome            VARCHAR(150) NOT NULL,
  cnpj            VARCHAR(18)  UNIQUE,
  email           VARCHAR(150),
  telefone        VARCHAR(20),
  cidade          VARCHAR(100),
  uf              CHAR(2),
  endereco        VARCHAR(255),
  data_cadastro   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE usuario (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  nome            VARCHAR(150) NOT NULL,
  telefone        VARCHAR(20),
  email           VARCHAR(150) NOT NULL UNIQUE,
  senha_hash      VARCHAR(255) NOT NULL,
  perfil          ENUM('VOLUNTARIO','COORDENADOR') NOT NULL DEFAULT 'VOLUNTARIO',
  ativo           BOOLEAN NOT NULL DEFAULT TRUE,
  data_criacao    DATE,
  id_ong          INT NOT NULL,
  FOREIGN KEY (id_ong) REFERENCES ong(id)
);


CREATE TABLE animal (
  id                  INT AUTO_INCREMENT PRIMARY KEY,
  tipo                ENUM('AVE','FELINO','CANINO') NOT NULL,
  especie_raca        VARCHAR(100) NOT NULL,         -- ex.: Calopsita, Persa, SRD
  sexo                ENUM('FEMEA','MACHO') NOT NULL,
  idade               INT UNSIGNED,                  -- definir unidade com o grupo (meses ou anos)
  peso                DECIMAL(6,2),
  castrado            ENUM('SIM','NAO','NAO_SE_APLICA') NOT NULL DEFAULT 'NAO',
  disponivel_adocao   BOOLEAN NOT NULL DEFAULT TRUE,
  data_chegada        DATE NOT NULL,
  responsavel_id      INT NULL,
  status              ENUM('ATIVO','ADOTADO','OBITO') NOT NULL DEFAULT 'ATIVO',  -- arquivado = ADOTADO/OBITO
  id_ong              INT NOT NULL,

  -- Atributos internos
  adicionado_por      INT NOT NULL,
  editado_por         INT NULL,
  ultima_edicao       DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

  FOREIGN KEY (id_ong)         REFERENCES ong(id),
  FOREIGN KEY (responsavel_id) REFERENCES usuario(id),
  FOREIGN KEY (adicionado_por) REFERENCES usuario(id),
  FOREIGN KEY (editado_por)    REFERENCES usuario(id)
);


CREATE TABLE vacina (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  descricao   VARCHAR(255) NOT NULL,
  id_animal   INT NOT NULL,
  FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE CASCADE
);

CREATE TABLE doenca (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  descricao   VARCHAR(255) NOT NULL,
  situacao    ENUM('DIAGNOSTICADA','SUSPEITA') NOT NULL,
  id_animal   INT NOT NULL,
  FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE CASCADE
);

CREATE TABLE prescricao (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  descricao   VARCHAR(255) NOT NULL,
  id_animal   INT NOT NULL,
  FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE CASCADE
);

CREATE TABLE detalhe_animal (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  descricao   VARCHAR(255) NOT NULL,
  id_animal   INT NOT NULL,
  FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE CASCADE
);


CREATE TABLE historico (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  data_ocorrido   DATE NOT NULL,
  titulo          ENUM('CONSULTA','EXAME','ACIDENTE','ATUALIZACAO_SAUDE') NOT NULL,
  descricao       TEXT,
  id_animal   INT NOT NULL,
  FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE CASCADE
);

CREATE TABLE arquivamento_animal (
  id                  INT AUTO_INCREMENT PRIMARY KEY,
  tipo                ENUM('ADOCAO','OBITO') NOT NULL,
  data_arquivamento   DATE NOT NULL,
  arquivado_por       INT NOT NULL,
  id_animal   INT NOT NULL,
  FOREIGN KEY (id_animal)     REFERENCES animal(id),
  FOREIGN KEY (arquivado_por) REFERENCES usuario(id)
);

CREATE TABLE arquivamento_adocao (
  id_arquivamento      INT PRIMARY KEY,
  nome_completo        VARCHAR(150) NOT NULL,
  endereco_residencia  VARCHAR(255) NOT NULL,
  contato          VARCHAR(50) NOT NULL,
  FOREIGN KEY (id_arquivamento) REFERENCES arquivamento_animal(id)
);


CREATE TABLE arquivamento_obito (
  id_arquivamento  INT PRIMARY KEY,
  data_obito       DATE NOT NULL,
  causa_morte      VARCHAR(255) NOT NULL,
  FOREIGN KEY (id_arquivamento) REFERENCES arquivamento_animal(id)
);

