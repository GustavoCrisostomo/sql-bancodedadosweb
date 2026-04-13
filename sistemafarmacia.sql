
-- CRIA UM BANCO DE DADOS chamado farmacianova
CREATE DATABASE farmacianova;

-- SELECIONA o banco que será usado
USE farmacianova;


-- CRIA A TABELA farmacia com suas colunas
CREATE TABLE farmacia (
    cnpj VARCHAR(14) PRIMARY KEY, -- chave primária (identificador único)
    telefone VARCHAR(11) NOT NULL, -- campo obrigatório
    nomefarmacia VARCHAR(255) NOT NULL, -- nome da farmácia
    rua VARCHAR(255) NOT NULL, -- rua do endereço
    numero CHAR(8) NOT NULL, -- número do endereço
    complemento VARCHAR(200), -- complemento (opcional)
    bairro VARCHAR(100) NOT NULL, -- bairro
    cidade VARCHAR(100) NOT NULL, -- cidade
    estado CHAR(2) NOT NULL, -- estado (ex: SP)
    CEP VARCHAR(8) NOT NULL -- CEP
);


-- CRIA A TABELA farmaceutico
CREATE TABLE farmaceutico (
    rg INT PRIMARY KEY, -- chave primária do farmacêutico
    nomefarmaceutico VARCHAR(255) NOT NULL, -- nome do farmacêutico
    cnpj_farmacia VARCHAR(14), -- ligação com a farmácia

    -- cria relacionamento com a tabela farmacia
    FOREIGN KEY (cnpj_farmacia)
        REFERENCES farmacia(cnpj)
);


-- CRIA A TABELA produto
CREATE TABLE produto (
    codproduto INT AUTO_INCREMENT PRIMARY KEY, -- código automático
    quantproduto INT NOT NULL, -- quantidade em estoque
    valorproduto DECIMAL(10,2) NOT NULL, -- preço do produto
    cnpj_farmacia VARCHAR(14), -- qual farmácia pertence

    -- chave estrangeira ligando com farmacia
    FOREIGN KEY (cnpj_farmacia)
        REFERENCES farmacia(cnpj)
);


-- ALTERA O NOME DA COLUNA "estado" para "UF"
ALTER TABLE farmacia
CHANGE estado UF CHAR(2) NOT NULL;


-- INSERE UM REGISTRO NA TABELA farmacia
INSERT INTO farmacia (
  cnpj, telefone, nomefarmacia, rua, numero, complemento,
  bairro, cidade, UF, CEP
) VALUES (
  '12345678000199',
  '11987654321',
  'Farmácia Saúde Total',
  'Rua das Flores',
  '120',
  'Próximo ao hospital',
  'Centro',
  'São Paulo',
  'SP',
  '01001000'
);


-- INSERE VÁRIOS REGISTROS AO MESMO TEMPO
INSERT INTO farmacia VALUES
('98765432000188','11991234567','Farmácia Bem Viver','Avenida Paulista','1500','Loja 12','Bela Vista','São Paulo','SP','01310000'),
('45678912000177','1133445566','Farmácia Popular','Rua Independência','350',NULL,'Jardim América','Campinas','SP','13020010'),
('32165498000166','1140098877','Farmácia Vida e Saúde','Rua Rio Branco','890','Esquina com a praça','Centro','Santos','SP','11013001');


-- INSERE DADOS NA TABELA farmaceutico
INSERT INTO farmaceutico VALUES
(123456789,'Carlos Henrique Almeida','12345678000199'),
(987654321,'Fernanda Souza Lima','98765432000188');


-- INSERE PRODUTOS (AUTO_INCREMENT cria o código sozinho)
INSERT INTO produto (quantproduto, valorproduto, cnpj_farmacia) VALUES
(50,12.90,'12345678000199'),
(30,25.50,'98765432000188'),
(100,8.75,'45678912000177'),
(20,45.00,'32165498000166');


-- INSERE MAIS UM PRODUTO
INSERT INTO produto (quantproduto, valorproduto, cnpj_farmacia)
VALUES (25,45.40,'32165498000166');


-- ATUALIZA UM DADO NA TABELA farmacia
UPDATE farmacia
SET telefone = '11999998888' -- novo valor
WHERE cnpj = '12345678000199'; -- condição


-- ATUALIZA DOIS CAMPOS NA TABELA produto
UPDATE produto
SET quantproduto = 80, -- nova quantidade
    valorproduto = 14.50 -- novo preço
WHERE codproduto = 1;


-- SELECIONA TODOS OS DADOS DA TABELA
SELECT * FROM farmacia;


-- SELECIONA COM FILTRO (WHERE)
SELECT * FROM farmacia
WHERE cidade = 'São Paulo';


-- FILTRO COM AND (duas condições)
SELECT * FROM farmacia
WHERE cidade = 'São Paulo' AND UF = 'SP';


-- FILTRO COM OR (uma ou outra condição)
SELECT * FROM farmacia
WHERE cidade = 'São Paulo' OR cidade = 'Campinas';


-- SELECIONA APENAS UMA COLUNA
SELECT telefone
FROM farmacia
WHERE cidade = 'São Paulo' OR cidade = 'Campinas';


-- BETWEEN = ENTRE DOIS VALORES
SELECT * FROM produto
WHERE valorproduto BETWEEN 10.00 AND 30.00;


-- MAIOR QUE
SELECT * FROM produto
WHERE valorproduto > 20.00;


-- IGUAL
SELECT * FROM produto
WHERE valorproduto = 45.40;


-- MENOR OU IGUAL
SELECT * FROM produto
WHERE valorproduto <= 50;


-- COMBINAÇÃO DE CONDIÇÕES
SELECT * FROM produto
WHERE valorproduto > 10.00 AND valorproduto <= 30.00;


-- LIKE = BUSCA POR TEXTO
SELECT * FROM farmacia
WHERE nomefarmacia LIKE 'Farmácia%'; -- começa com

SELECT * FROM farmacia
WHERE nomefarmacia LIKE '%Vida%'; -- contém


-- ORDER BY = ORDENAÇÃO
SELECT * FROM produto
ORDER BY valorproduto ASC; -- crescente

SELECT * FROM produto
ORDER BY valorproduto DESC; -- decrescente


-- LIMIT = LIMITA QUANTIDADE DE RESULTADOS
SELECT * FROM produto
WHERE valorproduto > 20.00
ORDER BY valorproduto DESC
LIMIT 1;


-- JOIN = JUNTA TABELAS
SELECT * FROM farmacia
JOIN produto
ON farmacia.cnpj = produto.cnpj_farmacia;


-- INNER JOIN = JUNÇÃO COM RELAÇÃO
SELECT * FROM farmacia
INNER JOIN farmaceutico
ON farmacia.cnpj = farmaceutico.cnpj_farmacia;


-- JOIN COM FILTRO
SELECT nomefarmacia, nomefarmaceutico
FROM farmacia
INNER JOIN farmaceutico
ON farmacia.cnpj = farmaceutico.cnpj_farmacia
WHERE farmacia.cidade = 'São Paulo';


-- JOIN COM ORDENAÇÃO
SELECT nomefarmacia, valorproduto
FROM farmacia
INNER JOIN produto
ON farmacia.cnpj = produto.cnpj_farmacia
ORDER BY valorproduto ASC;


-- DELETE = REMOVE DADOS
DELETE FROM produto
WHERE codproduto = 4;


-- DROP TABLE = APAGA TABELA
DROP TABLE farmaceutico;
DROP TABLE produto;
DROP TABLE farmacia;


-- DROP DATABASE = APAGA O BANCO INTEIRO
DROP DATABASE farmacianova;

-- criando novo usuário no banco de dados
CREATE USER 'usuario_farmacia'@'localhost'
IDENTIFIED BY 'senha123';
 
--Concedendo permissões - total
GRANT ALL PRIVILEGES
ON farmacianova.*
TO 'usuario_farmacia'@'localhost';
 
--Concedendo permissões - apenas de leitura
GRANT SELECT
ON farmacianova.*
TO 'usuario_farmacia'@'localhost';

--Concedendo permissões especificas
GRANT SELECT, INSERT 
ON farmacianova.*
TO 'usuario_farmacia'@'localhost';

--Revogando permissões de um usuário 
REVOKE INSERT
ON farmacianova.*
FROM 'usuario_farmacia'@'localhost';

-- Revogando todas as permissões do usuário
REVOKE ALL PRIVILEGES 
ON farmacianova.*
FROM 'usuario_farmacia'@'localhost';

--Excluindo usuário 
DROP USER 'usuario_farmacia'@'localhost'