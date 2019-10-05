SWEP.PrintName		= "Ship Part Repair Tool"
SWEP.Author			= "Lambda Gaming"
SWEP.Instructions	= ""
SWEP.Slot			= 3
SWEP.Base			= "weapon_base"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.ViewModel = "models/weapons/c_toolgun.mdl"
SWEP.WorldModel = "models/weapons/w_toolgun.mdl"
SWEP.UseHands = true

function SWEP:Initialize()
	self:SetHoldType("pistol")
end

function SWEP:PrimaryAttack()
	if ( IsFirstTimePredicted() ) then
	local eyetrace = self.Owner:GetEyeTrace().Entity
	local pos = eyetrace:GetPos()

	if CLIENT and ( eyetrace:IsPlayer() or pos:Distance( self.Owner:GetPos() ) >= 500 ) then self.Owner:ChatPrint("ERROR: Entity is either invalid or too far away.") return end
	if CLIENT and ( eyetrace:Health() >= eyetrace:GetMaxHealth() ) then self.Owner:ChatPrint("This entity's health is at "..eyetrace:Health()..", which is it's max.") return end
	
	if eyetrace:Health() <= eyetrace:GetMaxHealth() then eyetrace:SetHealth( eyetrace:Health() + 3) else return end
	if CLIENT then self.Owner:ChatPrint("Current entity health: "..math.Round( eyetrace:Health(), 1 )..".") end
	end
	self:SetNextPrimaryFire( CurTime() + 0.5 )
end

function SWEP:SecondaryAttack()
end