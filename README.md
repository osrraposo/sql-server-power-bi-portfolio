# SQL Server & Power BI Portfolio

Portfólio técnico com padrões reutilizáveis para engenharia de dados, Business Intelligence e sustentação de ambientes Microsoft.

Os exemplos deste repositório são genéricos e anonimizados. Eles demonstram práticas aplicáveis a cenários reais sem expor empresas, clientes, servidores, credenciais ou estruturas proprietárias.

## Conteúdo

- `sql/etl`: stored procedures de carga com staging, validação, transação e logging.
- `sql/data-quality`: conciliação de fontes, duplicidades, nulos e divergências.
- `sql/performance`: filtros sargable, tabelas temporárias e índices.
- `power-bi/dax`: medidas e tabelas auxiliares reutilizáveis.
- `power-bi/power-query`: tratamento de dados preservando tipos.
- `power-bi/gateway`: roteiro de diagnóstico de atualização e credenciais.
- `docs`: arquitetura, segurança e decisões técnicas.

## Princípios demonstrados

- `SET NOCOUNT ON` e `SET XACT_ABORT ON` em processos de carga.
- `TRY/CATCH`, transações e `THROW` para falhas controladas.
- Logging por etapa, duração, período e quantidade de linhas.
- Staging antes da transformação e da carga final.
- Validação antes de alterar tabelas de destino.
- Consultas por intervalos de data sargable.
- Separação entre valor numérico e formatação visual no Power BI.

## Segurança

Nenhum exemplo deve conter dados pessoais, nomes de clientes, IPs, logins, senhas, caminhos internos ou nomes reais de bases e tabelas.

## Autor

Thiago Santos — [@osrraposo](https://github.com/osrraposo)
