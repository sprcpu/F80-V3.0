
local function run(msg, matches)
if matches[1]:lower() == "logo>" then
    local receiver = get_receiver(msg)
    local site = matches[2]
	local url = "http://logo.clearbit.com/"..site.."?size=500&greyscale=true"
	local randoms = math.random(1000,900000)
	local randomd = randoms..".jpg"
	local file = download_to_file(url,randomd)
	local cb_extra = {file_path=file}
    send_photo(receiver, file, rmtmp_cb, cb_extra)
end
if matches[1]:lower() == "logo" then
local receiver = get_receiver(msg)
    local site = matches[2]
	local url = "http://logo.clearbit.com/"..site.."?size=800"
	local randoms = math.random(1000,900000)
	local randomd = randoms..".jpg"
	local file = download_to_file(url,randomd)
	local cb_extra = {file_path=file}
    send_photo(receiver, file, rmtmp_cb, cb_extra)
end
end
return {
  patterns = {
		"^[#!/]([Ll][Oo][Gg][Oo]>) (.*)$",
        "^[#!/]([Ll][Oo][Gg][Oo]) (.*)$",
        "^([Ll][Oo][Gg][Oo]>) (.*)$",
        "^([Ll][Oo][Gg][Oo]) (.*)$",
  }, 
  run = run 
}
