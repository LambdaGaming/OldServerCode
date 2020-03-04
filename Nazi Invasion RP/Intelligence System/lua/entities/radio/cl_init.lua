include('shared.lua')

function ENT:Draw()
    self:DrawModel()
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis( Ang:Forward(), 90 )
	Ang:RotateAroundAxis( Ang:Right(), -90 )
	cam.Start3D2D( self:GetPos() + ( self:GetUp() * 50 ), Ang, 0.35 )
		draw.SimpleTextOutlined( "Communications Radio", "Trebuchet24", 0, 0, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 25, 25, 25 ) )
	cam.End3D2D()
end