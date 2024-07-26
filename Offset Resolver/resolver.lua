--roulette tables
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

local handle = baseaddress + 0x0296AD10

local offset_table = {
{0, 0xF28, 0x108, 0x4F8},
    {0, 0xF28, 0x108, 0x500},
    {0, 0xF28, 0x108, 0x530},
    {0, 0xF28, 0x108, 0x538}
}
resolver(handle,offset_table, true)
