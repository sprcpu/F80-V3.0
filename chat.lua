function run(msg, matches)	
if matches[1]:lower() == "arisharr" or "silent" or "sudo" then
return "@pahrmakill | @silent_poker"
end
if matches[1]:lower() == "slm" and not is_sudo(msg) then
return "سلام گشاد"
end
if matches[1]:lower() == "slm" and is_sudo(msg) then
return "سلامـ  بابایـ  خوشگلمـ 🌝"
end
if matches[1]:lower() == "bye" and not is_sudo(msg) then
return "خدافس"
end
if matches[1]:lower() == "bye"  or "bedrood" or "bdrod" or "bdrood" or "bedrud" and is_sudo(msg) then
return "خدافس باباجونیـ ●…●‌"
end
if matches[1]:lower() == "silent" or "arisharr" then
return "با بابامـ  چی کار داری \n اذیتش کنی میخورمت😊"
end
if matches[1]:lower() == "SilenT_POKER" or "pharmakill" then 
return "بابامه●~●"
end
if matches[1]:lower() == "kir" and not is_sudo(msg) then 
return "نداری بگیر:|"
end 
if matches[1]:lower() == "کیر" and not is_sudo(msg) then 
return "نداری بگیر"
end
if matches[1]:lower() == "بای" and is_sudo(msg) then 
return "●…● خدافس باباجونیـ"
end
if matches[1]:lower() == "بای" and not is_sudo(msg) then
return "bby"
end
if matches[1]:lower() == "سلام" and is_sudo(msg) then 
return "سلامـ باباجونیـ خوشگلمـ"
end
if matches[1]:lower() == "سلام" and not is_sudo(msg) then
return "سلام"
end
if matches[1]:lower() == "+banall" and is_admin1(msg) then 
return "0 b fuke raft:|"
end
if matches[1]:lower() == "س" or and not is_sudo(msg) then
return "سلامـ گشاد"
end 
if matches[1]:lower() == "😐" then
return "😐"
end
end
return {
patterns = {
"^(bye)$",
"(arisharr)",
"(sudo)",
"^(slm)$",
"^(silent)$",
"@(SilenT_POKER)",
"@(pharmakill)",
"(kir)",
"^(کیر)$",
"(f80)",
"^(بای)$",
"^(سلام)$",
"(+banall)",
"^(س)$",
"^😐$",
},
run = run
}