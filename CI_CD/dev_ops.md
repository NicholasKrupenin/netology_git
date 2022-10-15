## Задание 1.

* Установите себе jenkins, следуя инструкции из лекции (или любым другим способом из официальной документации). Использовать docker в данном задании нежелательно.
* Установите на машину с jenkins golang (https://golang.org/doc/install).
* Используя свой аккаунт на GitHub, сделайте себе форк репозитория: https://github.com/netology-code/sdvps-materials.git. Там же лежит дополнительный материал для выполнения ДЗ.
* Создайте в дженкинсе freestyle проект, подключите получившийся репозиторий к нему и произведите запуск тестов и сборку проекта go test . и docker build .

![](https://github.com/NicholasKrupenin/netology_git/blob/main/CI_CD/img/1_task.png)
![](https://github.com/NicholasKrupenin/netology_git/blob/main/CI_CD/img/1_task_2.png)

## Задание 2.
* Создайте новый проект pipeline.
* Перепишите сборку из задания 1 на declarative(в виде кодa)

  ```
pipeline {
 agent any
 stages {
  stage('Git') {
   steps {git 'https://github.com/NicholasKrupenin/netology-devops.git'}
  }
  stage('Test') {
   steps {
    sh '/usr/local/go/bin/go test .'
   }
  }
  stage('Build') {
   steps {
    sh 'docker build .'
   }
  }
 }
}
  ```
  ![](https://github.com/NicholasKrupenin/netology_git/blob/main/CI_CD/img/2_task.png)

## Задание 3.
* Установите на машину Nexus.
* Создайте raw-hosted репозиторий.
* Измените пайплайн таким образом, чтобы вместо docker-образа собирался бинарный go-файл (команду можно скопировать из Dockerfile).
* Загрузите файл в репозиторий с помощью jenkins

```
pipeline {
 agent any
 stages {
  stage('Git') {
   steps {git 'https://github.com/NicholasKrupenin/netology-devops.git'}
   }

  stage('Build') {
   steps {
    sh 'CGO_ENABLED=0 GOOS=linux /usr/local/go/bin/go build -a -installsuffix nocgo -o /app .'}
  }

  stage('Push') {
   steps {
    sh 'curl -u admin:admin --upload-file http://192.168.56.10:8081/repository/neto-raw/ /app' }
  }
 }
}
```
