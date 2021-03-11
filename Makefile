include .env

## up	:	Start up containers.
.PHONY: up
up:
	@echo "Starting up containers for $(PROJECT_NAME)..."
	docker-compose pull
	docker-compose up -d --remove-orphans

## stop	:	Stop containers.
.PHONY: stop
stop:
	@echo "Stopping containers for $(PROJECT_NAME)..."
	@docker-compose stop


## down	:	Stop containers.
.PHONY: down
down: stop

.PHONY: start-front
start-front:
	@echo "Starting front-end application..."
	@docker-compose exec node npm install forever -g
	@docker-compose exec node forever start ./node_modules/.bin/ng serve --host 0.0.0.0 --port 4200 --disable-host-check
	@docker-compose exec node forever start dist/server

## install-project	:	Run project installer.

.PHONY: install-project
install-project:
	@./scripts/install.sh
