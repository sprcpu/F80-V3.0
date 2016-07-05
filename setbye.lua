do
local function run(msg, matches, callback, extra)
local data = load_data(_config.moderation.data)
local rules = data[tostring(msg.to.id)]['rules']
local about = data[tostring(msg.to.id)]['description']
local hash = 'group:'..msg.to.id
local group_welcome = redis:hget(hash,'welcome')
if matches[1]:lower() == 'dbye' and not matches[2] and is_owner(msg) then 
    
   redis:hdel(hash,'welcome')
        return 'down 🗑'
end

local url , res = http.request('http://api.gpmod.ir/time/')
if res ~= 200 then return "No connection" end
local jdat = json:decode(url)

if matches[1]:lower() == 'sbye' and is_owner(msg) then
redis:hset(hash,'welcome',matches[2])
        return 'bye seted to : ✋\n'..matches[2]
end

if matches[1] == 'chat_del_user' and msg.service then
group_welcome = string.gsub(group_welcome, '{gpname}', msg.to.title)
group_welcome = string.gsub(group_welcome, '{firstname}', ""..(msg.action.user.first_name or '').."")
 group_welcome = string.gsub(group_welcome, '{lastname}', ""..(msg.action.user.last_name or '').."")
  group_welcome = string.gsub(group_welcome, '{username}', "@"..(msg.action.user.username or '').."")
  group_welcome = string.gsub(group_welcome, '{fatime}', ""..(jdat.FAtime).."")
  group_welcome = string.gsub(group_welcome, '{entime}', ""..(jdat.ENtime).."")
  group_welcome = string.gsub(group_welcome, '{fadate}', ""..(jdat.FAdate).."")
  group_welcome = string.gsub(group_welcome, '{endate}', ""..(jdat.ENdate).."")
 end
return group_welcome
end
return {
  patterns = {
  "^[!#/](sbye) +(.*)$",
  "^[!#/](dbye)$",
  "^([Ss]bye) +(.*)$",
  "^([Dd]bye)$",
  "^!!tgservice (chat_del_user)$",
  },
  run = run
}
end