## Part 1. Готовый докер

* Скачиваем докер образ nginx через ```docker pull``` и проверяем наличие докер образа через ```docker images```:

![docker_images](./screenshots/docker_images.png)

* Запустить докер образ через ```docker run -d [image_id|repository]```:

![docker_run_-d](./screenshots/docker_run_-d.png)

* Проверить, что образ запустился через ```docker ps```:

![docker_ps](./screenshots/docker_ps.png)


* Посмотреть информацию о контейнере через ```docker inspect[container_id|container_name].```

* По выводу команды определить и поместить в отчёт:
    - размер контейнера (__141677874__):
    ![container_size](./screenshots/container_size.png)

    - список замапленных портов (__таких нет__):
    ![mapping_ports](./screenshots/mapping_ports.png)

    - ip контейнера (__172.17.0.2__):
      ![ip_address](./screenshots/ip_address.png)


* Остановить докер образ через ```docker stop [container_id|container_name].```

* Проверить, что образ остановился через ```docker ps```:
![docker_stop](./screenshots/docker_stop.png)


* Запустить докер с замапленными портами 80 и 443 на локальную машину через команду run:

![docker_ports](./screenshots/docker_ports.png)


* Проверить, что в браузере по адресу ```localhost:80``` доступна стартовая страница nginx:

![localhost](./screenshots/localhost_80.png)


* Перезапустить докер контейнер через ```docker restart [container_id|container_name].```
* Проверить любым способом, что контейнер запустился:

![docker_restart](./screenshots/docker_restart.png)


## Part 2. Операции с контейнером

* Прочитать конфигурационный файл nginx.conf внутри докер контейнера через команду ```exec:```

![docker_exec](./screenshots/docker_exec.png)

* Создать на локальной машине файл nginx.conf. Настроить в нем по пути /status отдачу страницы статуса сервера nginx:

![nginx_conf](./screenshots/nginx_conf.png)

* Скопировать созданный файл nginx.conf внутрь докер образа через команду docker ```cp.```Перезапустить nginx внутри докер образа через команду ```exec:```

![docker_cp](./screenshots/docker_cp.png)


* Проверить, что по адресу localhost:80/status отдается страничка со статусом сервера nginx:

![localhost_status](./screenshots/localhost_status.png)

* Экспортировать контейнер в файл container.tar через команду export:

![docker_export](./screenshots/docker_export.png)

* Остановить контейнер:

![docker_stop](./screenshots/docker_stop2.png)


* Удалить образ через ```docker rmi [image_id|repository]```, не удаляя перед этим контейнеры:

![docker_rmi](./screenshots/docker_rmi.png)

* Удалить остановленный контейнер:

![docker_rm](./screenshots/docker_rm.png)

* Импортировать контейнер обратно через команду ```import:```

![docker_import](./screenshots/docker_import.png)

* Запустить импортированный контейнер:

![docker_run_import](./screenshots/docker_run_import.png)

* Проверить, что по адресу ```localhost:80/status``` отдается страничка со статусом сервера nginx:

 ![dstatus_page](./screenshots/status_page.png)


 ## Part 3. Мини веб-сервер

 * Написать мини сервер на C и FastCgi, который будет возвращать простейшую страничку с надписью "Hello World!":

![hello_page](./screenshots/hello_page.png)


* Запустить написанный мини сервер через spawn-fcgi на порту 8080.

Сначала запускаем контейнер c замапленным 81 портом:
![container_81port](./screenshots/container_81port.png)

* Далее запускаем bash внутри докера и обновляем все пакеты  и устанавливаем __gcc__ компилятор (apt install gcc) и __spawn_fcgi__ (apt install spawn-fcgi) и __libfcgi-dev__ (apt install libfcgi-dev) библиотеку:

![bash_cont](./screenshots/bash_cont.png)

* Компилируем fcgi-приложение:

![gcc](./screenshots/gcc.png)

* Запускаем приложение на 8080 порту:
![spawn-fcgi](./screenshots/spawn-fcgi.png)


* Написать свой nginx.conf, который будет проксировать все запросы с 81 порта на 127.0.0.1:8080

![nginx_conf_fcgi](./screenshots/nginx_conf_fcgi.png)


* Проверить, что в браузере по localhost:81 отдается написанная вами страничка:

![hello_fcgi](./screenshots/hello_fcgi.png)


## Part 4. Свой докер

* Написать свой докер образ, который:

  1) собирает исходники мини сервера на FastCgi из Части 3
  2) запускает его на 8080 порту
  3) копирует внутрь образа написанный ./nginx/nginx.conf
  4) запускает nginx.

* Собрать написанный докер образ через docker build при этом указав имя и тег:
  ![docker_build](./screenshots/docker_build.png)

* Проверить через docker images, что все собралось корректно:
  ![docker_imagess](./screenshots/docker_imagess.png)

* Запустить собранный докер образ с маппингом 81 порта на 80 на локальной машине и маппингом папки ./nginx внутрь контейнера по адресу, где лежат конфигурационные файлы nginx'а:

  ![docker_run_81](./screenshots/docker_run_81.png)

* Проверить, что по localhost:80 доступна страничка написанного мини сервера:
  ![hello_81](./screenshots/hello_81.png)


* Дописать в ./nginx/nginx.conf проксирование странички /status, по которой надо отдавать статус сервера nginx:
  ![nginx_conf_status](./screenshots/nginx_conf_status.png)

* Перезапустить докер образ:
  ![docker_restartt](./screenshots/docker_restartt.png)

* Проверить, что теперь по localhost:80/status отдается страничка со статусом nginx:
![stub_status](./screenshots/stub_status.png)


## Part 5. Dockle

* Просканировать образ из предыдущего задания через dockle [image_id|repository].
Исправить образ так, чтобы при проверке через dockle не было ошибок и предупреждений:

![dockle](./screenshots/docle.png)

## Part 6. Базовый Docker Compose

* Написать файл docker-compose.yml, с помощью которого:

   1) Поднять докер контейнер из Части 5 (он должен работать в локальной сети, т.е. не нужно использовать инструкцию EXPOSE и мапить порты на локальную машину)


   2) Поднять докер контейнер с nginx, который будет проксировать все запросы с 8080 порта на 81 порт первого контейнера.
Замапить 8080 порт второго контейнера на 80 порт локальной машины.

  ![compose_yml](./screenshots/compose_yml.png)


* Cобрать и запустить проект с помощью команд docker-compose build и docker-compose up:

![docker_compose_build](./screenshots/docker_compose_build.png)

![docker_compose_run](./screenshots/docker_compose_run.png)

* Проверить, что в браузере по localhost:80 отдается написанная вами страничка, как и ранее:

![docker_compose_hello](./screenshots/docker_compose_hello.png)


