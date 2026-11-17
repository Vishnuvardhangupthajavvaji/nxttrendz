.PHONY: build up down logs migrate superuser shell push

build:
	docker compose build
up:
	docker compose up -d --build
down:
	docker compose down
blogs:
	docker compose logs backend
flogs:
	docker compose logs frontend
migrate:
	docker compose exec backend python manage.py migrate
superuser:
	docker compose exec backend python manage.py createsuperuser
shell:
	docker compose exec backend python manage.py shell
setup:
	docker compose up -d --build
	docker compose exec backend python manage.py showmigrations
	docker compose exec backend python manage.py makemigrations users products cart
	docker compose exec backend python manage.py showmigrations
	docker compose exec backend python manage.py migrate
	docker compose exec backend python manage.py createsuperuser



DOCKER_ID = vishnuvardhan1903
BACKEND_IMAGE = nxttrendz-backend
FRONTEND_IMAGE = nxttrendz-frontend
VERSION = v1
LATEST = latest

push:
	docker tag $(BACKEND_IMAGE) $(DOCKER_ID)/$(BACKEND_IMAGE):$(VERSION)
	docker tag $(BACKEND_IMAGE) $(DOCKER_ID)/$(BACKEND_IMAGE):$(LATEST)
	docker push $(DOCKER_ID)/$(BACKEND_IMAGE):$(VERSION)
	docker push $(DOCKER_ID)/$(BACKEND_IMAGE):$(LATEST)

	docker tag $(FRONTEND_IMAGE) $(DOCKER_ID)/$(FRONTEND_IMAGE):$(VERSION)
	docker tag $(FRONTEND_IMAGE) $(DOCKER_ID)/$(FRONTEND_IMAGE):$(LATEST)
	docker push $(DOCKER_ID)/$(FRONTEND_IMAGE):$(VERSION)
	docker push $(DOCKER_ID)/$(FRONTEND_IMAGE):$(LATEST)