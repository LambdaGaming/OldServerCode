AddCSLuaFile()

ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Ally NPC"
ENT.Category = "Intelligence System"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
	self:SetModel( "models/player/dod_american.mdl" )
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid( SOLID_BBOX )
		self:SetUseType( SIMPLE_USE )
		self:SetHullType( HULL_HUMAN )
		self:SetHullSizeNormal()
		self:DropToFloor()
	end
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
end

function ENT:Use(activator, caller)
	DarkRP.notify( activator, 1, 3, "Press your use key on intel to give it to the allies." )
end

function ENT:Think()
	self:SetSequence( "idle_all_02" )
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		local Ang = self:GetAngles()
		Ang:RotateAroundAxis( Ang:Forward(), 90 )
		Ang:RotateAroundAxis( Ang:Right(), -90 )
		cam.Start3D2D( self:GetPos() + ( self:GetUp() * 85 ), Ang, 0.35 )
			draw.SimpleTextOutlined( "Ally NPC", "Trebuchet24", 0, 0, Color( 75, 83, 32, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 25, 25, 25 ) )
		cam.End3D2D()
	end
end
