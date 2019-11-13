
if SERVER then
	hook.Add( "PlayerFootstep", "TyrantFootstepChange", function( ply, pos, foot, sound, volume )
		if ply:Team() == TEAM_MRX and !ply:Crouching() then
			ply:EmitSound( "tyrant/xfoot"..math.random( 1, 3 )..".wav" )
			return true
		end
	end )

	local function RemoveSoundEmitter()
		for k,v in pairs( ents.FindByClass( "tyrant_soundemitter" ) ) do
			v:Remove()
		end
	end

	hook.Add( "OnPlayerChangeTeam", "TyrantTeamChange", function( ply, old, new )
		if old == TEAM_MRX then
			RemoveSoundEmitter()
		end
	end )

	hook.Add( "PlayerDisconnected", "TyrantDisconnect", function( ply )
		if ply:Team() == TEAM_MRX then
			RemoveSoundEmitter()
		end
	end )

	hook.Add( "DoPlayerDeath", "TyrantPlayerDeath", function( ply, attacker, dmg )
		if ply:IsFrozen() then
			ply:Freeze( false )
		end
	end )

	hook.Add( "PlayerCanPickupItem", "TyrantItemPickup", function( ply, ent )
		if ent:GetClass() == "tyrant_swatitem" then
			return true
		end
	end )

	local swatspawns = {
		Vector( -2436, 1438, -3583 ),
		Vector( -2493, -1092, 25 ),
		Vector( -2350, -1094, 5 ),
		Vector( -2177, -1080, 2 ),
		Vector( -1991, -1059, 11 ),
		Vector( -2001, -797, 17 ),
		Vector( -2164, -805, 5 ),
		Vector( -2355, -794, 1 ),
		Vector( -2552, -804, 2 ),
		Vector( -2805, -715, 5 )
	}

	local zombiespawns = {
		Vector( -4793, 560, -3583 ),
		Vector( -5213, 10640, 64 )
	}

	hook.Add( "InitPostEntity", "TyrantPostEntity", function()
		for k,v in ipairs( swatspawns ) do
			local e = ents.Create( "tyrant_spawn_swat" )
			e:SetPos( v )
			e:Spawn()
		end
		for k,v in ipairs( zombiespawns ) do
			local e = ents.Create( "tyrant_spawn_zombie" )
			e:SetPos( v )
			e:Spawn()
		end
	end )

	hook.Add( "PlayerSelectTeamSpawn", "TyrantTeamSpawn", function( team, ply )
		if team == TEAM_MRX then
			return "tyrant_spawn_zombie"
		elseif team == TEAM_SWAT or team == TEAM_SWATCOMMANDER then
			return "tyrant_spawn_swat"
		end
	end )
end

if CLIENT then
	hook.Add( "PreDrawHalos", "SwatItemHalo", function()
		if LocalPlayer():Team() == TEAM_MRX or LocalPlayer():GetNWBool( "CanSeeFlag" ) then
			halo.Add( ents.FindByClass( "tyrant_swatitem" ), Color( 0, 255, 0 ), 1, 1, 2, true, true )
		end
	end )
end