-- Seleciona o banco de dados "Loja"
USE Loja;

--PROCEDIMENTO 2

-- Inserindo dados na tabela usuario
INSERT INTO dbo.usuario (login_usuario, senha_usuario)
VALUES
  ('op1', 'op1'),
  ('op2', 'op2');

-- Inserindo dados na tabela produto
INSERT INTO dbo.produto (id_produto, nome_produto, quantidade_produto, preco_venda_produto)
VALUES
(1, 'Banana', 100, 5.00),
(3, 'Laranja', 500, 2.00),
(4, 'Manga', 800, 4.00);

-- Inserir dados na tabela 'pessoa'
INSERT INTO pessoa (nome_pessoa, logradouro_pessoa, cidade_pessoa, estado_pessoa, telefone_pessoa, email_pessoa)
VALUES ('Joao', 'Rua 12, casa 3, Quitanda', 'Riacho do Sul', 'PA', '1111-1111', 'joao@riacho.com'),
	   ('JJC', 'Rua 11, Centro', 'Riacho do Norte', 'PA', '1212-1212', 'jjc@riacho.com');

-- Inserir dados na tabela 'pessoa_fisica'
INSERT INTO pessoa_fisica (id_pessoa, cpf)
VALUES (7, '12345678900');

-- Inserir dados na tabela 'pessoa_juridica'
INSERT INTO pessoa_juridica(id_pessoa, cnpj)
VALUES (8, '12345678901234');

-- Inserir dados na tabela 'movimento'
INSERT INTO movimento (id_usuario, id_pessoa, id_produto, quantidade_movimento, tipo_movimento, valor_unitario_mov)
VALUES (1, 7, 1, 20, 'S', 4),
	   (1, 7, 3, 15, 'S', 2),
	   (2, 7, 3, 10, 'S', 3),
	   (1, 8, 3, 15, 'E', 5),
	   (1, 8, 4, 20, 'E', 4);