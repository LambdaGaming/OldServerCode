
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Tyrant Flag"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Tyrant"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "tyrant_swatitem" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/Gibs/HGIBS.mdl" )
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

function ENT:Think()
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
		if v:IsPlayer() and v:Team() == TEAM_MRX then
			v:SetHealth( math.Clamp( v:Health() + 21, 0, 2500 ) )
		end
	end
	self:NextThink( CurTime() + 1 )
	return true
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end