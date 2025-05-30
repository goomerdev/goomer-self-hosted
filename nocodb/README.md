# NocoDB - Implantação AWS Elastic Beanstalk

Este repositório contém a configuração do [NocoDB](https://github.com/nocodb/nocodb) para ser executado em um ambiente AWS Elastic Beanstalk. O NocoDB é uma plataforma open-source que transforma qualquer banco de dados relacional em um sistema tipo Airtable.

## Estrutura
- **Dockerrun.aws.json**: Arquivo de configuração para o deploy Docker no Elastic Beanstalk.
- **Workflows**: Automatização do deploy via Github Actions (ver abaixo).

## Deploy via Github Actions
Este repositório possui um workflow para automatizar o deploy no AWS Elastic Beanstalk sempre que houver push na branch principal (`main`).

## Como utilizar
1. Configure as secrets do Github (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`, `EB_ENV_NAME`, `EB_APP_NAME`).
2. Faça push na branch `main` para disparar o workflow de deploy.

---

### Sobre o NocoDB
NocoDB é uma solução de código aberto para transformar bancos de dados relacionais em aplicativos colaborativos estilo planilha. Mais informações em [https://www.nocodb.com/](https://www.nocodb.com/).
