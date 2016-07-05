local function run(msg, matches)
  local yon = http.request('http://api.yon.ir/?url='..URL.escape(matches[1]))
  local jdat = json:decode(yon)
  local bitly = https.request('https://api-ssl.bitly.com/v3/shorten?access_token=f2d0b4eabb524aaaf22fbc51ca620ae0fa16753d&longUrl='..URL.escape(matches[1]))
  local data = json:decode(bitly)
  local yeo = http.request('http://yeo.ir/api.php?url='..URL.escape(matches[1])..'=')
 local opizo = http.request('http://cruel-plus.ir/opizo.php?url='..URL.escape(matches[1])..'&mail=mohammadmahdi13791@yahoo.com')
  local u2s = http.request('http://u2s.ir/?api=1&return_text=1&url='..URL.escape(matches[1]))
  local llink = http.request('http://llink.ir/yourls-api.php?signature=a13360d6d8&action=shorturl&url='..URL.escape(matches[1])..'&format=simple')
 
    return ' Original  :\n'..data.data.long_url..'\nEnd \n shorted by Bitly \n'..data.data.url..'\nEnd\nshorted by Yeo :\n'..yeo..'\nEnd\nshorted by Opizo :\n'..opizo..'\nEnd\nshorted by U2S :\n'..u2s..'\nEnd\nshorted by Llink : \n'..llink..'\nEnd\n shorted by Yon : \nyon.ir/'..jdat.output..''
end
return {
  patterns = {
    "^[Ss][Hh][Oo][Rr][Tt] (.*)$"
  },
  run = run
}