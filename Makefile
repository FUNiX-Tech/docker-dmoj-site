.PHONY: buildnew buildold

buildnew: 
	cp -f site/new-db.sh site/start-dmoj.sh
	sudo docker compose build --no-cache

buildold:
	cp -f site/old-db.sh site/start-dmoj.sh
	sudo docker compose build --no-cache

