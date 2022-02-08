#!/bin/bash -x
#delete previous data from telecac/your custom table name
mysql -u root -pMyPassword cacti -e "delete from telecac;";
#insert host data to telecac/your custom table name
#in this case, i want to show to telegram the aplication on specific tempates i just make, or you can simply modify what you want to show at telegram
#use "show columns from host;" to find column that you need and modify this mysql query as you need
mysql -u root -pMyPassword cacti -e "insert into telecac select id, hostname, description, status, cur_time from host where host_template_id = '6'";
#clear text and add text header application and insert to report.txt
echo "Update Status MyCacti Application" > report.txt;
#add date now to report.txt
date >> report.txt;
echo "-----------------------------------------------------------" >> report.txt;
#print and output previous inserted data to telecac to to report.txt
#you can modify this query as you need too
mysql -u root -pMyPassword cacti -e "select description, case when status = 0 then 'UNKNOWN' when status = 1 then 'DOWN' when status = 2 then 'RECOVERING'  when status = 3 then 'UP' when status = 4 then 'ERROR' else 'bug' end as status, concat(round(cur_time, 2), ' ms') as cur_time from telecac order by (description+0)" >> report.txt;
#run the script to send the report.txt text to telegram group using this python to bot
python3 sendtotelegram.py