# Infraestrutura Terraform para EKS

Este repositório contém a configuração Terraform para provisionar um cluster Amazon EKS (Elastic Kubernetes Service) com os seguintes recursos:

## Recursos Provisionados

- Cluster EKS
- Grupo de nós com instâncias t3.large
- Configurações de IAM (roles e policies)
- Provedor OIDC para autenticação
- Configuração de rede VPC

## Pré-requisitos

- Terraform instalado
- Credenciais AWS configuradas
- Bucket S3 para armazenar o estado do Terraform

## Variáveis de Ambiente Necessárias

- `AWS_ACCESS_KEY_ID`: Chave de acesso AWS
- `AWS_SECRET_ACCESS_KEY`: Chave secreta AWS  
- `AWS_REGION`: Região AWS
- `S3_BUCKET_NAME`: Nome do bucket S3 para estado do Terraform

## Workflows GitHub Actions

### Deploy da Infraestrutura
- Arquivo: `.github/workflows/tf_apply.yaml`
- Executa `terraform init` e `terraform apply`
- Acionado manualmente via workflow_dispatch

### Destruição da Infraestrutura  
- Arquivo: `.github/workflows/tf_destroy.yaml`
- Executa `terraform destroy`
- Acionado manualmente via workflow_dispatch

## Especificações do Cluster

- Nome: streamforge
- Tipo de instância: t3.large
- Tamanho do disco: 20GB
- Capacidade: 1-7 nós (desejado: 3)
- Tipo: On-Demand

## Políticas IAM Anexadas

- AmazonEKSClusterPolicy
- AmazonEKSVPCResourceController  
- AmazonEKSWorkerNodePolicy
- AmazonEKS_CNI_Policy
- AmazonEC2ContainerRegistryReadOnly
- ElasticLoadBalancingFullAccess
- AmazonEC2FullAccess


## Configuração de Rede

- VPC dedicada para o cluster
- Subnets em duas zonas de disponibilidade
- Configuração de roteamento e NAT Gateway

## Segurança

### OIDC (OpenID Connect)
- Provedor OIDC configurado para autenticação
- Integração com IAM para gerenciamento de identidade
- Permite autenticação de serviços via service accounts

### IAM Roles
- Role específica para o cluster EKS
- Role para os nodes workers
- Configuração de trust relationships

## Monitoramento

- Métricas básicas do CloudWatch habilitadas
- Logs do cluster enviados ao CloudWatch
- Monitoramento de recursos EC2

## Manutenção

### Atualizações
- Possibilidade de atualização do cluster via Terraform
- Gerenciamento de versões do Kubernetes
- Rolling updates para nodes

### Backup
- Estado do Terraform armazenado no S3
- Versionamento do bucket S3 recomendado
- Backup automático de configurações do cluster

## Custos Estimados

- Cluster EKS: ~$73/mês
- Nodes t3.large (3 instâncias): ~$100/mês
- Custos adicionais de rede e armazenamento podem variar

## Troubleshooting

### Problemas Comuns
1. Falha na criação do cluster
   - Verificar permissões IAM
   - Validar configurações de VPC
   
2. Nodes não conectando
   - Verificar security groups
   - Validar configurações de rede

3. Falhas no Terraform
   - Verificar estado no S3
   - Validar credenciais AWS

