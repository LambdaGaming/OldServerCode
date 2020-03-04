AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local allyweapon = {
	"weapon_752_thompson",
	"weapon_752_m1garand",
	"weapon_752_m1carbine",
	"weapon_752_spring_s",
	"weapon_752_colt"
}

local randomintel = {
	"V2 Rocket",
	"Horten 229 Stealth Bomber",
	"Goliath Mobile Mine",
	"V1 Cruise Missile",
	"V3 Cannon",
	"Gustav Rail Cannon",
	"Arado 234 Jet Bomber",
	"Heinkel 280 Jet Fighter",
	"Flettner 282 Kolibri Helicopter",
	"Fliegerfaust Rocket Launcher",
	"Panzerkampfwagen VIII Maus Tank",
	"Type XXI U-boat",
	"Die Glocke"
}

function ENT:Initialize()
	self:SetModel( "models/props_lab/clipboard.mdl" )
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
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
		if v:GetClass() == "ally_npc" then
			caller:Give( table.Random( allyweapon ) )
			caller:ChatPrint( "By helping the allies gain valuable intel on the '"..table.Random( randomintel ).."' you have been rewarded with an ally weapon." )
			self:Remove()
		end
	end
end
