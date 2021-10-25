include .env

## up	:	Start up containers.
.PHONY: up
up:
	@echo "Starting up containers for $(PROJECT_NAME)..."
	docker-compose pull
	docker-compose up -d --remove-orphans
	docker-compose logs -f

## stop	:	Stop containers.
.PHONY: stop
stop:
	@echo "Stopping containers for $(PROJECT_NAME)..."
	@docker-compose down


## down	:	Stop containers.
.PHONY: down
down: stop

## sh-api : Acccess shell api
.PHONY: sh-api
sh-api:
	@docker exec -it api sh


## sh-front: Access shell front
.PHONY: sh-front
sh-front:
	@docker exec -it front sh

.PHONY: sh-db
sh-db:
	@docker exec -it db sh

## ps

.PHONY: ps
ps:
	@docker-compose ps -a

## install-project	:	Run project installer.

.PHONY: install-project
install-project:
	@./scripts/pre-install.sh
	@./scripts/install.sh

.PHONY: logs
logs:
	@docker-compose logs -f
