AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile()
include("shared.lua")

ENT.Packed = false
ENT.LifeTime = CurTime() + 20
function ENT:Initialize()
	self:SetModel("models/hunter/plates/plate2x2.mdl")
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	--self:EnableCustomCollisions(true)
	self:SetTrigger(true)
	local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
		phys:SetMass(1)
        phys:EnableDrag(false)
        phys:EnableGravity(false)
        phys:SetBuoyancyRatio(0)
    end
	self:SetNoDraw(true)
	if self.Packed then
		ParticleEffect( "slipgun_floorgoo_pap", self:GetPos(), self:GetAngles() )
	else
		ParticleEffect( "slipgun_floorgoo", self:GetPos(), self:GetAngles() )
	end
	self.LifeTime = CurTime() + 20
end

function ENT:OnRemove()
	if self.sound then self.sound:Stop() end
	
end

function ENT:Think()
	if IsValid(self) and self.LifeTime < CurTime() then
		self:StopParticles()
		SafeRemoveEntity(self)
	end
end

function ENT:StartTouch( ent )
	if IsValid(ent) then
		if (ent:IsNPC() || ent.Type == "nextbot" ) then
			if !ent.OnSliquifierGoo then
				ent.OnSliquifierGoo = true
				ent:SetFriction(0.1)
			end
		elseif ent:IsPlayer() then
			if !ent.OnSliquifierGoo then
				ent.OnSliquifierGoo = true
				ent.RestoreWalkSpeed = ent:GetWalkSpeed()
				ent.RestoreRunSpeed = ent:GetRunSpeed()
				ent:SetWalkSpeed(ent.RestoreWalkSpeed*2)
				ent:SetRunSpeed(ent.RestoreRunSpeed*2)
			end
		end
	end
end
	
function ENT:EndTouch( ent )
	if IsValid(ent) then
		if (ent:IsNPC() || ent.Type == "nextbot" ) then
			ent:SetFriction(1)
			ent.OnSliquifierGoo = false
		elseif ent:IsPlayer() then
			if ent.RestoreWalkSpeed != nil then
				ent:SetWalkSpeed(ent.RestoreWalkSpeed)
				ent:SetRunSpeed(ent.RestoreRunSpeed)
				ent.OnSliquifierGoo = false
			end
		end
	end
end