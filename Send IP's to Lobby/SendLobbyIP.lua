--iiferedon#1337
g_lua.register();

g_gui.add_button("session_general", "Send All IP's", "Send IP's in lobby", function() troll_ip() end)

function troll_ip()
    for i=0,31 do
        if PLAYER.IS_PLAYER_VALID(i) then
            if i ~= PLAYER.PLAYER_ID() then
            local rid = PLAYER.GET_PLAYER_SCID(i)
            local name = PLAYER.GET_PLAYER_NAME(i)
            n = PLAYER.GET_PLAYER_IP(i)
            n1 = math.floor(n / (2^24))
            n2 = math.floor((n - n1*(2^24)) / (2^16))
            n3 = math.floor((n - n1*(2^24) - n2*(2^16)) / (2^8))
            n4 = math.floor((n - n1*(2^24) - n2*(2^16) - n3*(2^8)))
            local ip = tostring(n1..'.'..n2..'.'..n3..'.'..n4)
            info = {name, rid, ip}
            message = name.." - "..ip.." - "..rid
            NETWORK.SEND_CHAT_MESSAGE_AS(i, message, false)
            g_logger.log_info(message)
            g_util.yield(500)
            end
        end
    end
end

while g_isRunning do
    g_util.yield(100)
end

g_lua.unregister();
