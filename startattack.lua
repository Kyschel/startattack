-- startattack.lua
--
-- Author: Kyschel
-- Description: Locates player attack action on actionbar and starts/stops attack on command (/startattack, /stopattack)
--
-- GlobalVariablesPerCharacter from startattack.toc:
-- AttackActionSlot

SLASH_STARTATTACK1 = "/startattack"
SLASH_STOPATTACK1 = "/stopattack"

local function verifyAttackSlot(s)
    return (IsAttackAction(s) and GetActionTexture(s) == GetInventoryItemTexture("player", 16))
end

local function findAttackSlot()
    local actionslot = nil
    for i=1,120 do
        if verifyAttackSlot(i) then
            actionslot = i
        end
    end
    return actionslot
end

local function startAttack(start)
    if AttackActionSlot == nil then
        AttackActionSlot = findAttackSlot()
    elseif not verifyAttackSlot(AttackActionSlot) then
        AttackActionSlot = findAttackSlot()
    end
    
    if AttackActionSlot == nil then
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FFFFstartattack|r: No attack action found on your actionbars!")
        return
    end        
    
    if (start and not IsCurrentAction(AttackActionSlot)) or (not start and IsCurrentAction(AttackActionSlot)) then
        UseAction(AttackActionSlot)
    end
end

function startattack()
    startAttack(true)
end

function stopattack()
    startAttack(false)
end

SlashCmdList.STARTATTACK = startattack
SlashCmdList.STOPATTACK = stopattack
