local function callback_reply(extra, success, result)
	--icon & rank ------------------------------------------------------------------------------------------------
	userrank = "Member"
	if tonumber(result.from.id) == 176972874 then
		userrank = " SILENT "
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/silent.webp", ok_cb, false)
	elseif is_sudo(result) then
		userrank = "Sudo"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/sudo.webp", ok_cb, false)
	elseif is_admin2(result.from.id) then
		userrank = "Admin"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/admin.webp", ok_cb, false)
	elseif is_owner2(result.from.id, result.to.id) then
		userrank = "EX Admin"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/leader.webp", ok_cb, false)
	elseif is_momod2(result.from.id, result.to.id) then
		userrank = "Mod"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/mod.webp", ok_cb, false)
	elseif tonumber(result.from.id) == tonumber(our_id) then
		userrank = "F80"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/umb.webp", ok_cb, false)
	elseif result.from.username then
		if string.sub(result.from.username:lower(), -3) == "bot" then
			userrank = "API Bot"
			send_document(get_receiver(msg), "/root/f80/umbrella/stickers/api.webp", ok_cb, false)
		end
	end
	--custom rank ------------------------------------------------------------------------------------------------
	local file = io.open("./info/"..result.from.id..".txt", "r")
	if file ~= nil then
		usertype = file:read("*all")
	else
		usertype = "-----"
	end
	--cont ------------------------------------------------------------------------------------------------
	local user_info = {}
	local uhash = 'user:'..result.from.id
	local user = redis:hgetall(uhash)
	local um_hash = 'msgs:'..result.from.id..':'..result.to.id
	user_info.msgs = tonumber(redis:get(um_hash) or 0)
	--msg type ------------------------------------------------------------------------------------------------
	if result.media then
		if result.media.type == "document" then
			if result.media.text then
				msg_type = "Sticker"
			else
				msg_type = "Other Files"
			end
		elseif result.media.type == "photo" then
			msg_type = "Pic"
		elseif result.media.type == "video" then
			msg_type = "Video"
		elseif result.media.type == "audio" then
			msg_type = "Voice"
		elseif result.media.type == "geo" then
			msg_type = "GPS"
		elseif result.media.type == "contact" then
			msg_type = "Contact"
		elseif result.media.type == "file" then
			msg_type = "FIle"
		elseif result.media.type == "webpage" then
			msg_type = "Web Page"
		elseif result.media.type == "unsupported" then
			msg_type = "GIF"
		else
			msg_type = "UNKnown"
		end
	     elseif result.text then
		if string.match(result.text, '^%d+$') then
			msg_type = "NUMBER"
		elseif string.match(result.text, '%d+') then
			msg_type = "With Phone"
		elseif string.match(result.text, '^@') then
			msg_type = "UserName"
		elseif string.match(result.text, '@') then
			msg_type = "With UserName"
		elseif string.match(result.text, '[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]') then
			msg_type = "TG LINK"
		elseif string.match(result.text, '[Hh][Tt][Tt][Pp]') then
			msg_type = "SITE LINK"
		elseif string.match(result.text, '[Ww][Ww][Ww]') then
			msg_type = "LINK"
		elseif string.match(result.text, '?') then
			msg_type = "QUESTION"
		else
			msg_type = "TEXT"
		end
	end
	--hardware ------------------------------------------------------------------------------------------------
	if result.text then
		inputtext = string.sub(result.text, 0,1)
		if result.text then
			if string.match(inputtext, "[a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z]") then
				hardware = "Computer"
			elseif string.match(inputtext, "[A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z]") then
				hardware = "Mobile"
			else
				hardware = "-----"
			end
		else
			hardware = "-----"
		end
	else
		hardware = "-----"
	end
	--phone ------------------------------------------------------------------------------------------------
	if access == 1 then
		if result.from.phone then
			number = "+"..string.sub(result.from.phone, 0)
			if string.sub(result.from.phone, 0,2) == '98' then
					number = number.."\n Country  : IRAN"
				elseif string.sub(result.from.phone, 0,1) == '1' then
					number = number.."\n Country  : U.S.A"
				elseif string.sub(result.from.phone, 0,2) == '62' then
				    number = number.."\n Country  : Indonesia"
				elseif string.sub(result.from.phone, 0,2) == '63' then
				    number = number.."\n Country  : Philippines"
				if string.sub(result.from.phone, 0,4) == '9891' then
					number = number.."\n Simcard  : IR M.C.I"
				elseif string.sub(result.from.phone, 0,5) == '98932' then
					number = number.."\n Simcard  : TALIA"
				elseif string.sub(result.from.phone, 0,4) == '9893' then
					number = number.."\n Simcard  : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9890' then
					number = number.."\n Simcard  : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9892' then
					number = number.."\n Simcard  : RIghtel"
				else
					number = number.."\n Simcard  : other"
				end
			else
				number = number.."\n Simcard  : Other\n Country  : UNKnown"
			end
		else
			number = "-----"
		end
	elseif access == 0 then
		if result.from.phone then
			number = "You Are Not Alow"
			if string.sub(result.from.phone, 0,2) == '98' then
				number = number.."\n Country  : IRAN"
				elseif string.sub(result.from.phone, 0,1) == '1' then
					number = number.."\n Country  : U.S.A"
				elseif string.sub(result.from.phone, 0,2) == '62' then
				    number = number.."\n Country  : Indonesia"
				elseif string.sub(result.from.phone, 0,2) == '63' then
				    number = number.."\n Country  : Philippines"
				if string.sub(result.from.phone, 0,4) == '9891' then
					number = number.."\n Simcard  : IR M.C.I"
				elseif string.sub(result.from.phone, 0,5) == '98932' then
					number = number.."\n Simcard  : TALIA"
				elseif string.sub(result.from.phone, 0,4) == '9893' then
					number = number.."\n Simcard  : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9890' then
					number = number.."\n Simcard  : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9892' then
					number = number.."\n Simcard  : RIghtel"
				else
					number = number.."\n Simcard  : other"
				end
			else
				number = number.."\nSimcard : Other\nCountry : UNKnown"
			end
		else
			number = "-----"
		end
	end
	--info ------------------------------------------------------------------------------------------------
	info = " Full Name  : "..string.gsub(result.from.print_name, "_", " ").."\n"
	.." First Name  : "..(result.from.first_name or "-----").."\n"
	.." Last Name  : "..(result.from.last_name or "-----").."\n\n"
	.." Phone Number  : "..number.."\n"
	.." UserName  : @"..(result.from.username or "-----").."\n\n"
	.." Device  : "..hardware.."\n"
	.." Massage Type  : "..msg_type.."\n\n"
	send_large_msg(receiver, info)
end

local function callback_res(extra, success, result)
	if success == 0 then
		return send_large_msg(receiver, "Error  404  \n\n User not found")
	end
	--icon & rank ------------------------------------------------------------------------------------------------
	if tonumber(result.id) == 176972874 then
		userrank = " SILENT "
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/silent.webp", ok_cb, false)
	elseif is_sudo(result) then
		userrank = "Sudo"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/sudo.webp", ok_cb, false)
	elseif is_admin2(result.id) then
		userrank = "Admin"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/admin.webp", ok_cb, false)
	elseif is_owner2(result.id, extra.chat2) then
		userrank = "EX Admin"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/leader.webp", ok_cb, false)
	elseif is_momod2(result.id, extra.chat2) then
		userrank = "Mod"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/mod.webp", ok_cb, false)
	elseif tonumber(result.id) == tonumber(our_id) then
		userrank = "F80"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/umb.webp", ok_cb, false)
	elseif result.from.username then
		if string.sub(result.from.username:lower(), -3) == "bot" then
			userrank = "API Bot"
			send_document(get_receiver(msg), "/root/f80/umbrella/stickers/api.webp", ok_cb, false)
	else
		userrank = "Member"
	end
	end
	--custom rank ------------------------------------------------------------------------------------------------
	local file = io.open("./info/"..result.id..".txt", "r")
	if file ~= nil then
		usertype = file:read("*all")
	else
		usertype = "-----"
	end
	--phone ------------------------------------------------------------------------------------------------
	if access == 1 then
		if result.phone then
			number = "+"..string.sub(result.phone, 0)
			if string.sub(result.phone, 0,2) == '98' then
					number = number.."\nCountry : IRAN"
				elseif string.sub(result.from.phone, 0,1) == '1' then
					number = number.."\nCountry : U.S.A"
				elseif string.sub(result.from.phone, 0,2) == '62' then
				    number = number.."\nCountry : Indonesia"
				elseif string.sub(result.from.phone, 0,2) == '63' then
				    number = number.."\nCountry : Philippines"
				if string.sub(result.from.phone, 0,4) == '9891' then
					number = number.."\nSimcard : IR M.C.I"
				elseif string.sub(result.from.phone, 0,5) == '98932' then
					number = number.."\nSimcard : TALIA"
				elseif string.sub(result.from.phone, 0,4) == '9893' then
					number = number.."\nSimcard : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9890' then
					number = number.."\nSimcard : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9892' then
					number = number.."\nSimcard : RIghtel"
				else
					number = number.."\nSimcard : other"
				end
			else
				number = number.."\nSimcard : Other\nCountry : UNKnown"
			end
		else
			number = "-----"
		end
	elseif access == 0 then
		if result.phone then
			number = "YOU ARE NOT ALOW"
			if string.sub(result.phone, 0,2) == '98' then
					number = number.."\nCountry : IRAN"
				elseif string.sub(result.from.phone, 0,1) == '1' then
					number = number.."\nCountry : U.S.A"
				elseif string.sub(result.from.phone, 0,2) == '62' then
				    number = number.."\nCountry : Indonesia"
				elseif string.sub(result.from.phone, 0,2) == '63' then
				    number = number.."\nCountry : philipins"
				if string.sub(result.from.phone, 0,4) == '9891' then
					number = number.."\nSimcard : IR M.C.I"
				elseif string.sub(result.from.phone, 0,5) == '98932' then
					number = number.."\nSimcard : TALIA"
				elseif string.sub(result.from.phone, 0,4) == '9893' then
					number = number.."\nSimcard : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9890' then
					number = number.."\nSimcard : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9892' then
					number = number.."\nSimcard : RIghtel"
				else
					number = number.."\nSimcard : other"
				end
			else
				number = number.."\nSimcard : Other\nCountry : UNKnown"
			end
		else
			number = "-----"
		end
	end
	--info ------------------------------------------------------------------------------------------------
	info = "Full name: "..string.gsub(result.print_name, "_", " ").."\n"
	.."First Name: "..(result.first_name or "-----").."\n"
	.."Last Name: "..(result.last_name or "-----").."\n\n"
	.."Phone Number: "..number.."\n"
	.."UserName: @"..(result.username or "-----").."\n"
	.."TG ID: "..result.id.."\n\n"
	.."Nick Name: "..usertype.."\n"
	.."RANK: "..userrank.."\n\n"
	send_large_msg(receiver, info)
end

local function callback_info(extra, success, result)
	if success == 0 then
		return send_large_msg(receiver, "Error 404 \n\n TG ID not found")
	end
	--icon & rank ------------------------------------------------------------------------------------------------
	if tonumber(result.id) == 176972874 then
		userrank = " SILENT "
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/silent.webp", ok_cb, false)
	elseif is_sudo(result) then
		userrank = "Sudo"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/sudo.webp", ok_cb, false)
	elseif is_admin2(result.id) then
		userrank = "Admin"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/admin.webp", ok_cb, false)
	elseif is_owner2(result.id, extra.chat2) then
		userrank = "EX ADMIN"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/leader.webp", ok_cb, false)
	elseif is_momod2(result.id, extra.chat2) then
		userrank = "Moderator"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/mod.webp", ok_cb, false)
	elseif tonumber(result.id) == tonumber(our_id) then
		userrank = "F80"
		send_document(get_receiver(msg), "/root/f80/umbrella/stickers/umb.webp", ok_cb, false)
	elseif result.from.username then
		if string.sub(result.from.username:lower(), -3) == "bot" then
			userrank = "API Bot"
			send_document(get_receiver(msg), "/root/f80/umbrella/stickers/api.webp", ok_cb, false)
	else
		userrank = "Member"
	end
	end
	--custom rank ------------------------------------------------------------------------------------------------
	local file = io.open("./info/"..result.id..".txt", "r")
	if file ~= nil then
		usertype = file:read("*all")
	else
		usertype = "-----"
	end
	--phone ------------------------------------------------------------------------------------------------
	if access == 1 then
		if result.phone then
			number = "+"..string.sub(result.phone, 0)
			if string.sub(result.phone, 0,2) == '98' then
					number = number.."\nCountry : IRAN"
				elseif string.sub(result.from.phone, 0,1) == '1' then
					number = number.."\nCountry : U.S.A"
				elseif string.sub(result.from.phone, 0,2) == '62' then
				    number = number.."\nCountry : Indonesia"
				elseif string.sub(result.from.phone, 0,2) == '63' then
				    number = number.."\nCountry : Philippines"
				if string.sub(result.from.phone, 0,4) == '9891' then
					number = number.."\nSimcard : IR M.C.I"
				elseif string.sub(result.from.phone, 0,5) == '98932' then
					number = number.."\nSimcard : TALIA"
				elseif string.sub(result.from.phone, 0,4) == '9893' then
					number = number.."\nSimcard : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9890' then
					number = number.."\nSimcard : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9892' then
					number = number.."\nSimcard : RIghtel"
				else
					number = number.."\nSimcard : other"
				end
			else
				number = number.."\nSimcard : Other\nCountry : UNKnown"
			end
		else
			number = "-----"
		end
	elseif access == 0 then
		if result.phone then
			number = "YOU ARE NOT ALOW"
			if string.sub(result.phone, 0,2) == '98' then
					number = number.."\nCountry : IRAN"
				elseif string.sub(result.from.phone, 0,1) == '1' then
					number = number.."\nCountry : U.S.A"
				elseif string.sub(result.from.phone, 0,2) == '62' then
				    number = number.."\nCountry : Indonesia"
				elseif string.sub(result.from.phone, 0,2) == '63' then
				    number = number.."\nCountry : Philippines"
				if string.sub(result.from.phone, 0,4) == '9891' then
					number = number.."\nSimcard : IR M.C.I"
				elseif string.sub(result.from.phone, 0,5) == '98932' then
					number = number.."\nSimcard : TALIA"
				elseif string.sub(result.from.phone, 0,4) == '9893' then
					number = number.."\nSimcard : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9890' then
					number = number.."\nSimcard : Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9892' then
					number = number.."\nSimcard : RIghtel"
				else
					number = number.."\nSimcard : other"
				end
			else
				number = number.."\nSimcard : Other\nCountry : UNKnown"
			end
		else
			number = "-----"
		end
	end
	--name ------------------------------------------------------------------------------------------------
	if string.len(result.print_name) > 15 then
		fullname = string.sub(result.print_name, 0,15).."..."
	else
		fullname = result.print_name
	end
	if result.first_name then
		if string.len(result.first_name) > 15 then
			firstname = string.sub(result.first_name, 0,15).."..."
		else
			firstname = result.first_name
		end
	else
		firstname = "-----"
	end
	if result.last_name then
		if string.len(result.last_name) > 15 then
			lastname = string.sub(result.last_name, 0,15).."..."
		else
			lastname = result.last_name
		end
	else
		lastname = "-----"
	end
	--info ------------------------------------------------------------------------------------------------
	info = "Full name: "..string.gsub(result.print_name, "_", " ").."\n"
	.."FIRST NAME: "..(result.first_name or "-----").."\n"
	.."LAST NAME: "..(result.last_name or "-----").."\n\n"
	.."Phone number: "..number.."\n"
	.."USER NAME: @"..(result.username or "-----").."\n"
	.."TG ID: "..result.id.."\n\n"
	.."Nick Name: "..usertype.."\n"
	.."RANK: "..userrank.."\n\n"
	send_large_msg(receiver, info)
end

local function run(msg, matches)
	local data = load_data(_config.moderation.data)
	org_chat_id = "chat#id"..msg.to.id
	if is_sudo(msg) then
		access = 1
	else
		access = 0
	end
	if matches[1] == '/infodel' and is_sudo(msg) then
		azlemagham = io.popen('rm ./info/'..matches[2]..'.txt'):read('*all')
		return 'USER UNRANKED'
	elseif matches[1] == '/info' and is_sudo(msg) then
		local name = string.sub(matches[2], 1, 50)
		local text = string.sub(matches[3], 1, 10000000000)
		local file = io.open("./info/"..name..".txt", "w")
		file:write(text)
		file:flush()
		file:close() 
		return "USER RANKED"
	elseif #matches == 2 then
		local cbres_extra = {chatid = msg.to.id}
		if string.match(matches[2], '^%d+$') then
			return user_info('user#id'..matches[2], callback_info, cbres_extra)
		else
			return res_user(matches[2]:gsub("@",""), callback_res, cbres_extra)
		end
	else
		--custom rank ------------------------------------------------------------------------------------------------
		local file = io.open("./info/"..msg.from.id..".txt", "r")
		if file ~= nil then
			usertype = file:read("*all")
		else
			usertype = "-----"
		end
		--hardware ------------------------------------------------------------------------------------------------
		if matches[1]:lower() == "info" then
			hardware = "Computer"
		else
			hardware = "MOBILE"
		end
		if not msg.reply_id then
			--contor ------------------------------------------------------------------------------------------------
			local user_info = {}
			local uhash = 'user:'..msg.from.id
			local user = redis:hgetall(uhash)
			local um_hash = 'msgs:'..msg.from.id..':'..msg.to.id
			user_info.msgs = tonumber(redis:get(um_hash) or 0)
			--icon & rank ------------------------------------------------------------------------------------------------
			if tonumber(msg.from.id) == 176972874 then
				userrank = " SILENT "
				send_document("channel#id"..msg.to.id,"umbrella/stickers/silent.webp", ok_cb, false)
			elseif is_sudo(msg) then
				userrank = "Sudo"
				send_document("channel#id"..msg.to.id,"umbrella/stickers/sudo.webp", ok_cb, false)
			elseif is_admin1(msg) then
				userrank = "Admin"
				send_document("channel#id"..msg.to.id,"umbrella/stickers/admin.webp", ok_cb, false)
			elseif is_owner(msg) then
				userrank = "EX Admin"
				send_document("channel#id"..msg.to.id,"umbrella/stickers/leader.webp", ok_cb, false)
			elseif is_momod(msg) then
				userrank = "Mod"
				send_document("channel#id"..msg.to.id,"umbrella/stickers/mod.webp", ok_cb, false)
			else
				userrank = "Member"
			end
			--number ------------------------------------------------------------------------------------------------
			if msg.from.phone then
				numberorg = string.sub(msg.from.phone, 0)
				number = "****+"..string.sub(numberorg, 0,6)
				if string.sub(msg.from.phone, 0,2) == '98' then
						number = number.."\n Country  : IRAN"
					elseif string.sub(msg.from.phone, 0,1) == '1' then
						number = number.. "\n Country  : U.S.A"
					elseif string.sub(msg.from.phone, 0,2) == '63' then
						number = number.. "\n Country  : Philippines"
					if string.sub(msg.from.phone, 0,4) == '9891' then
						number = number.."\n Simcard  : Ir M.C.I"
					elseif string.sub(msg.from.phone, 0,5) == '98932' then
						number = number.."\n Simcard  : TALIA"
					elseif string.sub(msg.from.phone, 0,4) == '9893' then
						number = number.."\n Simcard  : Irancell"
					elseif string.sub(msg.from.phone, 0,4) == '9890' then
						number = number.."\n Simcard  : Irancell"
					elseif string.sub(msg.from.phone, 0,4) == '9892' then
						number = number.."\n Simcard  : Rightel"
					else
						number = number.."\n Simcard  : Other"
					end
				else
					number = number.."\n Simcard  : Other\n Country  : UNKnown"
				end
			else
				number = "-----"
			end
			--info ------------------------------------------------------------------------------------------------
			local info = " Full Name : "..string.gsub(msg.from.print_name, "_", " ").."\n"
					.." FIRST NAME : "..(msg.from.first_name or "-----").."\n"
					.." LAST NAME : "..(msg.from.last_name or "-----").."\n\n"
					.." PHONE Number : "..number.."\n"
					.." USER NAME : @"..(msg.from.username or "-----").."\n"
					.." TG ID : "..msg.from.id.."\n\n"
					.." Nick Name : "..usertype.."\n"
					.." RANK : "..userrank.."\n\n"
					.." Device : "..hardware.."\n"
					.." Total massages : "..user_info.msgs.."\n"
					.." Group/Super Group Name : "..string.gsub(msg.to.print_name, "_", " ").."\n"
					.." Group/Super ID : "..msg.to.id
			return info
		else
			get_message(msg.reply_id, callback_reply, false)
		end
	end
end

return {
	patterns = {
		"^(/infodel) (.*)$",
		"^(/info) ([^%s]+) (.*)$",
		"^([Ii]nfo) (.*)$",
		"^(info)$",
		"^[/!#](info)$",
		"^(Info)$",
		"^[/!#](Info)$",
	},
	run = run,
}
