ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName = "Deer"
ENT.Author = "SynysterDemon"
ENT.Contact = "SynysterDemon"
ENT.Information		= ""
ENT.Category		= "Syn's Animals"

ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.AutomaticFrameAdvance = true

function ENT:PhysicsCollide( data, physobj )
end

function ENT:PhysicsUpdate( physobj )
end
  
function ENT:SetAutomaticFrameAdvance( bUsingAnim )

self.AutomaticFrameAdvance = bUsingAnim

end