do

local function callback(extra, success, result)
  vardump(success)
  vardump(result)
end

local function run(msg, matches)
 if matches[1]:lower() == 'addarrishar' or matches[1]:lower() == 'اداریشر' then
        chat = 'channel#'..msg.to.id
        user1 = 'user#'..139817189
        channel_invite(channel, user1, callback, false)
	return "Adding  sudo..."
      end
if matches[1]:lower() == 'addsilent' or matches[1]:lower() == 'ادسایلنت' then
        chat = 'channel#'..msg.to.id
        user2 = 'user#'..176972874
        channel_invite(channel, user2, callback, false)
	return "Adding silent(dev)..."
      end
 
 end

return {
  patterns = {
    "^[#!/]([Aa][Dd][Dd][Ss][Ii][Ll][Ee][Nn][Tt])",
    "^[#!/]([Aa][Dd][Dd][Aa][Rr][Ii][Ss][Hh][Aa][Rr])",
	"^(ادسایلنت)$",
	"^[#!/](اداریشر)$",
    "^([Aa][Dd][Dd][Ss][Ii][Ll][Ee][Nn][Tt])",
	"^(اداریشر)$",
	"^[#!/](ادسایلنت)$",
    "^([Aa][Dd][Dd][Aa][Rr][Ii][Ss][Hh][Aa][Rr])",
  }, 
  run = run,
}


end