-- this is mostly for identification purposes.
BASE.Vars = {
	Amount = 30,
}

function BASE:GetDesc()
	local amt = self:GetVar("Amount", 0)
	return Format(self.Desc, amt)
end