TOOL.ClientConVar[ "source_size" ] = "10";
TOOL.ClientConVar[ "source_intensity" ] = "100";
TOOL.ClientConVar[ "zone_size" ] = "256";
cleanup.Register( "radiation" );

TOOL.Category		= "100 Rads";
TOOL.Name			= "Radiation Zone";
TOOL.Command		= nil;
TOOL.ConfigName		= "";

if( SERVER ) then
	
	function TOOL:MakeRadiationZone( ply, tr, ang, source_size, source_intensity, zone_size )
		
		local zone = ents.Create( "kingston_radiation" );
		zone:SetSourceSize(source_size)
		zone:SetSourceIntensity(source_intensity)
		zone:SetZoneSize(zone_size)
		zone:SetPos( tr.HitPos + tr.HitNormal * 12 )
		zone:Spawn()
		zone:Activate()
		
		ply:AddCount( "radiation", zone );
		ply:AddCleanup( "radiation", zone );
		
		undo.Create( "radiation" );
			undo.AddEntity( zone );
			undo.SetPlayer( ply );
		undo.Finish();
		
	end
	
else
	
	language.Add( "tool.radiation.name", "Radiation Zone" );
	language.Add( "tool.radiation.desc", "Create a radiation zone." );
	language.Add( "tool.radiation.0", "Click somewhere to spawn a zone." );
	
	language.Add( "Undone_radiation", "Undone radiation zone." );
	language.Add( "Cleanup_radiation", "radiation" );
	language.Add( "Cleaned_radiation", "Cleaned up all radiation zones." );
	
end


function TOOL:LeftClick( tr )
	
	if( !SERVER ) then return true end
	
	local source_size	= self:GetClientInfo( "source_size" );
	local source_intensity = self:GetClientNumber( "source_intensity" );
	local zone_size = self:GetClientNumber( "zone_size" );
	local ply = self:GetOwner();
	local ang = ply:GetAimVector():Angle();
	
	self:MakeRadiationZone( ply, tr, ang, source_size, source_intensity, zone_size );
	
	return true;

end

function TOOL.BuildCPanel( CPanel )
	
	CPanel:AddControl( "Header", { Text = "#Tool_radiation_name", Description = "#Tool_radiation_desc" } );
	
	CPanel:AddControl( "Slider", { Label = "Source Size",
	Type	= "Float",
	Min		= 1,
	Max		= 1024,
	Command = "radiation_source_size" } );
	
	CPanel:AddControl( "Slider", { Label = "Source Intensity (Roentgen/second)",
	Type	= "Float",
	Min		= 1,
	Max		= 1024,
	Command = "radiation_source_intensity" } );
	
	CPanel:AddControl( "Slider", { Label = "Zone Size",
	Type	= "Float",
	Min		= 1,
	Max		= 1024,
	Command = "radiation_zone_size" } );
	
end