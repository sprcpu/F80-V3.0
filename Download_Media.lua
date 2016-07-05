local function callback(extra, success, result)
  if success then
    print('File downloaded to:', result)
  else
    print('Error downloading: '..extra)
  end
end

local function run(msg, matches)
  if not is_member(msg) then
    return
  end
  if msg.media then
    if msg.media.type == 'photo' then
      load_photo(msg.id, callback, msg.id)
    end
  end
end

local function pre_process(msg)
  if not msg.text and msg.media then
    msg.text = '['..msg.media.type..']'
  end
  return msg
end

return {
  run = run,
  patterns = {
    '%[(photo)%]',
	'%[(gif)%]',
	'%[(document)%]',
	'%[(video)%]',
	'%[(music)%]'
	},
  pre_process = pre_process
}