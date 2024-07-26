
local baseaddress = Memory.GetBaseAddress("GTA5.exe")
local targetFuncAddr = baseaddress + 0x183A640 

local trampolineSize = 12

local trampoline = Memory.Alloc(trampolineSize + 5)

local originalBytes = {}
for i = 0, trampolineSize - 1 do
    originalBytes[i] = Memory.ReadByte(targetFuncAddr + i)
end

for i = 0, trampolineSize - 1 do
    Memory.WriteByte(trampoline + i, originalBytes[i])
end

local returnAddress = targetFuncAddr + trampolineSize
local jumpBack = { 0xE9, (returnAddress - trampoline - trampolineSize - 5) & 0xFF, ((returnAddress - trampoline - trampolineSize - 5) >> 8) & 0xFF, ((returnAddress - trampoline - trampolineSize - 5) >> 16) & 0xFF, ((returnAddress - trampoline - trampolineSize - 5) >> 24) & 0xFF }
for i = 0, 4 do
    Memory.WriteByte(trampoline + trampolineSize + i, jumpBack[i])
end

local hookFuncAddr = Memory.Alloc(5)
local hook = { 0xE9, (hookFuncAddr - targetFuncAddr - 5) & 0xFF, ((hookFuncAddr - targetFuncAddr - 5) >> 8) & 0xFF, ((hookFuncAddr - targetFuncAddr - 5) >> 16) & 0xFF, ((hookFuncAddr - targetFuncAddr - 5) >> 24) & 0xFF }

for i = 0, 4 do
    Memory.WriteByte(targetFuncAddr + i, hook[i])
end

function hookFunction()
    print("Hooked function called!")
    
    Memory.LuaCallCFunction(trampoline)
end

local hookFuncCode = string.dump(hookFunction)
local hookFuncSize = #hookFuncCode
local hookFuncMem = Memory.Alloc(hookFuncSize)

for i = 1, hookFuncSize do
    Memory.WriteByte(hookFuncMem + i - 1, string.byte(hookFuncCode, i))
end

hookFuncAddr = hookFuncMem

function targetFunction()
    print("Original function called!")
end

local Address = Memory.Scan

local Address = Memory.Scan("48 8D 0D ? ? ? ? F3 0F 10 04 81 F3 0F 11 05", "GTA5.exe")
local valueAtAddress = Memory.ReadByte(Address)
Logger.Log(eLogColor.RED, "PATTERN SCAN", ("Value at 0x%X quals 0x%X"):format(Address, valueAtAddress))
targetFunction()
