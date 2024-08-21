
init: venv deps

venv: ./env/bin/pip
	python3 -m venv env

deps: ./env/bin/ansible-playbook
	./env/bin/pip install -r requirements.txt

freeze:
	./env/bin/pip freeze > requirements.txt
