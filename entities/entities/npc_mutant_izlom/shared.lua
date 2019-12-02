ENT.Base = "base_ai"
ENT.Type = "ai"

ENT.PrintName = "Izlom"
ENT.Author = ""
ENT.Contact = ""
ENT.Information		= ""
ENT.Category		= "S.T.A.L.K.E.R RP"

ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.AutomaticFrameAdvance = true


/*---------------------------------------------------------
Name: PhysicsCollide
Desc: Called when physics collides. The table contains
data on the collision
//-------------------------------------------------------*/
function ENT:PhysicsCollide( data, physobj )
end
 
 
/*---------------------------------------------------------
Name: PhysicsUpdate
Desc: Called to update the physics .. or something.
//-------------------------------------------------------*/
function ENT:PhysicsUpdate( physobj )
end
  
/*---------------------------------------------------------
Name: SetAutomaticFrameAdvance
Desc: If you're not using animation you should turn this
off - it will save lots of bandwidth.
//-------------------------------------------------------*/
function ENT:SetAutomaticFrameAdvance( bUsingAnim )

self.AutomaticFrameAdvance = bUsingAnim

end 