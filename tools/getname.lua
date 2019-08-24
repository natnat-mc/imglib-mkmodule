local fs, JSON=require 'fs', require 'JSON'
local a=JSON.parse(fs.readFileSync('module.info'))
print(a.name..'-'..a.version)
