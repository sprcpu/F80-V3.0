do

 function run(msg, matches)
 local ch = 'chat#id'..msg.to.id
 local fuse = '📌فیدبک جدید📌\n👤 نام کاربر : ' .. msg.from.print_name .. '\n👤 شماره کاربر : ' .. msg.from.phone ..'\n👤 لینک کاربر : telegram.me/' .. msg.from.username ..'\n👤 نام کاربری : @' .. msg.from.username ..'\n👤 کد کاربر : ' .. msg.from.id ..'\n👤 نام گروه : ' .. msg.to.print_name ..'\n👤 کد گروه : '..msg.to.id.. '\n📝 کد پیام : ' .. msg.id .. '\n📝 نوع پیام : ' .. msg.text .. '\n📝 متن ارسالی:\n'.. matches[1] 
 local fuses = '!printf user#id' .. msg.from.id


   local text = matches[1]
   local chat = "chat#id"..112242203

  local sends = send_msg(chat, fuse, ok_cb, true)
  return '✅ sended to team'

 end
 end
 return {
  patterns = {
  "^نظر (.*)$",
  "^[Ff][Ee][Ee][Dd][Bb][Aa][Cc][Kk] (.*)$",
  
  },
  run = run
 }
 
 
