function GM:ResetDrugFX()
	
	self.DrugType = nil;
	self.DrugStart = nil;
	
	if( self.DrugAmbience ) then
		
		self.DrugAmbience:Stop();
		
	end
	
	self.DrugAmbience = nil;
	
end