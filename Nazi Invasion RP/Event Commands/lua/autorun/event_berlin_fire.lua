
concommand.Add( "event_berlin_fire", function()
	if SERVER then
		local pos = {
			Vector( -6540, 8503, 7552 ),
			Vector( -6729, 8503, 7552 ),
			Vector( -6358, 8503, 7552 ),
			Vector( -6121, 8528, 7981 ),
			Vector( -6953, 8528, 7994 ),
			Vector( -6839, 8605, 8384 ),
			Vector( -6307, 8355, 8229 ),
			Vector( -6383, 8528, 7967 ),
			Vector( -7316, 8528, 7628 ),
			Vector( -5310, 8464, 8280 )
		}
		for k,v in ipairs( pos ) do
			CreateVFireBall( 1200, 10, v + Vector( 0, 0, 50 ), Vector( 0, 0, 0 ), nil )
		end
		
		for a,b in pairs(player.GetAll()) do
			b:ChatPrint("The Reichstag has burst into flames!")
		end
	end
end )