-- =========================================
-- DQL - Consultas úteis
-- =========================================

USE BolValdb;

-------------------------
-- 1. Listar investidores
-------------------------
SELECT * FROM tb_investidor;

------------------------------------------------------------------------------------

------------------------------------
-- 2. Listar ações com suas empresas
------------------------------------
SELECT a.ticker, e.nome_empresa, a.cotacao_atual
FROM tb_acao a
JOIN tb_empresa e ON a.tb_empresa_num_cnpj = e.num_cnpj;

------------------------------------------------------------------------------------

------------------------------------
-- 3. Histórico de cotações por ação
------------------------------------
SELECT tb_acao_ticker, data_hora_cotacao, valor_cotacao
FROM tb_cotacao
ORDER BY tb_acao_ticker, data_hora_cotacao;

------------------------------------------------------------------------------------

----------------------------
-- 4. Negociações realizadas
----------------------------
SELECT i.nome_completo, n.tb_acao_ticker, n.tipo_operacao,
n.quantidade_acoes, n.valor_unitario_acao, n.data_hora_transacao
FROM tb_negocia n
JOIN tb_investidor i ON n.tb_investidor_cod_documento = i.cod_documento;

------------------------------------------------------------------------------------

---------------------------------------------
-- 5. Saldo da carteira por investidor e ação
---------------------------------------------
SELECT
i.nome_completo,
n.tb_acao_ticker,
SUM(
CASE
WHEN n.tipo_operacao = 'C' THEN n.quantidade_acoes
WHEN n.tipo_operacao = 'V' THEN -n.quantidade_acoes
END
) AS saldo_acoes
FROM tb_negocia n
JOIN tb_investidor i ON n.tb_investidor_cod_documento = i.cod_documento
GROUP BY i.nome_completo, n.tb_acao_ticker;

------------------------------------------------------------------------------------

--------------------------------------------------------
-- 6. Valor total da carteira (baseado na cotação atual)
--------------------------------------------------------
SELECT
i.nome_completo,
n.tb_acao_ticker,
SUM(
CASE
WHEN n.tipo_operacao = 'C' THEN n.quantidade_acoes
ELSE -n.quantidade_acoes
END
) * a.cotacao_atual AS valor_total
FROM tb_negocia n
JOIN tb_investidor i ON n.tb_investidor_cod_documento = i.cod_documento
JOIN tb_acao a ON n.tb_acao_ticker = a.ticker
GROUP BY i.nome_completo, n.tb_acao_ticker;

------------------------------------------------------------------------------------

-----------------------------------------------
-- 7. Preço médio de compra por investidor/ação
-----------------------------------------------
SELECT
i.nome_completo,
n.tb_acao_ticker,
AVG(n.valor_unitario_acao) AS preco_medio
FROM tb_negocia n
JOIN tb_investidor i ON n.tb_investidor_cod_documento = i.cod_documento
WHERE n.tipo_operacao = 'C'
GROUP BY i.nome_completo, n.tb_acao_ticker;

------------------------------------------------------------------------------------

---------------------------------
-- 8. Última cotação de cada ação
---------------------------------
SELECT c.tb_acao_ticker, c.valor_cotacao, c.data_hora_cotacao
FROM tb_cotacao c
WHERE (c.tb_acao_ticker, c.data_hora_cotacao) IN (
SELECT tb_acao_ticker, MAX(data_hora_cotacao)
FROM tb_cotacao
GROUP BY tb_acao_ticker
);
