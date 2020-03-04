
--[[
	State: Finished and Working

	Description: This was used on the Nazi Invasion RP server by Nazi jobs to call in airstrikes through the Gredwitch addon.
	
	Reason for Removal: Server was replaced with Zombie RP.
]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Air Strike Station"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "air_strike_station" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props_lab/workspace003.mdl" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use( activator, caller )
	local axisjobs = {
		TEAM_FUHRER,
		TEAM_SS,
		TEAM_GESTAPO,
		TEAM_ORDERPOLICE,
		TEAM_DOCTOR,
		TEAM_GERMAN,
		TEAM_WEHRMACHTOFFICER,
		TEAM_WEHRMACHTPRIVATE,
		TEAM_WEHRMACHTSERGEANT,
		TEAM_CONSCRIPT,
		TEAM_SHOPKEEPER
	}

	local allyjobs = {
		TEAM_SOVIET,
		TEAM_PARTISAN,
		TEAM_SOVIETPRIVATE,
		TEAM_SOVIETOFFICER,
		TEAM_FRENCH,
		TEAM_AMERICANSERGEANT,
		TEAM_AMERICANPRIVATE,
		TEAM_SPY,
		TEAM_JEW
	}

	local axisweps = {
		"gred_axis_he111",
		"gred_axis_stuka"
	}

	local allyweps = {
		"gred_allies_b17e"
	}

	local plyjob = activator:Team()

	if timer.Exists( "Air_Strike_Cooldown" ) then
		DarkRP.notify( activator, 1, 6, "Please wait for the cooldown to end before calling another air strike." )
		return
	end
	if table.HasValue( axisjobs, plyjob ) then
		activator:Give( table.Random( axisweps ) )
	elseif table.HasValue( allyjobs, plyjob ) then
		activator:Give( table.Random( allyweps ) )
	else
		DarkRP.notify( activator, 1, 6, "Cannot use the air strike station. Invalid job." )
		return
	end
	timer.Create( "Air_Strike_Cooldown", 1200, 1, function() end )
	DarkRP.notify( activator, 0, 6, "You have been given binoculars to mark the air strike location." )
end

function ENT:OnRemove()
	if timer.Exists( "Air_Strike_Cooldown" ) then timer.Remove( "Air_Strike_Cooldown" ) end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end