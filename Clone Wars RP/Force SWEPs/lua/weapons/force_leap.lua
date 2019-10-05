SWEP.PrintName		= "Force Leap"
SWEP.Author			= "Lambda Gaming"
SWEP.Instructions	= ""
SWEP.Slot			= 3
SWEP.Base			= "weapon_base"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
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
	if ( !self.Owner:IsOnGround() ) then return end

	self:SetNextPrimaryFire( 0.5 )

	self.Owner:SetVelocity( self.Owner:GetAimVector() * 512 + Vector( 0, 0, 512 ) )

	self.Owner:EmitSound( "lightsaber/force_leap.wav" )

	self:CallOnClient( "ForceJumpAnim", "" )
end

function SWEP:SecondaryAttack()
end