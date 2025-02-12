build:
	./gradlew bootJar

docker:
	./gradlew bootBuildImage

run:
	docker-compose up -d

stop:
	docker-compose down

curl:
	curl localhost:8090

clean:
	rm -rf build/
	rm -rf .gradle/
