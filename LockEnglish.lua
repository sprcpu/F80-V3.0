kicktable = {}


local function run(msg, matches)
    if is_momod(msg) then
        return msg
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['english'] then
                number = data[tostring(msg.to.id)]['settings']['english']
            end
        end
    end
    local chat = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if number == "🔒" then
        send_large_msg(get_receiver(msg), "  ")
        delete_msg(chat, user, ok_cb, true)
    end
end
 
return {
  patterns = {
     "[a-z]",
	 "[A-Z]",
 },
  run = run
}
