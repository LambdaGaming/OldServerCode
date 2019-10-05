SWEP.PrintName		= "Force Lightning"
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
	if ( !target:IsPlayer() or pos:Distance(self.Owner:GetPos()) >= 150 ) then return end

			local ed = EffectData()
			ed:SetOrigin( self.Owner:GetPos() + Vector( -10, -25, 55 ) )
			ed:SetEntity( target )
			util.Effect( "rb655_force_lighting", ed, true, true )
			
			if SERVER then
				local dmg = DamageInfo()
				dmg:SetAttacker( self.Owner )
				dmg:SetInflictor( self.Owner )

				dmg:SetDamage( 0.5 )
				target:TakeDamageInfo( dmg )
			end
			
			if ( !self.SoundLightning ) then
				self.SoundLightning = CreateSound( self.Owner, "lightsaber/force_lightning" .. math.random( 1, 2 ) .. ".wav" )
				self.SoundLightning:Play()
			else
				self.SoundLightning:Play()
			end

			timer.Create( "rb655_force_lighting_soundkill", 0.2, 1, function() if ( self.SoundLightning ) then self.SoundLightning:Stop() self.SoundLightning = nil end end )
		self:SetNextPrimaryFire( CurTime() + 0.1 )
end

function SWEP:SecondaryAttack()
end