AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
 
	self:SetModel( "models/props_wasteland/gaspump001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end
 
function ENT:Use( activator, caller )
	if caller:HasWeapon("vc_repair") then DarkRP.notify(caller, 1, 3, "You already have a repair tool!") return end
	umsg.Start( "repair_purchase" )
	umsg.End()
end

util.AddNetworkString( "repair_purchase" )
net.Receive( "repair_purchase", function( len, ply )
	if ply:IsPlayer() then
		ply:Give("vc_repair")
		ply:addMoney(-500) --Gives the player the repair tool and deducts 500 from their wallet
		DarkRP.notify(ply, 3, 4, "You have paid $500 for a one-time-use car repair tool.")
	end
end )