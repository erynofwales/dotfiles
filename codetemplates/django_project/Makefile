MANAGEPY=honcho run -- env/bin/python manage.py

update:
	virtualenv env
	env/bin/pip install -r requirements.txt
	$(MANAGEPY) syncdb
	
migrate:
	$(MANAGEPY) migrate

run: update
	$(MANAGEPY) runserver 0.0.0.0:8000

shell: update
	$(MANAGEPY) shell

deploy:
	git push heroku master
