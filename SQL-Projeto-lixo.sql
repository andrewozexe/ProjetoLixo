drop database if exists coletaLixo;
create database coletaLixo;
use coletaLixo;

create table TBempresa(
    cnpj char (14) primary key,
    tipoEmpresa varchar(100)
);

create table TBendereco(
    cod int primary key,
    rua varchar(100),
    bairro varchar(50),
    numero varchar(6),
    cidade varchar(60),
    UF char(2)
);

create table TBpessoa(
    cpf char (11) primary key,
    nome varchar(100),
    dataNascimento date,
    endereço int , /* Fazer tabela */
    cnpj char (14),
    foreign key (cnpj) references TBempresa(cnpj),
    foreign key (endereço) references  TBendereco(cod)
);

create table TBperiodo(
    cod_periodo int primary key,
    periodo varchar(15)
);

create table TBlixeiro(
    cpf char (11),
    salário double,
    período int,
    horasTrabalhadas int,
    foreign key (cpf) references TBpessoa(cpf),
    foreign key (período) references TBperiodo(cod_periodo)
);

create table TBmeiomanipulação(
    cod int primary key,
    tempo int,
    tipo varchar(100),
    custo double,
    AQI int
);

create table TBlixo(
    codTipo int primary key,
    tipo varchar(100),
    valorKG int,
    cod int,
    foreign key (cod) references TBmeiomanipulação(cod)
);

create table TBcatadores(
    cpf char (11),
    valorKG int,
    tipoLixo int,
    foreign key (cpf) references TBpessoa(cpf),
    foreign key (tipoLixo) references TBlixo(codTipo)
);

create table TBregião(
    cod int primary key,
    bairro varchar(100),
    rua varchar(100)
);

create table TBcoleta(
    cod int primary key,
    dData date,
    custo double,
    cpf char (11),
    cnpj char (14),
    região int,
    quantidade int, /*KG*/
    foreign key (cpf) references TBpessoa(cpf),
    foreign key (cnpj) references TBempresa(cnpj),
    foreign key (região) references TBregião(cod)
);

create table TBdestino(
    codDestino int primary key,
    endereço int,
    lLocal varchar(100),
    foreign key (endereço) references TBendereco(cod)
);

create table TBlixodestino(
    codChegada int primary key,
    horaChegada time,
    codDestino int,
    codTipo int,
    codColeta int,
    foreign key (codDestino) references TBdestino(codDestino),
    foreign key (codTipo) references TBlixo(codTipo),
    foreign key (codColeta) references TBcoleta(cod)
);

/*TBempresa*/
INSERT INTO TBempresa (cnpj, tipoEmpresa)
VALUES ('62591517000150', 'Sociedade Empresária Limitada – LTDA');
INSERT INTO TBempresa (cnpj, tipoEmpresa)
VALUES ('65587772000117', 'Sociedade Anônima – S/A');
INSERT INTO TBempresa (cnpj, tipoEmpresa)
VALUES ('80719452000167', 'Sociedade Limitada Unipessoal – SLU');

INSERT INTO TBendereco(cod, rua, numero, cidade, UF)
VALUES (1,'Avenida Presidente Getúlio Vargas', '88888', 'Curitiba', 'PR');
INSERT INTO TBendereco(cod, rua,  numero, cidade, UF)
VALUES (2, 'Rua das Flores','20212', 'Curitiba', 'PR');
INSERT INTO TBendereco(cod, rua, numero, cidade, UF)
VALUES (3, 'Rua Bento Viana','666', 'Curitiba', 'PR');
INSERT INTO TBendereco(cod, rua, numero, cidade, UF)
VALUES (4, 'Avenida República Argentina','2751', 'Curitiba', 'PR');
INSERT INTO TBendereco(cod, rua, numero, cidade, UF)
VALUES (5, 'Rua Coronel Dulcídio','1234', 'Curitiba', 'PR');
INSERT INTO TBendereco(cod, rua, numero, cidade, UF)
VALUES (6, 'Campo de Santana','00000', 'Curitiba', 'PR');
INSERT INTO TBendereco(cod, rua, numero, cidade, UF)
VALUES (7, 'R. Lamenha Lins','15156', 'Curitiba', 'PR');
INSERT INTO TBendereco(cod, rua, numero, cidade, UF)
VALUES (8, 'Rua Antônio Gai','321', 'Curitiba', 'PR');
INSERT INTO TBendereco(cod, rua, numero, cidade, UF)
VALUES (9, 'R. Cel. Herculano de Araújo','12', 'Curitiba', 'PR');

/*TBpessoa*/
INSERT INTO TBpessoa (cpf, nome, dataNascimento, endereço, cnpj)
VALUES ('18037456579', 'João', '1991-10-20', 1, '62591517000150');
INSERT INTO TBpessoa (cpf, nome, dataNascimento, endereço, cnpj)
VALUES ('27563286691', 'Lucas', '1993-12-14', 2, '62591517000150');
INSERT INTO TBpessoa (cpf, nome, dataNascimento, endereço, cnpj)
VALUES ('17171356922', 'Maria', '1990-01-05', 3, '65587772000117');
INSERT INTO TBpessoa (cpf, nome, dataNascimento, endereço, cnpj)
VALUES ('16170844507', 'Lucia', '1994-07-30', 4, '80719452000167');
INSERT INTO TBpessoa (cpf, nome, dataNascimento, endereço, cnpj)
VALUES ('45012131592', 'Marco', '1996-03-18', 5, '65587772000117');

/*TBPeriodo*/
INSERT INTO TBperiodo(cod_periodo, periodo) VALUES (1, 'Manhã');
INSERT INTO TBperiodo(cod_periodo, periodo) VALUES (2, 'Tarde');
INSERT INTO TBperiodo(cod_periodo, periodo) VALUES (3, 'Noite');

/*TBlixeiro*/
INSERT INTO TBlixeiro (cpf, salário, período, horasTrabalhadas)
VALUES ('27563286691', 1600, 3, 8);
INSERT INTO TBlixeiro (cpf, salário, período, horasTrabalhadas)
VALUES ('18037456579', 2000, 1, 8);
INSERT INTO TBlixeiro (cpf, salário, período, horasTrabalhadas)
VALUES ('16170844507', 1600, 3, 8);

/*TBmeiomanipualção*/
INSERT INTO TBmeiomanipulação (cod, tempo, tipo, custo, AQI)
VALUES (1, 1, 'Reciclagem', 0.01, 53);
INSERT INTO TBmeiomanipulação (cod, tempo, tipo, custo, AQI)
VALUES (2, 8760 , 'Aterros sanitários', 3300000, 200);
INSERT INTO TBmeiomanipulação (cod, tempo, tipo, custo, AQI)
VALUES (3, 72, 'Compostagem', 65.00, 35);
INSERT INTO TBmeiomanipulação (cod, tempo, tipo, custo, AQI)
VALUES (4, 4, 'Incineração', 0.42, 270);

/*TBlixo*/
INSERT INTO TBlixo (codTipo, tipo, valorKG, cod) 
VALUES (1, 'Reciclavél', 3.20, 1);
INSERT INTO TBlixo (codTipo, tipo, valorKG, cod)
VALUES (2, 'Orgânico', 0.00, 2);
INSERT INTO TBlixo (codTipo, tipo, valorKG, cod)
VALUES (3, 'Lixo Comecial', 0.50, 2);
INSERT INTO TBlixo (codTipo, tipo,  valorKG, cod)
VALUES (4, 'Lixo Hospitalar', 0.00, 4);
INSERT INTO TBlixo (codTipo, tipo, valorKG, cod)
VALUES (5, 'Orgânico Aliemtos', 0.00, 3);

/*TBCatadores*/
INSERT INTO TBCatadores (cpf, tipolixo, valorKG) 
VALUES ('17171356922', 1, 3.20);
INSERT INTO TBCatadores (cpf, tipolixo, valorKG) 
VALUES ('45012131592', 1, 3.50);

/*TBRegião*/
INSERT INTO TBRegião (cod, bairro, rua) 
VALUES (1, 'Portão', 'Avenida República Argentina');
INSERT INTO TBRegião (cod, bairro, rua) 
VALUES (2, 'Água Verde', 'Monsenhor Manoel Vicente');
INSERT INTO TBRegião (cod, bairro, rua) 
VALUES (3, 'Centro', 'Rua Alferes Poli');
INSERT INTO TBRegião (cod, bairro, rua) 
VALUES (4, 'Vila Izabel', 'Avenida Iguaçu');
INSERT INTO TBRegião (cod, bairro, rua) 
VALUES (5, 'Centro', 'Rua André de Barros');

/*TBcoleta*/
INSERT INTO TBcoleta (cod,dData, custo, cpf, cnpj, região, quantidade)
VALUES (1,'2022-09-17', 95, '17171356922','65587772000117', 1, 50);
INSERT INTO TBcoleta (cod,dData, custo, cpf, cnpj, região, quantidade)
VALUES (2,'2022-08-15', 389, '27563286691','62591517000150', 4, 500);
INSERT INTO TBcoleta (cod,dData, custo, cpf, cnpj, região, quantidade)
VALUES (3,'2022-09-19', 3456.68, '16170844507','80719452000167', 3, 1000);
INSERT INTO TBcoleta (cod,dData, custo, cpf, cnpj, região, quantidade)
VALUES (4,'2022-10-11', 100, '18037456579','62591517000150', 1, 300);
INSERT INTO TBcoleta (cod,dData, custo, cpf, cnpj, região, quantidade)
VALUES (5,'2022-09-27', 400, '45012131592','65587772000117', 5, 60);
INSERT INTO TBcoleta (cod,dData, custo, cpf, cnpj, região, quantidade)
VALUES (6,'2022-08-10', 120, '17171356922','65587772000117', 2, 20);

/*TBdestino*/
INSERT INTO TBdestino (codDestino, endereço, lLocal) 
VALUES (1, 6, 'Curitiba'); /*Aterro Caximba*/
INSERT INTO TBdestino (codDestino, endereço, lLocal) 
VALUES (2, 7, 'Centro'); /*Eco Recicla Ambiental*/
INSERT INTO TBdestino (codDestino, endereço, lLocal) 
VALUES (3, 8, 'Tatuquara');  /*Ambserv Tratamento de Resíduos*/
INSERT INTO TBdestino (codDestino, endereço, lLocal) 
VALUES (4, 9, 'Novo Mundo'); /*Reciclagem Carpel*/

/*TBlixodestino*/
INSERT INTO TBlixodestino (codChegada, codDestino, codTipo, codColeta,horaChegada)
VALUES (1, 2, 1 , 1, '18:30:00');
INSERT INTO TBlixodestino (codChegada, codDestino, codTipo, codColeta, horaChegada)
VALUES (2, 4, 1 , 2, '02:45:02');
INSERT INTO TBlixodestino (codChegada, codDestino, codTipo, codColeta, horaChegada)
VALUES (3, 3, 4 , 3, '23:52:45');
INSERT INTO TBlixodestino (codChegada, codDestino, codTipo, codColeta, horaChegada)
VALUES (4, 4, 2 , 4, '15:20:58');
INSERT INTO TBlixodestino (codChegada, codDestino, codTipo, codColeta, horaChegada)
VALUES (5, 1, 1 , 5, '20:00:00');
INSERT INTO TBlixodestino (codChegada, codDestino, codTipo, codColeta, horaChegada)
VALUES (6 ,3, 3 , 6, '22:16:00');


/* INFORMACAO 4 - Qual tipo de lixo mais coletado.*/
SELECT TBlixo.tipo, COUNT(TBlixodestino.codTipo) AS FREQ
FROM TBlixo, TBlixodestino
WHERE TBlixo.codTipo = TBlixodestino.codTipo
GROUP BY TBlixo.tipo
ORDER BY COUNT(TBlixodestino.codTipo) DESC
LIMIT 1;

/* INFORMACAO 7 - Qual região mais produz lixo?.*/
SELECT TBregião.rua, TBregião.bairro
FROM TBregião, TBcoleta, TBlixodestino
WHERE TBcoleta.cod = TBlixodestino.codColeta
	AND TBregião.cod = TBcoleta.região
	AND TBcoleta.quantidade IN( SELECT MAX(quantidade)
								FROM TBcoleta)
LIMIT 1;



/* INFORMACAO 8 - Qual o meio de manipulação que demora mais tempo para o lixo ser processado?.*/
SELECT tipo
FROM TBmeiomanipulação
WHERE tempo IN (SELECT MAX(tempo)
				FROM TBmeiomanipulação);
                
/* INFORMACAO 9 - Qual meio de manipulação mais caro?.*/
SELECT tipo
FROM TBmeiomanipulação
WHERE custo IN (SELECT MAX(custo)
				FROM TBmeiomanipulação);


/* INFORMACAO 10 - Quantidade (em Kg) de lixo que é levado para aterros?.*/
SELECT SUM(TBcoleta.quantidade), 'Kg'
FROM TBcoleta, TBlixodestino, TBdestino
WHERE TBcoleta.cod = TBlixodestino.codColeta
	AND TBdestino.codDestino = TBlixodestino.codDestino
    AND TBlixodestino.codDestino = 1;


/* INFORMACAO 11 - Quanto lixo hospitalar é produzido?.*/
SELECT SUM(TBcoleta.quantidade),'Kg'
FROM TBcoleta, TBlixodestino
WHERE TBcoleta.cod = TBlixodestino.codColeta
    AND TBlixodestino.codTipo = 4;
    
/* INFORMACAO 12 - Qual a média salárial dos lixeiros?.*/
SELECT 'R$', CEILING(AVG(salário))
FROM TBlixeiro;

/* INFORMACAO 13 - Qual número de lixeiros contratados?.*/
SELECT COUNT(*)
FROM TBlixeiro;

/* INFORMACAO 14 - Qual dia de coleta tem mais lixo?*/
SELECT DAY(dData)
FROM TBcoleta
WHERE quantidade IN (SELECT MAX(quantidade)
		FROM TBcoleta)
LIMIT 1;

/* INFORMACAO 15 - Qual mês é produzido mais lixo */
SELECT MONTH(dData)
FROM TBcoleta
WHERE quantidade IN (SELECT MAX(quantidade)
		FROM TBcoleta)
LIMIT 1;

/* INFORMACAO 16 - De onde vem mais lixo comercial?*/
SELECT TBregião.rua, TBregião.bairro
FROM TBregião, TBcoleta, TBlixodestino
WHERE TBcoleta.cod = TBlixodestino.codColeta
	AND TBregião.cod = TBcoleta.região
	AND TBlixodestino.codTipo = 3
LIMIT 1;

/* INFORMACAO 17 - Quantas empresas de coleta estão cadastradas e quais seus nomes?.*/
SELECT tipoEmpresa, COUNT(tipoEmpresa)
FROM TBempresa
GROUP BY tipoEmpresa;

/* INFORMACAO 18 - Destino do lixo orgânico?.*/
SELECT TBdestino.endereço, TBmeiomanipulação.tipo
FROM TBdestino, TBmeiomanipulação, TBlixodestino, TBlixo
WHERE TBdestino.codDestino = TBlixodestino.codDestino
	AND TBlixo.codTipo = TBlixodestino.codTipo
    AND TBlixo.cod = TBmeiomanipulação.cod
    AND TBlixo.codTipo = 2;
    
/* INFORMACAO 19 - Qual a quantidade de lixo incinerado?.*/
SELECT SUM(TBcoleta.quantidade), 'Kg'
FROM TBcoleta, TBlixodestino, TBdestino
WHERE TBcoleta.cod = TBlixodestino.codColeta
	AND TBdestino.codDestino = TBlixodestino.codDestino
    AND TBdestino.codDestino = 3;

/* INFORMACAO 20 - Média de idade catadores de lixo?.*/
/*SELECT (DATEDIFF(year, TBpessoa.dataNascimento, '2002-08-22'))
FROM TBpessoa, TBCatadores
WHERE TBpessoa.cpf = TBCatadores.cpf;*/;

/* INFORMACAO 21 - Quanto é gasto em reciclagem nas coletas?.*/
SELECT 'R$', SUM(TBcoleta.custo)
FROM TBcoleta, TBlixo, TBlixodestino
WHERE TBcoleta.cod = TBlixodestino.codColeta
	AND TBlixo.codTipo = TBlixodestino.codTipo
    AND TBlixo.codTipo = 1;

/* INFORMACAO 22 - Qual o lixo mais poluente?.*/
SELECT TBmeiomanipulação.tipo, TBmeiomanipulação.AQI, TBlixo.tipo
FROM TBmeiomanipulação, TBlixo
WHERE TBmeiomanipulação.cod = TBlixo.cod
	AND AQI > 200
GROUP BY TBmeiomanipulação.tipo
LIMIT 1;


