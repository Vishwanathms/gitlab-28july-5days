```
image: maven:3.8.6-openjdk-17

services:
  - docker:dind

variables:
  DOCKER_DRIVER: overlay2

before_script:
  - apt-get update && apt-get install -y docker.io

stages:
  - build
  - deploy

build:
  stage: build
  script:
    - git clone https://github.com/Vishwanathms/SampleMaven.git
    - cd SampleMaven
    - mvn clean package
  artifacts:
    paths:
      - SampleMaven/target/*.jar
    expire_in: 1 day

deploy:
  stage: deploy
  script:
    - cd SampleMaven
    - echo "Creating Dockerfile"
    - |
      cat <<EOF > Dockerfile
      FROM openjdk:17
      COPY target/*.jar app.jar
      ENTRYPOINT ["java", "-jar", "/app.jar"]
      EOF
    - docker build -t sample-app .
    - docker run -d -p 8080:8080 --name sample-app sample-app

```