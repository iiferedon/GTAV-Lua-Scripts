function set_bounty(target, amount)
    if anonymous then
        anonymous = 1
    else
        anonymous = 0
    end
    bounty = amount or bounty
    for id= 0, 31 do
        s.send_se(id, {1294995624, id, target, 1, bounty, 0, anonymous,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, SCRIPT.GET_GLOBAL_I(1921036 + 9), SCRIPT.GET_GLOBAL_I(1921036 + 10)})
    end
end

function bounty_all()
    for i = 0, 31 do
        if i == get.id() then goto next end
        if s.is_friend(i) and tostring(table_settings[1][2]) == 'true' then goto next end
        if not s.is_connected(i) then goto next end
        set_bounty(i)
        ::next::
    end
end
