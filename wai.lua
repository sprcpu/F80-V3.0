function run(msg, matches)
if is_silent(msg) then 
 send_document(get_receiver(msg), "/root/f80/umbrella/stickers/silent.webp", ok_cb, false)
return " you ARE SILENT(Sudo) "
elseif is_sudo(msg) then 
 send_document(get_receiver(msg), "/root/f80/umbrella/stickers/sudo.webp", ok_cb, false)
return " you ARE🗣 (SUDO) "
elseif is_admin1(msg) then
 send_document(get_receiver(msg), "/root/f80/umbrella/stickers/admin.webp", ok_cb, false)
return " You ARE🗣 (ADMIN) "
elseif is_owner(msg) then 
 send_document(get_receiver(msg), "/root/f80/umbrella/stickers/leader.webp", ok_cb, false)
return " You ARE🗣 (GP EX ADMIN) "
elseif is_momod(msg) then 
 send_document(get_receiver(msg), "/root/f80/umbrella/stickers/mod.webp", ok_cb, false)
return " You ARE🗣 (MOD) "
else
return "🗣kiramam nisti🗣"
end
end
return {
patterns = {
"^([Ww][Aa][Ii])$",
"^([Mm][Ee])$",
"^(من کیم)$",
},
run = run
}