
--[[
	State: Finished and Working
	
	Description: This was a system for CityRP that slowly brought down the economy points if there
	was no mayor on the server. The amount of points deducted depended on how many total players were
	on the server.
	
	Reason for Removal: If you've played on CityRP, you'll know that not many players like to become mayor
	and this didn't change anything. It was removed after multiple players complained about it bringing
	down the economy with no way to stop it since nobody wanted to become mayor to keep the
	economy stabalized.
]]

timer.Create( "MayorCheck", 300, 0, function()
	if team.NumPlayers( TEAM_MAYOR ) < 1 then
		if GetGlobalInt( "MAYOR_EcoPoints" ) >= -45 then
			if player.GetCount() <= 4 then return end
			if player.GetCount() == 5 then
				SetGlobalInt( "MAYOR_EcoPoints", GetGlobalInt( "MAYOR_EcoPoints" ) - 1 )
			elseif player.GetCount() >= 6 then
				SetGlobalInt( "MAYOR_EcoPoints", GetGlobalInt( "MAYOR_EcoPoints" ) - 2 )
				if SERVER then
					DarkRP.notifyAll( 1, 6, "The economy is going down because there is no mayor!" )
				end
			end
		end
	end
end )