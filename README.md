# README

### Ифнормация

	При разработки использовался SublimeText 3
	Настройки: { "tab_size": 2, "translate_tabs_to_spaces": true }

### Запуск тестовго проекта

	В терминале в корне проекта последовательно вводим команды
		
	1) `docker-compose build`
	2) `docker volume create --name=my_datavolume`
	3) `docker-compose up -d`
	4) `docker exec -ti container_name bash`
	5) `bin/rails db:prepare` или `bin/rails db:create db:migrate db:seed`

	URL: http://localhost:3000/ или http://127.0.0.1:3000


### Запуск тестов

	1)`docker exec -ti container_name bash`
	2)`bundle exec spring rspec spec/folder/name_spec.rb`


### Запуск всех тестов

	1)`docker exec -ti container_name bash`
	2)`bundle exec spring rspec spec`


### Модели и связи

	Client => Account => Transaction
	Client => Account (один ко многим)
	Account => Transaction (один ко многим)


### Дополнительный функционал в модели Client:

	balance, balance(currency), full_name для упрощения взаимодействий
	balance - возвращает хеш где ключи это табличные значения валют
	balance(currency) - возвращает integer значение суммы всех транзакций по определенной валюте
	full_name - выводит полное имя пользователя

