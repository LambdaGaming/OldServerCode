
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

function ENT:Initialize()
    self:SetModel( "models/Gibs/HGIBS.mdl" )
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
end

function ENT:DrawModel()
	return false
end