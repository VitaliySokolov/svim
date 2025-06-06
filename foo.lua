print("hello")
local i = 5
i = i + 1
print(i)

print("hhhh hhh")
local en = vim.fn.shellescape("he wild", "%")
local s = "here there"
local en2 = vim.fn.system('jq -Rr @uri <<< "' .. s .. '"')
print(en2)
local cmd = '!x-www-browser "http://google.com/search?q='
  .. en2:gsub("\n", "")
  .. '"'
-- vim.cmd(cmd) -- .. cmd)
print(cmd)
