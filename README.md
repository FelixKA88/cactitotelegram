# CACTI TO TELEGRAM
create notification report from cacti to telegram, and control server from telegram using bot and group
tested on Ubuntu Server 20.04, cacti 1.2.19.

so, i have make this using reference from stackoverflow, linuxsec.org, to code the python, bash script, and js to create the report from cacti to telegram integration.
this is the first version, so i think this one has security issues because not implement calling data from sql in safest way and better u guys change the proxy server on shell-bot to your's. if you guys have suggestion, let me know it ^^.

what can this application do?
- automate report cacti to telegram at specific time (ex: at 09:00 and 16:00)
- get report at any time using "/report" to telegram bot on the group
- run bash command using "/run [command]" from telegram group

example :

![IMG_20220208_104834](https://user-images.githubusercontent.com/99232562/152914658-24f971ee-439c-43bd-955d-771de8d4e6d6.jpg)
![IMG_20220208_104854](https://user-images.githubusercontent.com/99232562/152914663-a0fa425e-6e3f-41f5-b587-0b5fa1a2a54d.jpg)


**REQUIREMENTS!!**
* Linux (Tested on Ubuntu Server 20.04) and crontab
* Python 3.x
* pip
* Telegram Bot Token
* Telegram User/Group ID

there's 1 folder and 2 file at this repository, place them at /root

**configuration step**

#install requirements

#if want the report sended to the group, add bot to the group and grant as admin

> **root@localhost:~#** pip3 install mysql-connector

> **root@localhost:~#** pip3 install telepot

> **root@localhost:~#** pip3 install dotenv

#clone this repository

> **root@localhost:~#** git clone https://github.com/FelixKA88/cactitotelegram.git

#make sure there's 1 folder and 2 files path is on "/root", or you can modify the path inside the script

#clone this repository to use your linux command from telegram

> **root@localhost:~#** git clone https://github.com/botgram/shell-bot.git

#edit the server.js so you can use /report command to get report from script sql.sh and sendtotelegram.py

#see tag "// Command report" inside the new server.js

> **root@localhost:~#** rm /shell-bot/server.js && mv server.js /shell-bot

#create table inside cacti database, make the table and column type same as host table.

> **root@localhost:~#** mysql -u root -pMyPassword cacti -e "create table telecac as select id, hostname, description, status, cur_time from host;"

#or you can try another way if that way pop an error

#check if the path is correct

> **root@localhost:~#** nano report.sh

> **root@localhost:~#** nano /root/telecac/sql.sh

#fill your bot token and user/group id to the script and replace

> **root@localhost:~#** nano /root/telecac/sendtotelegram.py

#check if the script run correctly

> **root@localhost:~#** cd /telecac && ./sql.sh

#then if nothing wrong and successfully send a text to your user/group using bot, continue to the next step


**----------ADD SCHEDULER REPORT AT SPECIFIC TIME USING CRONTAB---------**


#edit the crontab

> **root@localhost:~#** crontab -e

#then add new crontab

example for run everyday at 09:00

> 0 9 * * * cd /root/telecac && /bin/sh /root/telecac/sql.sh

example for run everyday at 16:00

> 0 16 * * * cd /root/telecac && /bin/sh /root/telecac/sql.sh

example for run every 5 minutes everyday

> */5 * * * * cd /root/telecac && /bin/sh /root/telecac/sql.sh

#after creating the scheduler crontab, save with ctrl + x > ctrl +y > enter.


**---------GET REPORT USING COMMAND FROM TELEGRAM----------**


#install the server.js

> **root@localhost:~#** cd /shell-bot

> **root@localhost:~/shell-bot#** npm install

> **root@localhost:~/shell-bot#** node server

#insert your bot token

#the bot will ask for message

#if you using group, text a random message to group then verify in the bot so everyone in the group can use the bot

#if you just want the bot to communicate with only your account, text on the bot's private message. so even the bot added to a group, the person can use the command is only you.

