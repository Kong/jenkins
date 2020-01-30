build:
	docker build -t jenkins .

update_plugins: build
	docker run -d --rm --name=jenkins jenkins /usr/local/bin/jenkins.sh
	docker cp update_plugins.sh jenkins:/
	docker exec -it jenkins /update_plugins.sh
	docker cp jenkins:/plugins.txt plugins.txt
