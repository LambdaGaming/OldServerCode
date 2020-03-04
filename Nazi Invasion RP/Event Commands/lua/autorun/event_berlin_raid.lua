
concommand.Add( "event_berlin_raid", function()
	if SERVER then
		for k,v in pairs( player.GetAll() ) do
			v:ChatPrint( "Bomber incoming! Seek shelter!" ) --Main chat and sound effects
			v:SendLua( "surface.PlaySound( 'nazi_invasion/air_raid_siren_distant.ogg' )" )
			v:SendLua( "surface.PlaySound( 'nazi_invasion/b17_bomber_flypast_03.ogg' )" )
		end
		
		local expos = {
			Vector( -13502, 6119, 7368 ),
			Vector( -13502, 6119, 7368 ),
			Vector( -13107, 6126, 7368 ),
			Vector( -12508, 6114, 7368 ),
			Vector( -11997, 6113, 7368 ),
			Vector( -11554, 6110, 7368 ),
			Vector( 2571, -5427, 7753 ),
			Vector( 3039, -5436, 7416 ),
			Vector( 3435, -5440, 7416 ),
			Vector( 3820, -5431, 7416 ),
			Vector( 4288, -5408, 7707 )
		}
		
		for k,v in ipairs( expos ) do
			timer.Create( "Event_Berlin_Raid"..k, 0.5 + k, 1, function()
				local e = ents.Create("env_explosion")
				e:SetPos( v )
				e:Spawn()
				e:SetKeyValue( "iMagnitude", "200" )
				e:Fire( "Explode", 0, 0 )
			end )
		end
	end
end )