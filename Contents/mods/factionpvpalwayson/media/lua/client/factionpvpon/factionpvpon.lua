------------------------------------------------------------------------------------------
--
-- @author Vorshim
--
------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
--- Grabs a player's faction if the player is in one.
---
--- @param {String} username - The player in a faction.
---
--- @return {Boolean} - Returns true if the player is in a faction, otherwise false.
------------------------------------------------------------------------------------------
local function getFaction(username)
  local factions = Faction:getFactions()
  local faction_count = factions:size()

  if faction_count == 0 then 
      return false 
  end

  for index = 1, faction_count do
      local faction = factions:get(index - 1)

      if faction then
          if faction:getOwner() == username then 
              return true 
          end

          local faction_members = faction:getPlayers()
          local faction_members_count = faction_members:size()

          for member_index = 1, faction_members_count do
              if faction_members:get(member_index - 1) == username then 
                  return true 
              end
          end
      end
  end

  return false
end

------------------------------------------------------------------------------------------
--- Processes enabling faction PvP for a player.
---
--- @param {player} player - The player whose faction PvP status to set.
---
--- @return {Void}
------------------------------------------------------------------------------------------
local function processFactionPvpOn(player)
  if not player:isFactionPvp() then
      player:setFactionPvp(true)
      sendPlayerStatsChange(player)
  end
end

------------------------------------------------------------------------------------------
--- Processes disabling faction PvP for a player.
---
--- @param {player} player - The player whose faction PvP status to unset.
---
--- @return {Void}
------------------------------------------------------------------------------------------
local function processFactionPvpOff(player)
  if player:isFactionPvp() then
      player:setFactionPvp(false)
      sendPlayerStatsChange(player)
  end
end

------------------------------------------------------------------------------------------
--- Sets the faction PvP mode based on sandbox options and player faction status.
---
--- @return {Void}
------------------------------------------------------------------------------------------
local function setFactionPvpMod()
  if not isClient() then 
      return 
  end

  local player = getPlayer()
  local username = player:getUsername()
  local faction = getFaction(username)

  if faction then
      if getSandboxOptions():getOptionByName("FactionPvP.Alwayson"):getValue() then
          processFactionPvpOn(player)
      else
          processFactionPvpOff(player)
      end
  end
end

Events.OnGameStart.Add(setFactionPvpMod)
Events.EveryTenMinutes.Add(setFactionPvpMod)
