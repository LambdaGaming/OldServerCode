
--[[
	State: Finished and Working

	Description: This was used on the Nazi Invasion RP server to prevent players from spawning props if there was an active shopkeeper on the server.
	
	Reason for Removal: Server was replaced with Zombie RP.
]]

local function ShopkeeperHook( ply )
	if game.GetMap() == "rp_stalingrad_gamizer" or game.GetMap() == "rp_1944berlin_v1" then
		if team.NumPlayers( TEAM_SHOPKEEPER ) == 0 then return end
		if ply:Team() != TEAM_SHOPKEEPER then
			ply:ChatPrint( "You must buy props from the shopkeeper." )
			return false
		end
	end
end
hook.Add( "PlayerSpawnProp", "Shopkeeper", ShopkeeperHook )