function save_value(msg, name, value)
  if (not name or not value) then
    return nil
  end
  
  local hash = nil
  if msg.to.type == 'chat' then
    hash = 'chat:'..msg.to.id..':variables'
  end
  if msg.to.type == 'user' then
    hash = 'user:'..msg.from.id..':variables'
  end
  if hash then
    redis:hset(hash, name, value)
    return "ثبت شد مطلبه "..name
  end
end

local function run(msg, matches)
  local name = string.sub(matches[1], 1, 50)
  local value = string.sub(matches[2], 1, 1000)

  local text = save_value(msg, name, value)
  return text
end

return {
  description = "Save Variables. For View Use /get", 
  usage = "/save (value) (msg) : saves message in value",
  patterns = {
   "(ثبت کردن) ([^%s]+) (.+)$",
  }, 
  run = run,
  moderated = true
}
