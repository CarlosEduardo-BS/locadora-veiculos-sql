# locadora-veiculos-sql
Este é um projeto de criação de um **banco de dados relacional** para uma locadora de veículos, utilizando **MySQL**. O objetivo é modelar e implementar as principais entidades e relações de um sistema real de locação.

---

## 📄 Descrição do Projeto

O banco de dados inclui:

- **Clientes**: Dados cadastrais, como nome, CPF, telefone e endereço.
- **Pagamentos**: Formas de pagamento, valores e status (pago/pendente).
- **Locações**: Relacionamento entre cliente, veículo e pagamento.
- **Veículos**: Informações sobre os carros disponíveis, alugados ou em manutenção.
- **Manutenções**: Histórico de manutenção dos veículos.

Além disso, o projeto conta com algumas **consultas SQL úteis**, como:

- Listar manutenções ordenadas por custo.
- Calcular o valor total arrecadado.
- Relatório de alugueis por modelo/marca.
- Listar valores devidos por clientes.
