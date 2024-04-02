local on = require('lib.samp.events')
local damage_status = false

function handleDamage(playerId, damage, weapon)
    if playerId ~= 65535 and damage_status then
        local playerName = sampGetPlayerNickname(playerId)
        local message = string.format("[id by timmu] You have been damaged by player %s (ID: %d)", playerName, playerId)
        sampAddChatMessage(message, 0xFFFFFF) -- Sending notification to chat
        local id = playerId
        sampSendChat("/time") -- Automatically executing the /time command
        sampSendChat("/id " .. id) -- Automatically executing the /id command
        damage_status = false
    end
end

function on.onSendTakeDamage(playerId, damage, weapon)
    handleDamage(playerId, damage, weapon)
end

function main()
    repeat wait(0) until isSampAvailable()
    
    while true do
        wait(0)
        if isKeyDown(57) then
            damage_status = not damage_status
            if damage_status then
                sampAddChatMessage("[id by timmu] Damage tracking mode {00FF00}enabled", -1) -- Green color if tracking is enabled
            else
                sampAddChatMessage('[id by timmu] Damage tracking mode {FF0000}disabled', -1) -- Red color if tracking is disabled
            end
        end
    end
end
