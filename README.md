# Backend da aplicalção: https://electrotasks.herokuapp.com/

Para rodar este projeto na sua máquina, siga os passos abaixo:

## Clone o repositório:
  git clone https://github.com/RubensCordeiro/task-management-api.git
  
## Configure o banco de dados (Postgres): 
  Altere as configurações do arquivo databases.yml para suas configurações do Postgres.

### Inicie o ecossistema Rails:
  rails db:crate
  rails db:migrate

### Inicie a aplicação em servidor local:
  bundle exec rails s

### Para rodar os testes:
  bundle exec rspec
