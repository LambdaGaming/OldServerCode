AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local cooldowntimer = 300

local allowedteams = {
	TEAM_SPY,
	TEAM_JEW
}

function ENT:Initialize()
	self:SetModel( "models/props_supplies/german/field-radio03.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

    local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end
end

function ENT:Use( activator, caller )
	if !table.HasValue( allowedteams, activator:Team() ) then activator:ChatPrint( "This radio serves no use to you. Move along." ) return end
	if activator:IsPlayer() and !timer.Exists( "Intel_Timer" ) then
		timer.Create( "Intel_Timer", cooldowntimer, 1, function() end )
		local intel = ents.Create( "intel" )
		intel:Spawn()
		intel:SetPos( self.Entity:GetPos() + Vector( 0, 0, 45 ) )
		self:EmitSound( "ambient/levels/prison/radio_random"..math.random( 1, 15 )..".wav" )
		DarkRP.notify( activator, 1, 3, "You have gained valuable intel by overhearing radio converstations." )
	elseif timer.Exists( "Intel_Timer" ) then
		DarkRP.notify( activator, 1, 5, "The channel is currently silent, come back later to see if there is any activity." )
	end
end

function ENT:OnRemove()
	if timer.Exists( "Intel_Timer" ) then timer.Remove( "Intel_Timer" ) end
end