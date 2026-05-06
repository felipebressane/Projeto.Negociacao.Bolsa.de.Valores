-- =========================================
-- DML - Inserts de dados
-- =========================================

USE BolValdb;

-------------
-- tb_empresa
-------------
INSERT INTO tb_empresa (num_cnpj, nome_empresa, setor_atuacao, valor_mercado) VALUES
('12345678000101', 'Tech Solutions SA', 'Tecnologia', 15000000.00),
('98765432000199', 'Banco Forte SA', 'Financeiro', 32000000.00),
('11122233000155', 'Energia Brasil', 'Energia', 21000000.00);

------------------------------------------------------------------------------------

----------
-- tb_acao
----------
INSERT INTO tb_acao (ticker, tb_empresa_num_cnpj, cotacao_atual) VALUES
('TSOL3', '12345678000101', 25.50),
('BFOR3', '98765432000199', 18.75),
('ENBR3', '11122233000155', 32.10);

------------------------------------------------------------------------------------

----------------
-- tb_investidor
----------------
INSERT INTO tb_investidor (cod_documento, nome_completo, tipo_investidor, numero_telefone, email) VALUES
('11111111111', 'João Silva', 'PF', '11999999999', '[joao@email.com](mailto:joao@email.com)'),
('22222222222', 'Maria Souza', 'PF', '11988888888', '[maria@email.com](mailto:maria@email.com)'),
('33333333000100', 'InvestCorp Ltda', 'PJ', '1133333333', '[contato@investcorp.com](mailto:contato@investcorp.com)');

------------------------------------------------------------------------------------

-------------
-- tb_cotacao
-------------
INSERT INTO tb_cotacao (tb_acao_ticker, data_hora_cotacao, valor_cotacao) VALUES
('TSOL3', '2026-04-01 10:00:00', 25.00),
('TSOL3', '2026-04-01 12:00:00', 25.50),
('BFOR3', '2026-04-01 10:00:00', 18.50),
('ENBR3', '2026-04-01 10:00:00', 31.80);


------------------------------------------------------------------------------------

---
-- tb_negocia
---
INSERT INTO tb_negocia (tb_investidor_cod_documento, tb_acao_ticker, tipo_operacao, quantidade_acoes, valor_unitario_acao, data_hora_transacao) VALUES
('11111111111', 'TSOL3', 'C', 100, 25.00, '2026-04-01 10:05:00'),
('11111111111', 'TSOL3', 'V', 40, 25.50, '2026-04-01 12:10:00'),
('22222222222', 'BFOR3', 'C', 200, 18.50, '2026-04-01 10:15:00'),
('33333333000100', 'ENBR3', 'C', 150, 31.80, '2026-04-01 10:20:00');
