AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( 'shared.lua' )

local ConfigMap = { 
	"fightspace3b",
	"gm_balkans",
	"gm_bigcity",
	"gm_bigisland",
	"gm_blackmesa_sigma",
	"gm_bluehills_test3",
	"gm_boreas",
	"gm_botmap_v3",
	"gm_construct",
	"gm_construct_flagrass_v6-2",
	"gm_dddustbowl2",
	"gm_drivingmap_workshop",
	"gm_flatgrass",
	"gm_flatgrass_abs_v3c",
	"gm_fork",
	"gm_freespace_09_extended",
	"gm_functional_flatgrass3",
	"gm_genesis",
	"gm_highway14800",
	"gm_lunarbase",
	"gm_mobenix_v3_final",
	"gm_mountainlake2",
	"gm_range_f4",
	"gm_secretconstruct_v3",
	"gm_tornadoflatgrass",
	"gm_tornadohighway_final",
	"gm_tornadonightfall",
	"gm_tornadovillage_final",
	"gm_underground_iv",
	"gm_valley",
	"gm_warmap_v5",
	"rp_rockford_open",
	"gm_atomic",
	"rp_bmrf",
	"rp_city17_build210",
	"rp_ineu_valley2_v1a",
	"rp_sectorc_beta",
	"gm_wuhu"
}

function ENT:SpawnFunction( ply, tr, name )
	if not tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
	self:SetModel( "models/props_combine/breenconsole.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use( caller, activator )
    if !caller:IsSuperAdmin() then caller:ChatPrint( "Only superadmins can use this console!" ) return end
    if caller:IsSuperAdmin() then
		local random = table.Random( ConfigMap )
		local time = 5
		caller:EmitSound( "buttons/combine_button1.wav" )
		for k, ply in pairs( player.GetAll() ) do
			ply:ChatPrint( "Server changing to random map in:" )
			self:EmitSound( "buttons/blip1.wav" )
			timer.Simple( 6, function() ply:ChatPrint( "1" ) end )
			timer.Create( "ChangeTimer", 1, 5, function()
				v:ChatPrint( tostring( time ) )
				if time > 1 then
					self:EmitSound( "buttons/blip1.wav" )
				else
					self:EmitSound( "plats/elevbell1.wav" )
				end
				time = time - 1
			end )
			timer.Simple( 7, function() RunConsoleCommand( "changelevel", random ) end )
		end
	end
end