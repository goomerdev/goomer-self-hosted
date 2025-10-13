# Infra (Terraform) - ninja/n8n

Provisiona uma instância EC2 na AWS com os seguintes requisitos:

- Nome (`Name`): `ninja-n8n`
- AMI: `ami-03d9fcc39480315d4`
- Tipo: `t4g.micro`
- VPC: `vpc-0b2ed1981d9864fd2`
- Subnet: `subnet-03265512a856c2047`
- SG: cria um SG que libera a porta TCP `5678` apenas a partir do SG `sg-0cca93afa1f441d41`
- SSM: cria IAM Role/Instance Profile com `AmazonSSMManagedInstanceCore` e instala/inicia o agente via `user_data`

> Obs.: Confirme que a `AMI`, `VPC` e `Subnet` pertencem à mesma região configurada no provider (padrão `us-east-1`).

## Estrutura

- `versions.tf` — versões do Terraform e provider AWS
- `provider.tf` — provider AWS e região
- `variables.tf` — variáveis de entrada com defaults conforme solicitado
- `main.tf` — SG, regra de porta 5678 (origem: SG informado), IAM Role/Instance Profile (SSM) e EC2 com `user_data`
- `outputs.tf` — IDs e IPs úteis
- `terraform.tfvars.example` — exemplo de variáveis já preenchidas

## Pré-requisitos

- Terraform >= 1.3
- Credenciais AWS configuradas (ex.: `AWS_PROFILE`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` etc.)

## Como usar

1. (Opcional) Copie `terraform.tfvars.example` para `terraform.tfvars` e ajuste se necessário.
2. Inicialize o diretório:

   ```bash
   terraform -chdir=./n8n/ninja/infra init
   ```

3. Revise/ajuste a região, se necessário (padrão `us-east-1`). Faça o plano:

   ```bash
   terraform -chdir=./n8n/ninja/infra plan
   ```

4. Aplique:

   ```bash
   terraform -chdir=./n8n/ninja/infra apply
   ```

5. Para destruir:

   ```bash
   terraform -chdir=./n8n/ninja/infra destroy
   ```

## Notas sobre SSM

- A instância recebe um `Instance Profile` com a política gerenciada `AmazonSSMManagedInstanceCore`.
- O `user_data` tenta instalar o agente via `apt` (como no exemplo) e faz fallback para `snap` em Ubuntu; também tenta `yum/dnf` em distros baseadas em RHEL/Amazon Linux.
- O serviço é habilitado e iniciado via `systemctl`.

## Segurança da porta 5678

- O SG criado só permite tráfego de entrada na porta TCP 5678 a partir do SG especificado em `allowed_sg_id`.
- Não é aberta nenhuma porta para a Internet por padrão (somente `egress` livre). Ajuste conforme necessário.

## Variáveis principais

- `aws_region` (padrão: `us-east-1`)
- `vpc_id` (padrão: `vpc-0b2ed1981d9864fd2`)
- `subnet_id` (padrão: `subnet-03265512a856c2047`)
- `ami_id` (padrão: `ami-03d9fcc39480315d4`)
- `instance_type` (padrão: `t4g.micro`)
- `instance_name` (padrão: `ninja-n8n`)
- `allowed_sg_id` (padrão: `sg-0cca93afa1f441d41`)
- `associate_public_ip` (padrão: `false`)

> Se quiser IP público (por exemplo, para troubleshooting sem endpoints VPC do SSM), defina `associate_public_ip = true` e garanta que a subnet permita IP público/rota para Internet.
