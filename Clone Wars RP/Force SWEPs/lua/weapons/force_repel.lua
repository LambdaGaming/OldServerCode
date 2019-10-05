SWEP.PrintName		= "Force Repel"
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

function SWEP:PrimaryAttack()
			if ( !self.NextForceEffect or self.NextForceEffect < CurTime() ) then
				local ed = EffectData()
				ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 36 ) )
				ed:SetRadius( 128 )
				util.Effect( "rb655_force_repulse_in", ed, true, true )

				self.NextForceEffect = CurTime() + math.Clamp( 20, 0.1, 0.5 )
			end

		local maxdist = 128

		for i, e in pairs( ents.FindInSphere( self.Owner:GetPos(), maxdist ) ) do
			if ( e == self.Owner ) then continue end

			local dist = self.Owner:GetPos():Distance( e:GetPos() )
			local mul = ( maxdist - dist ) / 256

			local v = ( self.Owner:GetPos() - e:GetPos() ):GetNormalized()
			v.z = 0

			if ( e:IsPlayer() && e:IsOnGround() ) then
				e:SetVelocity( v * mul * -1000 + Vector( 0, 0, 400 ) )
			elseif ( e:IsPlayer() && !e:IsOnGround() ) then
				e:SetVelocity( v * mul * -1000 + Vector( 0, 0, 400 ) )
			elseif ( e:GetPhysicsObjectCount() > 0 ) then
				for i = 0, e:GetPhysicsObjectCount() - 1 do
					e:GetPhysicsObjectNum( i ):ApplyForceCenter( v * mul * -500 * math.min( e:GetPhysicsObject():GetMass(), 256 ) + Vector( 0, 0, 600 ) )
				end
			end
		end

		local ed = EffectData()
		ed:SetOrigin( self.Owner:GetPos() + Vector( 0, 0, 36 ) )
		ed:SetRadius( maxdist )
		util.Effect( "rb655_force_repulse_out", ed, true, true )

		self._ForceRepulse = nil

		self:SetNextPrimaryFire( CurTime() + 5 )

		self.Owner:EmitSound( "lightsaber/force_repulse.wav" )
end

function SWEP:SecondaryAttack()
end