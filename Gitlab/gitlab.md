## Задание 1.
* Разверните Gitlab локально, используя Vagrantfile и инструкцию, описанные в этом репозитории.
* Создайте новый проект и пустой репозиторий в нём.
* Зарегистрируйте gitlab-runner для этого проекта и запустите его в режиме docker. Раннер можно регистрировать и запускать на той же виртуальной машине, на которой запущен gitlab.

```sh
concurrent = 1
check_interval = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "netology-ci/cd"
  url = "https://gitlab.com/"
  id = 18194952
  token = "XAz5XJiTLzR7DvSRXAwi"
  token_obtained_at = 2022-10-16T22:04:20Z
  token_expires_at = 0001-01-01T00:00:00Z
  executor = "shell"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
    [runners.cache.azure]

[runners.docker]
	volumes = ["/var/run/docker.sock:/var/run/docker.sock"]
```

## Задание 2.
* Запушьте репозиторий на GitLab, изменив origin 
* Создайте .gitlab-ci.yml, описав в нем все необходимые на ваш взгляд этапы.

