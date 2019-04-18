include('shared.lua')

function ENT:Initialize()

	local Pos = self:GetPos()
	timer.Create("effedfs" .. self:EntIndex(), 0.01, 0, function()
		if not IsValid(self) then timer.Stop("effedfs" .. self:EntIndex()) return end
		
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetAttachment(1)
	
	end)
end


function ENT:Draw()
if CLIENT then
	local Pos = self:GetPos()
	if self.Owner:GetActiveWeapon().pap == true then
		render.SetMaterial(Material("particle/particle_glow_04"))
		render.DrawSprite(self:GetPos(), 30, 30, Color(255, 63, 0))
		render.SetMaterial(Material("particle/particle_glow_04"))
		render.DrawSprite(self:GetPos(), 20, 20, Color(255, 127, 108))
		render.SetMaterial(Material("particle/particle_glow_04"))
		render.DrawSprite(self:GetPos(), 10, 10, Color(255, 255, 255))
	else
		render.SetMaterial(Material("particle/particle_glow_04"))
		render.DrawSprite(self:GetPos(), 30, 30, Color(0, 255, 63))
		render.SetMaterial(Material("particle/particle_glow_04"))
		render.DrawSprite(self:GetPos(), 20, 20, Color(127, 255, 108))
		render.SetMaterial(Material("particle/particle_glow_04"))
		render.DrawSprite(self:GetPos(), 10, 10, Color(255, 255, 255))
	end
end
end
function ENT:Think()
	local Pos = self:GetPos()
end

function ENT:OnRemove()
end