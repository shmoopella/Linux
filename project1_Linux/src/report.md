## Part 1. Установка ОС

Ubuntu version:
![Ubuntu_version](screenshots/Ubuntu_version.png)

---

## Part 2. Создание пользователя

* Creation of a new user:

![Create_new_user](screenshots/new_user.png)

* cat /etc/passwd:

![Create_new_user](screenshots/cat%3Aetc%3Apasswd.png)


## Part 3. Настройка сети ОС

* Для изменения имени машины редактируем файл, находящийся по этому пути: 
```
/etc/hostname
```

![Change_hostname](screenshots/change_hostname.png)

* Меняем часовой пояс через команду ```timedatectl```

![Zone_location](screenshots/timedatectl.png)

* Команда ```ip link show``` поможет вывести названия всех сетевых интерфейсов

![Network_interfaces](screenshots/network%20interfaces.png)

_lo (loopback device) – виртуальный интерфейс, присутствующий по умолчанию в любом Linux. Он используется для отладки сетевых программ и запуска серверных приложений на локальной машине. С этим интерфейсом всегда связан адрес 127.0.0.1. У него есть dns-имя – localhost. Посмотреть привязку можно в файле /etc/hosts._


* IP-адрес, получаемый от DHCP:


![IP-address from DHCP](screenshots/ip_address_from_dhcp.png)

__DHCP__  _(англ. Dynamic Host Configuration Protocol — протокол динамической настройки узла) — прикладной протокол, позволяющий сетевым устройствам автоматически получать IP-адрес и другие параметры, необходимые для работы в сети TCP/IP._

* Внутренний IP-адрес шлюза, он же IP-адрес по умолчанию:

![IP-address](screenshots/local_ip-address.png)


* Внешний IP-адрес:
  
![IP-address](screenshots/ip-address.png)


* Статический IP-адрес и DNS назначаем через config-файл ```netplan```

![Static IP](screenshots/static_IP%2BDNS.png)


* Пингуется __"ВО"__!

![Ping](screenshots/ping.png)




## Part 4. Обновление ОС

* Через ```apt update ``` обновляем системные пакеты до последней версии:
![Update](screenshots/apt_update.png)


## Part 5. Использование команды sudo

* __Sudo__ (англ. Substitute User and do, дословно «подменить пользователя и выполнить») — программа для системного администрирования UNIX-систем, позволяющая делегировать те или иные привилегированные ресурсы пользователям с ведением протокола работы. Основная идея — дать пользователям как можно меньше прав, при этом достаточных для решения поставленных задач. Программа поставляется для большинства UNIX и UNIX-подобных операционных систем.

![Sudo](screenshots/SUDO.jpeg)

* Даем пользователю _em_clone_ права sudo через ```sudo usermod -aG sudo em_clone ```
и меняем hostname, также редактируя файл ```/etc/hostname```

![Sudo_em_clone_change_hostname](screenshots/change_host.png)


## Part 6. Установка и настройка службы времени

* Время часового пояса
![Timedate](screenshots/data.png)


## Part 7. Установка и использование текстовых редакторов

* Vim:
для выхода ```esc и wq```

![Vim](screenshots/vim_test.png)

* Nano:
для выхода ```ctrl + ```, далее ```Y```, чтобы сохранить изменения

![Nano](screenshots/nano_test.png)

* Joe:
для выхода ```ctrl + K```, далее ```X```, чтобы сохранить изменения

![Joe](screenshots/joe_test.png)



* Vim
для выхода без сохранения ```:q! ```

![Vim](screenshots/test2_vim.png)

* Nano 
для выхода без сохранения ```ctrl + x ```, далее ```N```


![Nano](screenshots/test_nano2.png)

* Joe
для выхода без сохранения ``` ctrl + c```, далее ```y``` 

![Joe](screenshots/test2_joe.png)

* Vim
для поиска перейти в режим команд через ```esc``` далее ввести ```/<шаблон_для_поиска>```

![Vim](screenshots/vim_test_search.png)

для поиска по всему файлу и замены
```:%s/<слово_для_замены>/<слово_на_замену>```
в режиме редактирования

![Vim](screenshots/vim_test3.png)

* Nano
для поиска ```ctrl+W```

![Nano](screenshots/nano_test_search.png)

для замены ```ctrl+\``` и ввести в поле строку для поиска и дальше строку для замены

* Joe 

для поиска ```ctrl+K далее F```

![Joe](screenshots/joe_test_search.png)

для замены выбрать ```R``` - replace и ввести строку для замены и ```Y```для подтверждения

![Joe](screenshots/joe_test3.png)

![Joe](screenshots/joe_tessst.png)


## Part 8. Установка и базовая настройка сервиса SSHD

* Установить службу SSHd через команду ```sudo apt-get install ssh```

* Добавить автостарт службы при загрузке системы c помощью команды ```sudo systemctl enable ssh ```

* Перенастроить службу SSHd на порт 2022: 
отредактировать конфигурационный файл ```sudo vim /etc/ssh/sshd_config```

![ssh_change_port](screenshots/ssh_change.png)

* Используя команду ps, показать наличие процесса sshd:

Через командц ```pd``` выводим по номеру процесса запущенный _sshd_ процесс
![ssh_change_port](screenshots/ssh_pd.png) 

В целом все запущенные процессы можно просмотреть командой pd с флагом ```-e```

![ssh_change_port](screenshots/ssh_pd-e.png)

* Вывод команды netstat:

![Netstat](screenshots/statnet.png)

Можно добавить ключи:
__-t__ Список активных портов TCP
__-a__ Отображение всех подключений и ожидающих портов.
__-n__ Отображение адресов и номеров портов в числовом формате

Столбцы вывода:
__Proto__ - протокол
__Recv-Q__ - размер очереди приема, в байтах
__Send-Q__ - размер очереди получения, в байтах
__Local address__ - локальный адрес
__Foreign address__ - удаленный адрес
__State__ - внутреннее состояние протокола

0.0.0.0. в столбце foreign address означает, что подключений нет
0.0.0.0. в столбце local address означает, что ожидает входящих соединений на всех интерфейсах

## Part 9. Установка и использование утилит top, htop

* Top
    * uptime (время работы после загрузки): 1:11
    * количество авторизованных пользователей: 1
    * общую загрузку системы: 0.0
    * общее количество процессов: 95
    * загрузку cpu: 0.0
    * загрузку памяти: 146.3 used 
    * pid процесса занимающего больше всего памяти: 1 (systemd)
    * pid процесса, занимающего больше всего процессорного времени 1194 (top)


![TOP](screenshots/top.png)

* __htop__ сортировка по:
    * PID
    ![PID](screenshots/htop_PID.png)

    * PERCENT_CPU
    ![PERCENT_CPU](screenshots/htop_PERCENT_CPU.png)

    * PERCENT_MEM
    ![PERCENT_MEM](screenshots/htop_PERCENT_MEM.png)

    * TIME
    ![TIME](screenshots/htop_TIME.png)


* __htop__ фильтр sshd:
![sshd](screenshots/sshd_filter.png)

*  __htop__ поиск syslog
![syslog](screenshots/htop_sys.png)

*  __htop__ вывод доп полей
![vivod](screenshots/htop_vivod.png)

## Part 10. Использование утилиты fdisk

* название жесткого диска: VBOX HARDDISK
* его размер: 10 GiB
* количество секторов: 20971520
* размер swap: 1.7 GiB
![Swap](screenshots/swap.png)

## Part 11. Использование утилиты df
* размер раздела: 9299276
* размер занятого пространства: 4437680
* размер свободного пространства: 4367620
* процент использования: 51%

![df](screenshots/df.png)

Определить и написать в отчёт единицу измерения в выводе: 1K-blocks (1024 байт)



* размер раздела: 8.9G
* размер занятого пространства: 4.3G
* размер свободного пространства: 4.2G
* процент использования: 51%
* Определить и написать в отчёт тип файловой системы для раздела: ext4
![df](screenshots/dfth.png)


## Part 12. Использование утилиты du

* Запустить команду du

![du](screenshots/du.png)

* Вывести размер папок 
/home
![du](screenshots/home_du.png)
/var
![du](screenshots/var_du.png)
/var/log 
![du](screenshots/du_varlog.png)
 

* Вывести размер всего содержимого в /var/log (не общее, а каждого вложенного элемента, используя *)

![du](screenshots/varlog2_du.png)

## Part 13. Установка и использование утилиты ncdu

* Вывести размер папок 
/home
![ncdu](screenshots/ncdu_home.png)
/var
![ncdu](screenshots/ncdu_var.png)
/var/log 
![du](screenshots/ncdu_var_log.png) 

## Part 14. Работа с системными журналами

* Написать в отчёте время последней успешной авторизации, имя пользователя и метод входа в систему: 02:47 festusst systemd-logind[650]

![logs](screenshots/logs.png) 

Перезапустить службу SSHd:
![restart_sshd](screenshots/restart_sshd.png) 


Вставить в отчёт скрин с сообщением о рестарте службы (искать в логах):

![restart_sshd_logs](screenshots/restart_in_logs.png) 

## Part 15. Использование планировщика заданий CRON


* Найти в системных журналах строчки (минимум две в заданном временном диапазоне) о выполнении:
![cron](screenshots/cron_logs.png) 

* Вывести на экран список текущих заданий для CRON:
![Cron](screenshots/crontab.png) 


Удалите все задания из планировщика заданий.
В отчёт вставьте скрин со списком текущих заданий для CRON:
```crontab -r``` - удалить

![Cron](screenshots/crontab2.png) 