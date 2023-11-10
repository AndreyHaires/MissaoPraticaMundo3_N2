# Missão Prática | Mundo 3 - Nível 2

Polo Centro - Palhoça – SC  
**Curso:** Desenvolvimento Full Stack  
**Disciplina:** Nível 2: Vamos Manter as Informações?  
**Turma:** 9001  
**Semestre Letivo:** 3  
**Integrantes da Prática:** Andrey Haertel Aires  

## Repositório GIT
https://link-do-seu-repositorio-git

## 1 - 1º Procedimento | Criando o Banco de Dados

### Objetivos da prática

1. Identificar os requisitos de um sistema e transformá-los no modelo adequado.
2. Utilizar ferramentas de modelagem para bases de dados relacionais.
3. Explorar a sintaxe SQL na criação das estruturas do banco (DDL).
4. Explorar a sintaxe SQL na consulta e manipulação de dados (DML).
5. Ao final do exercício, o aluno terá vivenciado a experiência de modelar a base de dados para um sistema simples, além de implementá-la, através da sintaxe SQL, na plataforma do SQL Server.

### Todos os códigos solicitados neste roteiro de aula

#### Modelagem

**Criando tabelas**

```sql
-- Seleciona o banco de dados "Loja"
USE Loja;

-- PROCEDIMENTO 1

CREATE TABLE usuario (
  id_usuario INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  login_usuario VARCHAR(250) NULL,
  senha_usuario VARCHAR(20) NULL
);

CREATE TABLE pessoa (
  id_pessoa INTEGER IDENTITY(7,1) NOT NULL PRIMARY KEY,
  nome_pessoa VARCHAR(255) NOT NULL,
  logradouro_pessoa VARCHAR(255) NULL,
  cidade_pessoa VARCHAR(255) NULL,
  estado_pessoa VARCHAR(2) NULL,
  telefone_pessoa VARCHAR(11) NULL,
  email_pessoa VARCHAR(50) NULL
);

CREATE TABLE pessoa_fisica (
  id_pessoa INTEGER PRIMARY KEY NOT NULL,
  cpf VARCHAR(14) NULL,
  FOREIGN KEY(id_pessoa)
    REFERENCES pessoa(id_pessoa)
);

-- Cria um índice para otimizar junções relacionadas a chaves estrangeiras na tabela pessoa_fisica.
CREATE INDEX pessoa_fisica_FKIndex1 ON pessoa_fisica (id_pessoa);

-- Cria um índice adicional para aprimorar o desempenho de consultas envolvendo a tabela pessoa_fisica e a coluna id_pessoa.
CREATE INDEX IFK_Tipo_PF ON pessoa_fisica (id_pessoa);

CREATE TABLE pessoa_juridica (
  id_pessoa INTEGER PRIMARY KEY NOT NULL,
  cnpj VARCHAR(18) NULL,
  FOREIGN KEY(id_pessoa)
    REFERENCES pessoa(id_pessoa)
);

-- Cria um índice para otimizar junções relacionadas a chaves estrangeiras na tabela pessoa_juridica.
CREATE INDEX pessoa_juridica_FKIndex1 ON pessoa_juridica (id_pessoa);

-- Cria um índice adicional para aprimorar o desempenho de consultas envolvendo a tabela pessoa_juridica e a coluna id_pessoa.
CREATE INDEX IFK_Tipo_PJ ON pessoa_juridica (id_pessoa);

CREATE TABLE produto (
  id_produto INTEGER NOT NULL PRIMARY KEY,
  nome_produto VARCHAR(255) NULL,
  quantidade_produto INTEGER NULL,
  preco_venda_produto NUMERIC (10,2) NULL
);

CREATE TABLE movimento (
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
```

## Análise e Conclusão

### a) Como são implementadas as diferentes cardinalidades (1X1, 1XN ou NxN) em um banco de dados relacional?

Em um banco de dados relacional, as diferentes cardinalidades são implementadas por meio de relacionamentos entre tabelas:

**1X1 (Um para Um):** Uma tabela está relacionada a outra tabela por meio de uma chave estrangeira, e cada registro na tabela A está associado a exatamente um registro na tabela B, e vice-versa. Por exemplo, uma tabela "Pessoa" pode estar relacionada a uma tabela "Endereço" por meio de uma chave estrangeira que vincula uma pessoa a um único endereço.

**1XN (Um para Muitos):** Uma tabela A está relacionada a uma tabela B, onde cada registro na tabela

 A pode estar associado a vários registros na tabela B. Isso é alcançado por meio de uma chave estrangeira na tabela B que faz referência à chave primária da tabela A. Por exemplo, uma tabela "Cliente" pode estar relacionada a uma tabela "Pedido" com a chave do cliente sendo a chave primária na tabela "Cliente" e uma chave estrangeira na tabela "Pedido" que faz referência ao cliente.

**NxN (Muitos para Muitos):** Para implementar um relacionamento muitos para muitos, geralmente é necessário criar uma tabela de associação intermediária que relaciona as tabelas A e B. Essa tabela de associação contém chaves estrangeiras que fazem referência às tabelas A e B, permitindo que múltiplos registros de A se relacionem com múltiplos registros de B. Por exemplo, em um sistema de gerenciamento de alunos e cursos, você pode ter uma tabela "Aluno," uma tabela "Curso" e uma tabela de associação "Aluno_Curso" que relaciona alunos a cursos matriculados.

### b) Que tipo de relacionamento deve ser utilizado para representar o uso de herança em bancos de dados relacionais?

Para representar o uso de herança em bancos de dados relacionais, é comum utilizar o modelo "Tabela por Subclasse" ou "Tabela por Herança." Nesse modelo, cada subclasse ou entidade derivada é representada por uma tabela separada. As tabelas de subclasse contêm as propriedades específicas da subclasse, bem como uma chave estrangeira que faz referência à tabela de superclasse ou à tabela base. A tabela base contém as propriedades comuns a todas as subclasses. Esse modelo permite a representação de hierarquias de classes e herança no banco de dados.

### c) Como o SQL Server Management Studio permite a melhoria da produtividade nas tarefas relacionadas ao gerenciamento do banco de dados?

O SQL Server Management Studio (SSMS) oferece várias funcionalidades que melhoram a produtividade nas tarefas de gerenciamento do banco de dados:

- **Interface Gráfica:** O SSMS fornece uma interface gráfica amigável para gerenciar bancos de dados, tabelas, consultas e outros objetos do banco de dados, facilitando a administração e a navegação.

- **Editor SQL:** O SSMS possui um editor de consultas SQL integrado com recursos como realce de sintaxe, sugestões de código e depuração, o que ajuda na escrita e otimização de consultas SQL.

- **Gerenciamento de Segurança:** Permite configurar e gerenciar permissões de segurança, usuários, funções e outros aspectos de segurança do banco de dados.

- **Monitoramento e Otimização:** Oferece ferramentas de monitoramento de desempenho, planejamento de consultas e otimização de índices para melhorar o desempenho do banco de dados.

- **Integração com Git:** Permite integrar projetos de banco de dados com sistemas de controle de versão, facilitando o gerenciamento de mudanças no esquema do banco de dados.

- **Importação e Exportação de Dados:** Facilita a importação e exportação de dados entre diferentes fontes e destinos.

O SSMS é uma ferramenta abrangente que torna mais eficiente a administração e o gerenciamento de bancos de dados SQL Server.
