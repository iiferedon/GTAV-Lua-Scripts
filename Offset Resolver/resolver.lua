--roulette tables
local natives = FileMgr.GetMenuRootPath() .. "\\Lua\\natives.lua"
dofile(natives)

local baseaddress = Memory.GetBaseAddress("GTA5.exe")

local function resolver(baseaddress, offsets, write_console)
    local addr = Memory.ReadUInt(baseaddress)
    if write_console then
        Logger.Log(eLogColor.CYAN, "BRANCH", string.format("0x%X", addr))
    end
    
    for i = 1, #offsets do
        addr = Memory.ReadUInt(addr + offsets[i])
        if write_console then
            local color = (i == #offsets) and eLogColor.GREEN or eLogColor.LIGHTBLUE
            Logger.Log(color, "MEMORY", string.format("Offset %d (0x%X): 0x%X", i, offsets[i], addr))
        end
    end
    return addr
end

local read_tables = {
    {0, 0xF28, 0x108, 0x4F8},
    {0, 0xF28, 0x108, 0x500},
    {0, 0xF28, 0x108, 0x530},
    {0, 0xF28, 0x108, 0x538}
}

local write_table = 
{0, 0xF28, 0x108
}

local roulettehandle = baseaddress + 0x0296AD10

for _, read_table in ipairs(read_tables) do
    resolver(roulettehandle, read_table, true)
end


Memory.WriteUInt(resolver(roulettehandle,write_table) + 0x4F8, 8)
Memory.WriteUInt(resolver(roulettehandle,write_table) + 0x500, 8)
Memory.WriteUInt(resolver(roulettehandle,write_table) + 0x530, 8)
Memory.WriteUInt(resolver(roulettehandle,write_table) + 0x538, 8)
