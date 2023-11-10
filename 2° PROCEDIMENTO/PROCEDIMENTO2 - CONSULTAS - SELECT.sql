-- Seleciona o banco de dados "Loja"
USE Loja;

SELECT * FROM usuario --Visualizando a tabela 'usuario'

SELECT * FROM pessoa --Visualizando a tabela 'pessoa'

SELECT * FROM pessoa_fisica --Visualizando a tabela 'pessoa fisica'

SELECT * FROM pessoa_juridica --Visualizando a tabela 'pessoa juridica'

SELECT * FROM produto --Visualizando a tabela 'produto'

SELECT * FROM movimento --Visualizando a tabela 'movimento'

	
SELECT -- Este SELECT combina informações de pessoas e pessoas físicas
  p.id_pessoa, p.nome_pessoa, p.logradouro_pessoa,
  p.cidade_pessoa, p.estado_pessoa, p.telefone_pessoa,
  p.email_pessoa, pf.id_pessoa, pf.cpf
FROM
  pessoa p
FULL OUTER JOIN pessoa_fisica pf -- O FULL OUTER JOIN garante que todas as linhas de ambas as tabelas (pessoa e pessoa_fisica) sejam incluídas no resultado.
ON p.id_pessoa = pf.id_pessoa
WHERE pf.cpf IS NOT NULL; -- Verifica se o CPF na tabela pessoa_fisica não é nulo


SELECT -- Este SELECT combina informações de pessoas e pessoas juridicas
  p.id_pessoa, p.nome_pessoa, p.logradouro_pessoa,
  p.cidade_pessoa, p.estado_pessoa, p.telefone_pessoa,
  p.email_pessoa, pj.id_pessoa, pj.cnpj
FROM
  pessoa p
FULL OUTER JOIN pessoa_juridica pj -- O FULL OUTER JOIN garante que todas as linhas de ambas as tabelas (pessoa e pessoa_juridica) sejam incluídas no resultado.
ON p.id_pessoa = pj.id_pessoa
WHERE pj.cnpj IS NOT NULL; -- Verifica se o CNPJ na tabela pessoa_juridica não é nulo



-- Movimentações de entrada, com produto, fornecedor, quantidade, preço unitário e valor total.
SELECT
  prod.nome_produto AS PRODUTO,
  p.nome_pessoa AS FORNECEDOR,
  m.quantidade_movimento AS QUANTIDADE,
  m.valor_unitario_mov AS PRECO_UNITARIO,
 (m.quantidade_movimento * m.valor_unitario_mov) AS VALOR_TOTAL
FROM
 movimento m
  JOIN pessoa p ON m.id_pessoa = p.id_pessoa -- Relaciona a tabela movimento com a tabela pessoa
  JOIN produto prod ON m.id_produto = prod.id_produto -- Relaciona a tabela movimento com a tabela produto
WHERE m.tipo_movimento = 'E'; -- Filtra as movimentações de entrada


--Movimentações de saída, com produto, comprador, quantidade, preço unitário e valor total.
SELECT
  prod.nome_produto AS PRODUTO,
  p.nome_pessoa AS COMPRADOR,
  m.quantidade_movimento AS QUANTIDADE,
  m.valor_unitario_mov AS PRECO_UNITARIO,
 (m.quantidade_movimento * m.valor_unitario_mov) AS VALOR_TOTAL
FROM
 movimento m
  JOIN pessoa p ON m.id_pessoa = p.id_pessoa -- Relaciona a tabela movimento com a tabela pessoa
  JOIN produto prod ON m.id_produto = prod.id_produto -- Relaciona a tabela movimento com a tabela produto
WHERE m.tipo_movimento = 'S'; -- Filtra as movimentações de entrada


--Valor total das entradas agrupadas por produto.
SELECT
  prod.nome_produto PRODUTO,
  SUM(m.quantidade_movimento * m.valor_unitario_mov) AS VALOR_TOTAL_ENTRADAS
FROM
  pessoa p
INNER JOIN movimento m ON p.id_pessoa = m.id_pessoa
INNER JOIN produto prod ON m.id_produto = prod.id_produto
WHERE
  m.tipo_movimento = 'E'
GROUP BY
  prod.nome_produto;


--Valor total das saídas agrupadas por produto.
SELECT
prod.nome_produto AS PRODUTO,
SUM(m.quantidade_movimento * m.valor_unitario_mov) AS VALOR_TOTAL_SAIDAS
FROM
  pessoa p
INNER JOIN movimento m ON p.id_pessoa = m.id_pessoa
INNER JOIN produto prod ON m.id_produto = prod.id_produto
WHERE
  m.tipo_movimento = 'S'
GROUP BY
  prod.nome_produto;
  

--Operadores que não efetuaram movimentações de entrada (compra)
SELECT u.id_usuario, u.login_usuario
FROM usuario u
WHERE u.id_usuario NOT IN (
  SELECT DISTINCT m.id_usuario
  FROM movimento m
  WHERE m.tipo_movimento = 'E'
);

--Valor total de entrada, agrupado por operador.
SELECT
  u.login_usuario OPERADOR,
  SUM(m.quantidade_movimento * m.valor_unitario_mov) AS VALOR_TOTAL_ENTRADAS
FROM
  usuario u
INNER JOIN movimento m ON u.id_usuario = m.id_usuario
WHERE
  m.tipo_movimento = 'E'
GROUP BY
  u.login_usuario;

--Valor total de saída, agrupado por operador.
SELECT
  u.login_usuario OPERADOR,
  SUM(m.quantidade_movimento * m.valor_unitario_mov) AS VALOR_TOTAL_SAIDA
FROM
  usuario u
INNER JOIN movimento m ON u.id_usuario = m.id_usuario
WHERE
  m.tipo_movimento = 'S'
GROUP BY
  u.login_usuario

--Valor médio de venda por produto, utilizando média ponderada.
SELECT 
  prod.nome_produto AS PRODUTO,
  CAST(SUM(m.quantidade_movimento * m.valor_unitario_mov) / SUM(m.quantidade_movimento) AS NUMERIC(18,2)) AS VENDA_MEDIA_PONDERADA 
FROM produto prod
LEFT JOIN movimento m ON prod.id_produto = m.id_produto
WHERE m.tipo_movimento = 'S' 
GROUP BY prod.nome_produto;




