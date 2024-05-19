
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

    -- Controlla il valore di "FactionPvP.Alwayson" nelle opzioni del sandbox
    if getSandboxOptions():getOptionByName("FactionPvP.Alwayson"):getValue() then
        -- Se il PvP di fazione non è già attivo, attivalo
        if not self.player:isFactionPvp() then
            self.player:setFactionPvp(true);
            sendPlayerStatsChange(self.player);
        end
    else
        -- Se il PvP di fazione è attivo, disattivalo
        if self.player:isFactionPvp() then
            self.player:setFactionPvp(false);
            sendPlayerStatsChange(self.player);
        end
    end

    -- Disabilita l'opzione PvP di fazione nell'interfaccia
    self.factionPvp.enable = false;
    -- Aggiorna lo stato selezionato del PvP di fazione
    self.factionPvp.selected[1] = self.player:isFactionPvp();
end
