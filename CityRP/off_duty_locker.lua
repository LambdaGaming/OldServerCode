
--[[
	State: Finished
	
	Description: This was an entity in CityRP that allowed police jobs to go off-duty while still being
	able to hold their job position. It would keep and store job-specific weapons in the locker until
	the player was ready to go back on-duty.
	
	Reason for Removal: It was on the server for about a year and was only used around 3 times, which
	means our playerbase is probably a bit too small for something like this to be useful.
]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Off Duty Locker"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Vending Machines and Lockers"

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props_c17/Lockers001a.mdl" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function GetCPTotal()
	local team = team
	local cpcount = team.NumPlayers( TEAM_MAYOR ) + team.NumPlayers( TEAM_POLICEBOSS ) + team.NumPlayers( TEAM_OFFICER ) + team.NumPlayers( TEAM_SWATBOSS ) + team.NumPlayers( TEAM_SWAT ) + team.NumPlayers( TEAM_UNDERCOVER ) + team.NumPlayers( TEAM_FBI )
	return cpcount
end

function ENT:Use( activator, caller )
	if !caller:isCP() then caller:ChatPrint( "Only government jobs can use this locker!" ) return end
	local jobTable = caller:getJobTable()
	local callerteam = team.GetName( caller:Team() )
	if caller:GetNWBool( "OffDuty" ) then
		if jobTable.weapons then
			for k,v in pairs( jobTable.weapons ) do
				caller:Give( v )
			end
			caller:ConCommand( "say /job "..callerteam )
			caller:ChatPrint( "You have successfully gone on-duty." )
			caller:SetNWBool( "OffDuty", false )
		end
	else
		if GetCPTotal() < 2 then caller:ChatPrint( "There aren't enough government officials on the server for you to go off-duty." ) return end
		for k,v in pairs( caller:GetWeapons() ) do
			if jobTable.weapons and table.HasValue( jobTable.weapons, v:GetClass() ) then
				v:Remove()
			end
		end
		caller:ConCommand( "say /job Off-Duty" )
		caller:ChatPrint( "You have successfully gone off-duty." )
		caller:SetNWBool( "OffDuty", true )
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
		local plyShootPos = LocalPlayer():GetShootPos()
		if self:GetPos():DistToSqr( plyShootPos ) < 562500 then
			local pos = self:GetPos()
			pos.z = pos.z + 15
			local ang = self:GetAngles()
			
			surface.SetFont("Bebas40Font")
			local title = "Off-Duty Locker"
			local tw = surface.GetTextSize(title)
			
			ang:RotateAroundAxis(ang:Forward(), 90)
			ang:RotateAroundAxis(ang:Right(), -90)
			local textang = ang
			
			cam.Start3D2D(pos + ang:Right() * -12, ang, 0.2)
				draw.WordBox(2, -tw *0.5 + 5, -180, title, "Bebas40Font", color_theme, color_white)
			cam.End3D2D()
		end
    end
end

if SERVER then
	hook.Add( "OnPlayerChangedTeam", "OffDutyDisable", function( ply )
		ply:SetNWBool( "OffDuty", false	)
	end )

	hook.Add( "PlayerDeath", "OffDutyDeath", function( ply )
		ply:SetNWBool( "OffDuty", false	)
	end )
end