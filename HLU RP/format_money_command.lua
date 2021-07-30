
--[[
	State: Finished

	Description: Runs an SQL command through DarkRP that resets the wallets of all registered players
	to 3000. This was used on HLU RP to reset wallets every session to avoid inflation that would have
	resulted in unbalanced teams.
	
	Reason for Removal: The server moved away from using individual wallets to using a global budget that the facility administrator managed.
]]

if SERVER then
	hook.Add( "PlayerSay", "playersayresetmoney", function( ply, text, public )
		if ( text == "!resetmoney" ) and ply:IsSuperAdmin() then
			ply:ConCommand( "resetmoney" )
			return ""
        end
	end )
end

--Using mysqlite since darkrp doesn't directly support resetting EVERYONES money at once, including superadmins and offline players
if SERVER then
    concommand.Add( "resetmoney", function() 
		MySQLite.query( [[ UPDATE darkrp_player SET wallet = 3000 ]] )
		DarkRP.notifyAll( 1, 6, "Everyone's money has been successfully reset." )
	end )
end