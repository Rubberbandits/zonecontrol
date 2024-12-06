netstream.Hook( "nPDANameTaken", function()

	LocalPlayer():Notify(nil, COLOR_ERROR, "This PDA name is taken.")

end );