# n8n Self-Hosted

Este diretório contém a configuração para executar o n8n em um ambiente Docker.

## Estrutura de arquivos

- `docker-compose.yml`: Configuração do container Docker para o n8n
- `.env`: Arquivo com variáveis de ambiente (não versionado)
- `.gitignore`: Configuração para não versionar arquivos sensíveis

## Como usar

1. Certifique-se de que o arquivo `.env` contém as variáveis corretas
2. Execute o container com o comando:

```bash
docker-compose up -d
```

3. Para parar o container:

```bash
docker-compose down
```

## Segurança

- O arquivo `.env` contém informações sensíveis e não deve ser versionado
- As senhas e credenciais são armazenadas apenas no arquivo `.env`
- O arquivo `.gitignore` está configurado para não versionar o arquivo `.env`

## Manutenção

Para atualizar a versão do n8n, edite a tag da imagem no arquivo `docker-compose.yml`.
