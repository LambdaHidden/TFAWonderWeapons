AddCSLuaFile()
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

function ENT:Initialize()
	self:SetModel( "models/roller.mdl" )
	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:PhysicsDestroy()
	SafeRemoveEntityDelayed(self,0)
	--self:Remove()
end

