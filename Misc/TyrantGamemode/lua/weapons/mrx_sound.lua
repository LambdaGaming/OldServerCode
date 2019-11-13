SWEP.PrintName		= "Mr. X Sound Emitter"
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
	if IsFirstTimePredicted() and SERVER then
		local pos = self.Owner:GetEyeTrace().HitPos
		if pos:DistToSqr( self.Owner:GetPos() ) < 10000 then
			if !self.Owner:GetNWBool( "SpawnedSpeaker" ) then
				local e = ents.Create( "tyrant_soundemitter" )
				e:SetPos( pos + Vector( 0, 0, 15 ) )
				e:Spawn()
				e:SetNWEntity( "Owner", self.Owner )
				self.Owner:SetNWBool( "SpawnedSpeaker", true )
				self.Owner:ChatPrint( "You have placed your sound emitter." )
			else
				self.Owner:ChatPrint( "You have already spawned your sound emitter!" )
				return
			end
		else
			self.Owner:ChatPrint( "Cannot place sound emitter, move closer to target." )
		end
	end
	self:SetNextPrimaryFire( 1 )
end

function SWEP:SecondaryAttack()
	if IsFirstTimePredicted() and SERVER then
		local ent = self.Owner:GetEyeTrace().Entity
		if !IsValid( ent ) then return end
		if ent:GetPos():DistToSqr( self.Owner:GetPos() ) < 10000 then
			if ent:GetClass() == "tyrant_soundemitter" then
				ent:Remove()
				self.Owner:ChatPrint( "You have removed your sound emitter." )
				self.Owner:SetNWBool( "SpawnedSpeaker", false )
			else
				self.Owner:ChatPrint( "Sound emitter not detected." )
			end
		else
			self.Owner:ChatPrint( "Cannot remove sound emitter, move closer to target." )
		end
	end
	self:SetNextSecondaryFire( 1 )
end