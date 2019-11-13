
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Tyrant Sound Emitter"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Tyrant"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "tyrant_soundemitter" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props_wasteland/speakercluster01a.mdl" )
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

	timer.Create( tostring( self:EntIndex() ), 0.5, 0, function()
		self:EmitSound( "tyrant/xfoot"..math.random( 1, 3 )..".wav" )
	end )
end

function ENT:Use( activator, caller )
	if activator:Team() == TEAM_SWATCOMMANDER or activator:Team() == TEAM_SWAT then
		activator:ChatPrint( "You have removed a Mr. X sound emitter." )
		self:Remove()
	end
end

function ENT:OnRemove()
	timer.Remove( self:EntIndex() )
	local owner = self:GetNWEntity( "Owner" )
	owner:SetNWBool( "SpawnedSpeaker", false )
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end