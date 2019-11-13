SWEP.PrintName		= "SWAT Item Viewer"
SWEP.Author			= "Lambda Gaming"
SWEP.Instructions	= ""
SWEP.Slot			= 4
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
	self:SetHoldType( "camera" )
end

function SWEP.DrawWorldModel()
	return false
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
	self.Owner:SetNWBool( "CanSeeFlag", true )
end

function SWEP:Holster()
	if IsFirstTimePredicted() then
		self.Owner:SetNWBool( "CanSeeFlag", false )
		return true
	end
end