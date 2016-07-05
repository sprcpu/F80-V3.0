local database = 'http://cruel-plus.ir/joke/'
local function run(msg)
  local res = http.request(database.."joke.db")
  local joke = res:split(",")
  return joke[math.random(#joke)]
end

return {
  patterns = {"^([Jj]oke)$"},
  run = run
}