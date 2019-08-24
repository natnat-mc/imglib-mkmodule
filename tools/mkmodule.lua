local fs=require 'fs'
local JSON=require 'JSON'

local extensions={}
for i=2, #process.argv do
	table.insert(extensions, process.argv[i]:gsub("%.", '%%.')..'$')
end

local function exploredir(dir, list)
	local function matchesext(file)
		if #extensions==0 then
			return true
		end
		for i, reg in ipairs(extensions) do
			if string.match(file, reg) then
				return true
			end
		end
		return false
	end
	
	local function exploreimp(intdir)
		local lcdir=intdir and (dir..'/'..intdir) or dir
		local files=fs.readdirSync(lcdir)
		for i, file in ipairs(files) do
			local fpath=lcdir..'/'..file
			local lfpath=intdir and (intdir..'/'..file) or file
			if fs.statSync(fpath).type=='directory' then
				exploreimp(lfpath)
			elseif matchesext(file) then
				list[lfpath]=fpath
			end
		end
	end
	exploreimp(nil)
end

local sourcefiles={}
exploredir('src', sourcefiles)
if fs.statSync 'data' then
	exploredir('data', sourcefiles)
end

local pack={}
for k, v in pairs(sourcefiles) do
	pack[k]=fs.readFileSync(v)
end
fs.writeFileSync('module.pack', JSON.stringify(pack))
