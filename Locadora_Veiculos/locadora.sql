CREATE DATABASE IF NOT EXISTS Locadora_de_veiculos
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
use Locadora_de_veiculos;

-- Criaçao da tabela cliente
CREATE TABLE IF NOT EXISTS Cliente (
	id INT AUTO_INCREMENT PRIMARY KEY,
	cpf varchar(20) unique,
    nome varchar(50),
    telefone varchar(20),
    email varchar(50),
    endereco varchar(100)
     );
-- Criaçao da tabela Pagamento    
CREATE TABLE IF NOT EXISTS Pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Forma ENUM('cartao', 'pix', 'dinheiro'),
    Data_Do_Pagamento DATE,
    Valor_total DECIMAL(7 , 2 ),
    estado ENUM('pago', 'pendente')
);
-- Criaçao da tabela locação
CREATE TABLE IF NOT EXISTS Locacao(
    id INT AUTO_INCREMENT PRIMARY KEY,
    Cliente_ID INT,
    Pagamento_ID INT,
	Data_Inicial date,
    Data_fim date,
    FOREIGN KEY (Cliente_ID) references Cliente(ID),
	FOREIGN KEY (Pagamento_ID) references Pagamento(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    );
-- Criaçao da tabela veiculo   
CREATE TABLE IF NOT EXISTS Veiculo(
    id INT AUTO_INCREMENT PRIMARY KEY,
    modelo varchar(50),
    marca varchar(50),
    ano int,
    placa varchar(100),
    valor_Diaria decimal (7,2),
    estado enum ( 'disponivel' , 'alugado' , 'manutencao')
    );
-- Criaçao da tabela locação dos veiculos
CREATE TABLE IF NOT EXISTS Locacao_Veiculo(
    id INT AUTO_INCREMENT PRIMARY KEY,
    Locacao_ID int,
    Veiculo_ID int,
    FOREIGN KEY (Locacao_ID) references Locacao(ID),
    FOREIGN KEY (Veiculo_ID) references Veiculo(ID)
  ON UPDATE CASCADE
  ON DELETE CASCADE
    );
-- Criaçao da tabela manutenção
CREATE TABLE IF NOT EXISTS Manutencao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Veiculo_ID INT,
    Descricao VARCHAR(100),
    Data_Manutencao DATE,
    Custo DECIMAL(7 , 2 ),
    FOREIGN KEY (Veiculo_ID) REFERENCES Veiculo (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);  
-- Inserindo dados nas tabelas
    INSERT IGNORE INTO Cliente (cpf, nome, telefone, email, endereco) VALUES
('123.456.789-00', 'Carlos Eduardo', '11999998888', 'carlos@email.com', 'Rua A, 123'),
('987.654.321-00', 'Ana Silva', '11888887777', 'ana@email.com', 'Av B, 456');

INSERT INTO Pagamento (Forma, Data_Do_Pagamento, Valor_total, estado) VALUES
('pix', '2025-04-05', 150.00, 'pago'),
('dinheiro', '2025-04-07', 220.00, 'pendente');

INSERT INTO Locacao (Cliente_ID, Pagamento_ID, Data_Inicial, Data_fim) VALUES
(1, 1, '2025-04-08', '2025-04-12'),
(2, 2, '2025-04-10', '2025-04-15');

INSERT INTO Veiculo (modelo, marca, ano, placa, valor_Diaria, estado) VALUES
('Onix', 'Chevrolet', 2020, 'ABC-1234', 50.00, 'disponivel'),
('HB20', 'Hyundai', 2021, 'DEF-5678', 60.00, 'alugado');

INSERT INTO Locacao_Veiculo (Locacao_ID, Veiculo_ID) VALUES
(1, 2),
(2, 1);

INSERT INTO Manutencao (Veiculo_ID, Descricao, Data_Manutencao, Custo) VALUES
(1, 'Troca de óleo', '2025-03-20', 120.50),
(2, 'Alinhamento', '2025-03-28', 80.00);

-- Lista todas as manutenções realizadas, exibindo a descrição, data e custo,
-- ordenadas do menor para o maior custo 
select Descricao , Data_Manutencao , custo
from manutencao 
order BY custo ASC;

-- Lista para saber o valor total pago
select sum(Valor_Total) as Valor_Arrecadado
from pagamento 
where estado = 'pago';

-- Lista para saber o modelo , a marca do carro e a quantidade de alugueis dele.
select 
Veiculo.modelo,
Veiculo.marca,
count(Locacao_Veiculo.ID) as quantidade_alugueis
from Veiculo
JOIN Locacao_Veiculo ON Veiculo.id = Locacao_Veiculo.Veiculo_ID
GROUP BY Veiculo.modelo, Veiculo.marca
ORDER BY quantidade_alugueis DESC;

-- Lista para saber o valor que cada cliente deve 
SELECT 
    Cliente.nome,
    SUM(Pagamento.Valor_total) AS valor_devido
FROM Cliente
JOIN Locacao ON Cliente.id = Locacao.Cliente_ID
JOIN Pagamento ON Locacao.Pagamento_ID = Pagamento.id
WHERE Pagamento.estado = 'Pendente'
GROUP BY Cliente.nome
ORDER BY Cliente.nome ASC;

