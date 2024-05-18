
------------------------------------------------------------------------------------------
--
-- @author Vorshim
--
------------------------------------------------------------------------------------------


--************************************************************************--
--** ISFactionUI:initialise
--**
--************************************************************************--
local ISFactionUIext_initialise = ISFactionUI.initialise;

function ISFactionUI:initialise(...)
           -- Chiama la funzione originale

    ISFactionUIext_initialise(self, ...);


    if getSandboxOptions():getOptionByName("FactionPvP.Alwayson"):getValue() then
        self.player:setFactionPvp(true);
        sendPlayerStatsChange(self.player);
    else 
        self.player:setFactionPvp(false);
        sendPlayerStatsChange(self.player);
    end
    self.factionPvp.enable = false;
    self.factionPvp.selected[1] = self.player:isFactionPvp();

end


