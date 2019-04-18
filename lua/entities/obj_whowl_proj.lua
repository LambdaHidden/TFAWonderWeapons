
/*-------------------------------------------------*\
|  Copyright © 2017 by Roach, All rights reserved.  |
\*-------------------------------------------------*/
AddCSLuaFile()
ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.Author			= "Roach"
ENT.Spawnable			= false

ENT.TrailPCF = "freeze_geo_trail"
ENT.TrailSND = "ambient/wind/wind_hit1.wav"
ENT.CollideSND = {"weapons/freeze_impact.wav"}
ENT.Damage = 0
ENT.HasTimeout = true
ENT.TimeoutPeriod = 0.5
ENT.MoveSpeed = 1000


function ENT:DealCollideEffects(v,att,inf) -- DealCollideEffects(entity victim, entity attacker, entity inflictor)
	return
end
function ENT:CustomInit()end

function ENT:OnCollide(data,physobj,NoData) -- OnCollide(CollisionData data, Physics Object physobj, Boolean NoData)
	NoData = NoData or false

	if #self.CollideSND < 2 then
		self:EmitSound(self.CollideSND[1], 75, 100)
	else
		self:EmitSound(self.CollideSND[math.random(1,#self.CollideSND)], 75, 100)
	end
	--if IsValid(effect) then effect:Remove() end
    SafeRemoveEntity(self)
	self.DoRemove = true
	self:PhysicsDestroy()
	SafeRemoveEntityDelayed(self,0)
end

if CLIENT then
	function ENT:Draw()
	end
end

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01_chunk02c.mdl")
	if SERVER then self:SetMoveCollide(3)end
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetHealth(1)
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:SetMass(1)
		phys:EnableGravity(false)
		phys:EnableDrag(false)
	end
	
	self.cspSound = CreateSound(self, self.TrailSND)
	self.cspSound:Play()
	
	if SERVER then
		effect = ents.Create("info_particle_system")
		effect:SetKeyValue("effect_name", self.TrailPCF)
		effect:SetKeyValue("start_active", "1")
		effect:SetPos(self:GetPos())
		effect:SetAngles(self:GetAngles())
		effect:SetParent(self)
		effect:Spawn()
		effect:Activate()
	end
	self.OWNER = self.Own
	if SERVER then
	if self.HasTimeout then
		timer.Simple(self.TimeoutPeriod,function()
			if IsValid(self) then
				self:OnCollide(nil,nil,true)
			end 
		end)
	end
	self:CustomInit()
end
end
function ENT:OnRemove()
	if SERVER then self.cspSound:Stop()end
end

function ENT:Think()
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then	
		if self:GetVelocity() == Vector(0,0,0) then
			if SERVER then phys:ApplyForceCenter(self:GetForward()*self.MoveSpeed)end
		end
	end
	if CLIENT then
		local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.pos = self:GetPos()
		dlight.dir = self:GetPos()
		dlight.r = 255
		dlight.g = 255
		dlight.b = 255
		dlight.brightness = 4
		dlight.Decay = 1000
		dlight.Size = 150
		dlight.DieTime = CurTime() + 1
	end
end
end

function ENT:PhysicsCollide(data, physobj)
	if IsValid(data.HitEntity) then
		if string.find(data.HitEntity:GetClass(), "obj_") or string.find(data.HitEntity:GetClass(), "r_base") then return false end
	end
	self:OnCollide(data,physobj)
	return true
end

function CreateBeamParticle(pcf,pos1,pos2,ang1,ang2,parent,candie,dietime)
	if SERVER then
		local P_End = ents.Create("info_particle_system") 
		P_End:SetKeyValue("effect_name",pcf)
		P_End:SetName("info_particle_system_MajikPoint_"..pcf)
		P_End:SetPos(pos2) 
		P_End:SetAngles((ang2 or Angle(0,0,0))) 
		P_End:Spawn()
		P_End:Activate()
		P_End:SetParent(parent or nil)
		
		local P_Start = ents.Create("info_particle_system")
		P_Start:SetKeyValue("effect_name",pcf)
		P_Start:SetKeyValue("cpoint1",P_End:GetName())
		P_Start:SetKeyValue("start_active",tostring(1))
		P_Start:SetPos(pos1)
		P_Start:SetAngles((ang1 or Angle(0,0,0)))
		P_Start:Spawn()
		P_Start:Activate() 
		P_Start:SetParent(parent or nil)
		
		if candie then P_End:Fire("Kill",nil,dietime)P_Start:Fire("Kill",nil,dietime) end
	end
end 
