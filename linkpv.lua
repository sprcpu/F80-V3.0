do

function run(msg, matches)
       if not is_momod(msg) then
        return
       end
    local data = load_data(_config.moderation.data)
      local group_link = data[tostring(msg.to.id)]['settings']['set_link']
       if not group_link then 
        return "Group link for["..msg.to.title.."]\n__________________\n NONE"
       end
         local text = "Group Link for["..msg.to.title.."]: \n__________________\n"..group_link
          send_large_msg('user#id'..msg.from.id, text.."\n", ok_cb, false)
           return 
end

return {
  patterns = {
    "^[/#!]([Ll]inkpv)$",
	"^([Ll]inkpv)$",
  },
  run = run
}

end