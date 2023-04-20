# php-aws

## 💻 Tecnologias

Para rodar o projeto é necessário o seguinte
* Docker-compose
* Terraform
* Aws cli

## 🚀 Instalação do projeto
Siga os passos para execução do projeto

Clone o projeto
```
git clone https://github.com/jaedson-correia/php-aws.git
```

Após ja estar na pasta, copie e modifique a .env.example
```
cp .env.example .env
```

Para rodar o terraform é necessário antes ter o Aws cli configurado com suas credenciais e então
```
terraform init
```

Você pode verificar as ações que serão realizadas com o seguinte comando
```
terraform plan
```

É possível então criar a estrutura com o comando
```
terraform apply
```

Caso seja necessário, você pode remover toda a estrutura criada com o código
```
terraform destroy
```

## Outros

Já está configurado o docker de php e apache, possui também uma imagem do jenkins. Há também um arquivo para subir um backup do banco de dados postgresql instalado na instância ec2 para s3 usando python.
Pela falta de familiaridade com a tecnologia terraform, não foi possível atender a todos os requisitos.
