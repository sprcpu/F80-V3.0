local function get_hex(str)
  local colors = {
    red = "r",
    blue = "b",
    green = "g",
    yellow = "y",
    purple = "f0f",
    white = "w",
    black = "b",
    gray = "g"
  }

  for color, value in pairs(colors) do
    if color == str then
      return value
    end
  end

  return str
end

local function qr(receiver, text, color, bgcolor)

  local url = "http://api.qrserver.com/v1/create-qr-code/?"
    .."size=600x600"  --fixed size otherways it's low detailed
    .."&data="..URL.escape(text:trim())

  if color then
    url = url.."&color="..get_hex(color)
  end
  if bgcolor then
    url = url.."&bgcolor="..get_hex(bgcolor)
  end

  local response, code, headers = http.request(url)

  if code ~= 200 then
    return "Oops! Error: " .. code
  end

  if #response > 0 then
	  send_photo_from_url(receiver, url)
	return

  end
  return "Oops! Something strange happened :("
end

local function run(msg, matches)
  local receiver = get_receiver(msg)

  local text = matches[1]
  local color
  local back

  if #matches > 1 then
    text = matches[3]
    color = matches[2]
    back = matches[1]
  end

  return qr(receiver, text, color, back)
end

return {
  patterns = {
    '^[Qq]rcode "(%w+)" "(%w+)" (.+)$',
    "^[Qq]rcode (.+)$"
  },
  run = run
}
