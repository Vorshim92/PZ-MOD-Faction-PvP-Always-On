
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
--- @return {Boolean} - Returns the faction the player is in. If the player is not
---    in a faction, false is returned.
------------------------------------------------------------------------------------------

local getFaction = function(username)

  -- ArrayList<Faction>
  local factions      = Faction:getFactions();
  local faction_count = factions:size()      ;

  -- Make sure that we have factions on the server before trying to locate the
  ---  instance of the player's faction.
  if faction_count == 0 then return false end

  -- Go through all factions and compare usernames of members to the player.
  for index = 1, faction_count, 1 do

    local faction = factions:get(index - 1);

    if faction
    then
        local faction_owner_username = faction:getOwner();

        if faction_owner_username == username then return true end

        -- ArrayList<String>
        local faction_members       = faction:getPlayers()  ;
        local faction_members_count = faction_members:size();

        -- Go through the members to see if the username of the player is present.
        for member_index = 1, faction_members_count, 1 do

          -- If the username is found in the members list, return the faction.
          if faction_members:get(member_index - 1) == username then return true end
        end
    end

  end

  -- No faction has the player's name in it. Return false.
  return false;

end




------------------------------------------------------------------------------------------
--
-- @param {player} player -
--
-- @return {Void}
------------------------------------------------------------------------------------------
local processFactionPvpOn = function(player)

    if not player:isFactionPvp()  then
        player:setFactionPvp(true);
        sendPlayerStatsChange(player);
        
    end

end
local processFactionPvpOff = function(player)

    if player:isFactionPvp() then
        player:setFactionPvp(false);
        sendPlayerStatsChange(player);
        
    end

end

------------------------------------------------------------------------------------------

local function setFactionPvpMod()

    if not isClient() then return end
    
    local player = getPlayer();
    local username = player:getUsername();


    local faction = getFaction(username);
    if faction then
      if getSandboxOptions():getOptionByName("FactionPvP.Alwayson"):getValue() then
        processFactionPvpOn(player);
      else
        processFactionPvpOff(player)
      end
    end
end



Events.OnGameStart.Add(setFactionPvpMod);
Events.EveryTenMinutes.Add(setFactionPvpMod)
