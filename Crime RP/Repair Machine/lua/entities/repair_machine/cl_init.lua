include('shared.lua')

function ENT:Draw()
    self:DrawModel()
			local Ang = self:GetAngles()

		Ang:RotateAroundAxis(Ang:Forward(), 90)
		Ang:RotateAroundAxis(Ang:Right(), -90)
		
		cam.Start3D2D(self:GetPos() + (self:GetUp() * 80), Ang, 0.35)
			draw.SimpleTextOutlined("Repair Machine", "Trebuchet24", 0, 0, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(25, 25, 25))
		cam.End3D2D()
end

local function Check()
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Repair Station" )
	Frame:SetSize( 300, 150 )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 230, 150 ) )
	end

	local Button = vgui.Create( "DButton", Frame )
	Button:SetText( "Purchase Repair Tool ($500)" )
	Button:SetTextColor( Color( 255, 255, 255 ) )
	Button:SetPos( 100, 100 )
	Button:SetSize( 200, 30 )
	Button:Center()
	Button.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 150, 150, 150, 255 ) )
	end
	Button.DoClick = function()
		Frame:Remove()
		net.Start( "repair_purchase" )
		net.SendToServer()
	end
end
usermessage.Hook( "repair_purchase", Check )