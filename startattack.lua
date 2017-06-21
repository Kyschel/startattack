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
    return IsAttackAction(s)
end

local function findAttackSlot()
    for i=1,120 do
        if verifyAttackSlot(i) then
            return i
        end
    end
end

local function startAttack(start)
    if not AttackActionSlot or not verifyAttackSlot(AttackActionSlot) then
        AttackActionSlot = findAttackSlot()
        
        if not AttackActionSlot then
            DEFAULT_CHAT_FRAME:AddMessage("|cFF00FFFFstartattack|r: No attack action found on your actionbars!")
            return
        end  
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
