SWEP.PrintName		= "Force Heal"
SWEP.Author			= "Lambda Gaming"
SWEP.Instructions	= ""
SWEP.Slot			= 3

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

function SWEP:Initialize()
	self:SetHoldType("magic")
end

function SWEP.DrawWorldModel()
	return false
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end

function SWEP:PrimaryAttack()
local target = self.Owner:GetEyeTrace().Entity
local pos = target:GetPos()
	if ( !target:IsPlayer() or target:Health() >= 100 or pos:Distance(self.Owner:GetPos()) >= 150 ) then return end

	self:SetNextPrimaryFire( CurTime() + 0.5 )

	local ed = EffectData()
	ed:SetOrigin( target:GetPos() )
	util.Effect( "rb655_force_heal", ed, true, true )

	target:SetHealth( target:Health() + 1 )
	if target:IsOnFire() then target:Extinguish() end
end

function SWEP:SecondaryAttack()
	if ( !self.Owner:IsPlayer() or self.Owner:Health() >= 100 ) then return end
	
	self:SetNextSecondaryFire( CurTime() + 0.5 )
	
	local ed = EffectData()
	ed:SetOrigin( self.Owner:GetPos() )
	util.Effect( "rb655_force_heal", ed, true, true )
	
	self.Owner:SetHealth( self.Owner:Health() +1 )
	if self.Owner:IsOnFire() then self.Owner:Extinguish() end
end