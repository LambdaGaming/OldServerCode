
--[[
	State: Finished and Working

	Description: This was used on the Nazi Invasion RP server by Nazi jobs to hand out work permits to German citizens so they can legally make money in the RP.
	
	Reason for Removal: Server was replaced with Zombie RP.
]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Work Permit Desk"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "work_permit_desk" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props_interiors/Furniture_Desk01a.mdl" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)

		local e1 = ents.Create( "prop_dynamic" )
		e1:SetPos( self:GetPos() + Vector( 0, -10, 20 ) )
		e1:SetModel( "models/props_lab/clipboard.mdl" )
		e1:SetParent( self )
		e1:Spawn()

		local e2 = ents.Create( "prop_dynamic" )
		e2:SetPos( self:GetPos() + Vector( 0, 10, 20 ) )
		e2:SetModel( "models/props_lab/clipboard.mdl" )
		e2:SetParent( self )
		e2:Spawn()
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
		TEAM_WEHRMACHTOFFICER,
		TEAM_WEHRMACHTPRIVATE,
		TEAM_WEHRMACHTSERGEANT,
		TEAM_CONSCRIPT,
		TEAM_PARTISAN,
		TEAM_SOVIETPRIVATE,
		TEAM_SOVIETOFFICER,
	}

	local plyjob = activator:Team()

	if table.HasValue( axisjobs, plyjob ) then
		local e = ents.Create( "rp_sign" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 50 ) )
		e:Spawn()
	else
		DarkRP.notify( activator, 1, 6, "You do not have the propper job to use the work permit desk." )
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end