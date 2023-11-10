-- Seleciona o banco de dados "Loja"
USE Loja;

--PROCEDIMENTO 1

CREATE TABLE usuario ( --Cria a tabela 'usuario'
  id_usuario INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  login_usuario VARCHAR(250) NULL,
  senha_usuario VARCHAR(20) NULL
);

CREATE TABLE pessoa ( --Cria a tabela 'pessoa'
  id_pessoa INTEGER IDENTITY(7,1) NOT NULL PRIMARY KEY,
  nome_pessoa VARCHAR(255) NOT NULL,
  logradouro_pessoa VARCHAR(255) NULL,
  cidade_pessoa VARCHAR(255) NULL,
  estado_pessoa VARCHAR(2) NULL,
  telefone_pessoa VARCHAR(11) NULL,
  email_pessoa VARCHAR(50) NULL
);

CREATE TABLE pessoa_fisica ( --Cria a tabela 'pessoa_fisica'
  id_pessoa INTEGER PRIMARY KEY NOT NULL,
  cpf VARCHAR(14) NULL,
  FOREIGN KEY(id_pessoa)
    REFERENCES pessoa(id_pessoa)
);

-- Cria um índice para otimizar junções relacionadas a chaves estrangeiras na tabela pessoa_fisica.
CREATE INDEX pessoa_fisica_FKIndex1 ON pessoa_fisica (id_pessoa);

-- Cria um índice adicional para aprimorar o desempenho de consultas envolvendo a tabela pessoa_fisica e a coluna id_pessoa.
CREATE INDEX IFK_Tipo_PF ON pessoa_fisica (id_pessoa);


CREATE TABLE pessoa_juridica ( --Cria a tabela 'pessoa_juridica'
  id_pessoa INTEGER PRIMARY KEY NOT NULL,
  cnpj VARCHAR(18) NULL,
  FOREIGN KEY(id_pessoa)
    REFERENCES pessoa(id_pessoa)
);

-- Cria um índice para otimizar junções relacionadas a chaves estrangeiras na tabela pessoa_juridica.
CREATE INDEX pessoa_juridica_FKIndex1 ON pessoa_juridica (id_pessoa);

-- Cria um índice adicional para aprimorar o desempenho de consultas envolvendo a tabela pessoa_juridica e a coluna id_pessoa.
CREATE INDEX IFK_Tipo_PJ ON pessoa_juridica (id_pessoa);

CREATE TABLE produto ( --Cria a tabela 'produto'
  id_produto INTEGER NOT NULL PRIMARY KEY,
  nome_produto VARCHAR(255) NULL,
  quantidade_produto INTEGER NULL,
  preco_venda_produto NUMERIC (10,2) NULL
);

CREATE TABLE movimento ( --Cria a tabela 'movimento'
  id_movimento INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  id_usuario INTEGER NOT NULL,
  id_pessoa INTEGER NOT NULL,
  id_produto INTEGER NOT NULL,
  quantidade_movimento INTEGER NULL,
  tipo_movimento VARCHAR(1) NULL,
  valor_unitario_mov DECIMAL(10,2) NULL,
  FOREIGN KEY(id_usuario)
    REFERENCES usuario(id_usuario),
  FOREIGN KEY(id_pessoa)
    REFERENCES pessoa(id_pessoa),
  FOREIGN KEY(id_produto)
    REFERENCES produto(id_produto)
);

-- Cria um índice para otimizar junções relacionadas a chaves estrangeiras com a tabela usuário na tabela movimento.
CREATE INDEX movimento_FKIndex1 ON movimento (id_usuario);

-- Cria um índice para otimizar junções relacionadas a chaves estrangeiras com a tabela pessoa na tabela movimento.
CREATE INDEX movimento_FKIndex2 ON movimento (id_pessoa);

-- Cria um índice para otimizar junções relacionadas a chaves estrangeiras com a tabela produto na tabela movimento.
CREATE INDEX movimento_FKIndex3 ON movimento (id_produto);

-- Cria um índice adicional para aprimorar o desempenho de consultas envolvendo a tabela movimento e a coluna id_usuario.
CREATE INDEX IFK_Atende ON movimento (id_usuario);

-- Cria um índice adicional para aprimorar o desempenho de consultas envolvendo a tabela movimento e a coluna id_pessoa.
CREATE INDEX IFK_Responsavel ON movimento (id_pessoa);

-- Cria um índice adicional para aprimorar o desempenho de consultas envolvendo a tabela movimento e a coluna id_produto.
CREATE INDEX IFK_Item_Movimentado ON movimento (id_produto);






