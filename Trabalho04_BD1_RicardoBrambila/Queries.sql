-- 1 - Listar os nomes dos rуtulos, temperatura mнnima, temperatura mбxima, a diferenзa de temperatura mбxima e mнnima e data de validade.

SELECT nome, temperatura_minima, temperatura_maxima, (temperatura_maxima - temperatura_minima) as diferenca_temperatura, validade from Rotulo;

-- 2 - Listar nome, identidade e data de nascimento da pessoa com cpf igual a '01234567891'.

SELECT nome, identidade, nascimento from Pessoa where cpf='01234567891';

-- 3 - Remover a pessoa com cpf igual a '01234567891'.

DELETE FROM Pessoa where cpf = '01234567891';

-- 4 - Listar o nome, temperatura mнnima, temperatura mбxima, data de validade dos rуtulos alйm do nome do estilo produzidos pela cervejaria 'Bohemia'.

SELECT r.nome, r.temperatura_minima, r.temperatura_maxima, r.validade, e.nome from Rotulo r, Estilo e, Cervejaria c where r.estilo_cod = e.codigo and r.cervejaria_cod = c.codigo and c.nome = 'Bohemia';

-- 5 - Listar o nome do rуtulo, o nome da cervejaria que o produz, o nome do paнs de origem e o nome dos paнses onde o rуtulo й produzido cuja a temperatura mнnima estб entre 0 e 10 graus. Utilizar a clбusula INNER JOIN para responder este item.

select r.nome as nome_rotulo, c.nome cervejaria_nome, po.nome pais_origem, pp.nome pais_producao from Rotulo r INNER JOIN Cervejaria c ON r.cervejaria_cod = c.codigo INNER JOIN Pais po ON r.pais_origem_cod = po.codigo INNER JOIN Rotulo_Pais_Producao rpp ON r.codigo = rpp.rotulo_codigo INNER JOIN Pais pp ON rpp.pais_cod = pp.codigo AND r.temperatura_minima BETWEEN 0 AND 10;

-- 6 - Listar o nome de todos os paнses, o nome dos rуtulos que tem origem no paнs e o nome da cervejaria do rуtulo. Os paнses que nгo possuem rуtulos originados neles tambйm devem ser listados.

SELECT p.nome pais_nome, r.nome rotulo_nome, c.nome cervejaria_nome FROM Pais p LEFT JOIN Rotulo r ON p.codigo = r.pais_origem_cod INNER JOIN Cervejaria c ON r.cervejaria_cod = c.codigo ;

-- 7 - Listar o nome de todos os paнses que tiveram rуtulos originados nos mesmos. Utilizar o operador IN para responder a esta consulta.

SELECT p.nome from Pais p where p.codigo IN (SELECT r.pais_origem_cod from Rotulo r);

-- 8 - Reescrever a consulta do item 7 empregando EXISTS.

SELECT p.nome from Pais p where EXISTS (SELECT r.pais_origem_cod from Rotulo r where p.codigo = r.pais_origem_cod);

-- 9 - Listar todos os rуtulos cuja temperatura mбxima й igual a temperatura mбxima dos rуtulos cadastrados na base de dados.

SELECT nome from Rotulo r, Rotulo rr where r.temperatura_minima = rr.temperatura_maxima;

-- 10 - Listar a combinaзгo de temperaturas mнnima e mбxima existentes na base e quantidade de rуtulos que tкm esta combinaзгo.

SELECT DISTINCT r.temperatura_minima, r.temperatura_maxima, COUNT(*) from rotulo r GROUP BY r.temperatura_minima, r.temperatura_maxima;

-- 11 - Listar o nome de todos rуtulos cuja temperatura mбxima й maior do 6 graus.

SELECT r.nome from Rotulo r where r.temperatura_maxima > 6;

-- 12 - Listar o nome e o cpf das pessoas que sгo proprietбrias de algum estabelecimento. Utilizar o operador IN ou EXISTS para resolver esta consulta.

SELECT p.nome, p.cpf from Pessoa p where p.codigo IN (SELECT prop.pessoa_cod from Propriedade prop);

-- 14 - Listar o nome dos restaurantes que vendem rуtulos com o maior teor alcoуlico existente na base de dados e que comeзam com "B".

SELECT e.nome from rotulo_estabelecimento re, rotulo r, estabelecimento e WHERE r.codigo = re.rotulo_codigo AND re.estabelecimento_cod = e.codigo AND r.teor_alcoolico = ( SELECT MAX(rr.teor_alcoolico) from rotulo rr) AND r.nome like 'C%'

-- 15 - Listar o nome das pessoas que sгo proprietбrias de estabelecimentos, mas que nгo trabalham em nenhum estabelecimento.

SELECT p.nome from Pessoa p INNER JOIN Propriedade prop on p.codigo = prop.pessoa_cod AND p.codigo not in (SELECT t.pessoa_cod from Trabalha t);

-- 16 - Retornar o nome dos estabelecimentos que vendem mais do que 10 rуtulos diferentes.

SELECT e.nome, count(*) qtd_rotulos from Estabelecimento e INNER JOIN Rotulo_Estabelecimento re on e.codigo = re.estabelecimento_cod AND (SELECT COUNT(*) from Rotulo_Estabelecimento rere where e.codigo = rere.estabelecimento_cod) > 1 GROUP BY e.nome;

-- 17 - Recuperar o nome do estabelecimento, a faixa de preзo do estabelecimento, a quantidade de rуtulos vendidos pelo estabelecimento que tкm mais do que 2 sommelier. Apresentar o resultado ordenado pela quantidade de rуtulos vendidos.

SELECT e.nome nome_estabelecimento, COUNT(*) qtd_rotulos_vendidos from rotulo_estabelecimento re LEFT JOIN estabelecimento e on re.estabelecimento_cod = e.codigo GROUP BY e.codigo HAVING (SELECT COUNT(*) from trabalha t WHERE t.estabelecimento_cod = e.codigo AND funcao_cod = (SELECT f.codigo FROM funcao f WHERE f.nome = 'Garçom' )) = 0;
