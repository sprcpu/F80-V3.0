local function history(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, '"'..#result..'"cleaned', ok_cb, false)
  else
    send_msg(extra.chatid, 'cleaned', ok_cb, false)
  end
end
local function run(msg, matches)
  if matches[1]:lower() == 'rmsg' and is_owner(msg) then
    if msg.to.type == 'channel' then
      if tonumber(matches[2]) > 1000 or tonumber(matches[2]) < 1 then
        return "number must be [1-500]"
      end
      get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
    else
      return 
    end
  else
    return 
  end
end

return {
    patterns = {
        '^[!/#](rmsg) (%d*)$',
		'^([Rr]msg) (%d*)$',
    },
    run = run
}