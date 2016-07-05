local function run(msg, matches)
  if matches[1]:lower() == "dgithub" then
    local dat = https.request("https://api.github.com/repos/"..matches[2])
    local jdat = JSON.decode(dat)
    if jdat.message then
      return "Not Found"
      end
    local base = "curl 'https://codeload.github.com/"..matches[2].."/zip/master'"
    local data = io.popen(base):read('*all')
    f = io.open("file/github.zip", "w+")
    f:write(data)
    f:close()
    return send_document("channel#id"..msg.to.id, "file/github.zip", ok_cb, false)
  else
    local dat = https.request("https://api.github.com/repos/"..matches[2])
    local jdat = JSON.decode(dat)
    if jdat.message then
      return "Not Found"
      end
    local res = https.request(jdat.owner.url)
    local jres = JSON.decode(res)
    send_photo_from_url("channel#id"..msg.to.id, jdat.owner.avatar_url)
    return "Info OF Github:\n"
      .."Name: "..(jres.name or "-----").."\n"
      .."Username: "..jdat.owner.login.."\n"
      .."Company Name: "..(jres.company or "-----").."\n"
      .."Site: "..(jres.blog or "-----").."\n"
      .."Email: "..(jres.email or "-----").."\n"
      .."Location: "..(jres.location or "-----").."\n"
      .."Project Count: "..jres.public_repos.."\n"
      .."Falowers: "..jres.followers.."\n"
      .."Falowing: "..jres.following.."\n"
      .."Date created: "..jres.created_at.."\n"
      .."Bio: "..(jres.bio or "-----").."\n\n"
      .."Info:\n"
      .."Project Name: "..jdat.name.."\n"
      .."Git page: "..jdat.html_url.."\n"
      .."Source Pak: "..jdat.clone_url.."\n"
      .."Project Web: "..(jdat.homepage or "-----").."\n"
      .."Date Crated: "..jdat.created_at.."\n"
      .."Last Update: "..(jdat.updated_at or "-----").."\n"
      .."Langage: "..(jdat.language or "-----").."\n"
      .."Script Size: "..jdat.size.."\n"
      .."Stars: "..jdat.stargazers_count.."\n"
      .."Seens: "..jdat.watchers_count.."\n"
      .."Forks Count: "..jdat.forks_count.."\n"
      .."Developmers: "..jdat.subscribers_count.."\n"
      .."About Project:\n"..(jdat.description or "-----").."\n"
  end
end

return {
  patterns = {
    "^([dD]github) (.*)",
    "^([Gg]ithub) (.*)",
	"^([/!#][Gg]ithub>) (.*)",
    "^([/!#][Gg]ithub) (.*)",
    },
  run = run
}
