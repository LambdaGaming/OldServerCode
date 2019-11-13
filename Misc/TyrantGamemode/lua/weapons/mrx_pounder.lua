
SWEP.PrintName		= "Mr. X Ground Pound"
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
	self:SetHoldType( "fist" )
end

function SWEP.DrawWorldModel()
	return false
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end

function SWEP:PrimaryAttack()
	if !self.Owner:IsOnGround() then return end
	if IsFirstTimePredicted() and SERVER then
		self.Owner:Freeze( true )
		timer.Simple( 3, function()
			if IsValid( self ) and IsValid( self.Owner ) and self.Owner:Alive() then
				self.Owner:Freeze( false )
			end
		end )
		self.Owner:EmitSound( "ambient/machines/wall_crash1.wav" )
		for k,v in pairs( ents.FindInSphere( self.Owner:GetPos(), 300 ) ) do
			if v:IsPlayer() and v != self.Owner then
				v:TakeDamage( 30, self.Owner, self )
				v:Freeze( true )
				timer.Simple( 5, function()
					if IsValid( v ) and v:Alive() then
						v:Freeze( false )
					end
				end )
			end
			if v:IsNPC() then
				v:TakeDamage( v:Health(), self.Owner, self )
			end
		end
		self.Owner:TakeDamage( 100, self.Owner, self )
		util.ScreenShake( self.Owner:GetPos(), 20, 20, 3, 300 )
		local effectdata = EffectData()
		effectdata:SetOrigin( self.Owner:GetPos() )
		effectdata:SetNormal( self.Owner:GetAngles():Forward() )
		effectdata:SetMagnitude( 1000 )
		effectdata:SetScale( 1000 )
		util.Effect( "ThumperDust", effectdata, true, true )
	end
	self:SetNextPrimaryFire( CurTime() + 60 )
end