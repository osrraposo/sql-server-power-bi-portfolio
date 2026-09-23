# Power BI Gateway — roteiro de diagnóstico

## Credenciais inválidas

Para erros como `DM_GWPipeline_Gateway_InvalidConnectionCredentials`:

1. Confirme servidor e banco configurados no modelo sem publicar endereços reais.
2. Teste as mesmas credenciais diretamente no SQL Server.
3. Verifique o tipo de autenticação configurado na conexão do Gateway.
4. Atualize as credenciais no Power BI Service.
5. Confirme se o modelo semântico está vinculado à conexão correta.
6. Execute **Test connection** antes de uma nova atualização.

## Mais de um Gateway

Duas instâncias podem coexistir, mas é necessário confirmar:

- qual cluster está online;
- qual conexão pertence a cada cluster;
- qual conexão está associada ao modelo semântico;
- se existem fontes duplicadas com credenciais diferentes;
- se servidor e banco coincidem exatamente entre Desktop, Service e Gateway.

## Checklist de segurança

- Não registrar IPs, logins ou mensagens contendo credenciais neste repositório.
- Usar exemplos fictícios em capturas de tela.
- Não versionar arquivos `.pbix` que contenham dados corporativos.
