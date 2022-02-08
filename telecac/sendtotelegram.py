import telepot
#read the text of report.txt
with open('report.txt', 'r+') as f:
	new_f = f.readlines()
	f.seek(0)
	for line in new_f:
		if 'description' not in line:
			f.write(line)
	f.truncate()
#open the file and store the text to data variable
with open('report.txt', 'r') as file:
#.replace is used to tidy up the string given to bot
	data = file.read().replace("UP", ": UP  ").replace("UNKNOWN", ": UNKNOWN  ").replace("DOWN", ": DOWN  ").replace("RECOVERING", ": RECOVERING  ").replace("ERROR", ": ERROR  ")

#replace this bot token and user/group id
TOKEN="561961:89rpjlkjda90e89"
chat_id="-87912010310"

bot=telepot.Bot(TOKEN)
#bypass the message length limit and send the data variable to telegram
if len(data) > 4096:
        for x in range(0, len(data), 4096):
                bot.sendMessage(chat_id, data[x:x+4096])
else:
        bot.sendMessage(chat_id, data)
