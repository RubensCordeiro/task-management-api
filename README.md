# Backend da aplicalção: https://github.com/RubensCordeiro/task-management-front-end

Para rodar este projeto na sua máquina, siga os passos abaixo:

## Clone o repositório:
  git clone https://github.com/RubensCordeiro/task-management-api.git
  
## Instale o postgres (caso ainda não possua)
  Sugestão docker: <code>docker run --name pg -e POSTGRES_USER=chosen_username -e POSTGRES_PASSWORD=chosen_password -p 5432:5432 -d postgres:latest</code>

## Configure o banco de dados (Postgres): 
  Variáveis necesárias:
  - POSTGRES_USER
  - POSTGRES_PASSWORD
  - POSTGRES_HOST
  - POSTGRES_PORT
  - TOKEN_SECRET (recomendo usar uma hash aleatória em desenvolvimento, o comando <code> rails secret </code> te ajuda com isso)

### Inicie o ecossistema Rails:
  <code> rails db:create && rails db:migrate </code>

### Inicie a aplicação em servidor local:
  <code> bundle exec rails s </code>

### Para rodar os testes:
  <code> bundle exec rspec </code>
