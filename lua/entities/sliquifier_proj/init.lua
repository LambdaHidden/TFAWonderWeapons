AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile()
include("shared.lua")

ENT.Packed = false

function ENT:Initialize()
	self:SetModel("models/dav0r/hoverball.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetNoDraw(true)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		phys:EnableDrag(false)
		phys:SetMass(1)
		phys:SetBuoyancyRatio(0)
		phys:Wake()
	end
	self.Exploded = false
	
	if self.Packed then
		ParticleEffectAttach("slipgun_blob_pap", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	else
		ParticleEffectAttach("slipgun_blob", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	end
	self.targetEnts = {}
end

function ENT:OnRemove()
	if self.sound then self.sound:Stop() end
	
end

function ENT:PhysicsCollide(data,phys)
	local ent = data.HitEntity
	if !ent:IsWorld() and self.Exploded then return end

	if ent != self.Owner then
		local dmginfo = DamageInfo()
		dmginfo:SetDamage(5500000)
		dmginfo:SetAttacker(self.Owner)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamageType(DMG_ACID)
		ent:TakeDamageInfo(dmginfo)
		
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_NONE)
		if (ent:IsPlayer() || ent:IsNPC() || ent.Type == "nextbot") then
			self:SetPos(ent:GetPos()+Vector(0,0,32))
			--self:SetParent(ent) --this bastard was responsible for a glitch.
			timer.Simple(0.1, function() 
				if IsValid(self) then
					self:FindNearestEntity(self:GetPos(), true)
				end
			end)
			timer.Simple(0.2, function() 
				if IsValid(self) then
					self:FindNearestEntity(self:GetPos(), true)
				end
			end)
			self:FindNearestEntity(self:GetPos(), true)
		
			local plate = ents.Create("sliquifier_slip")
			plate:SetPos(ent:GetPos() + Vector(0,0,8))
			plate:SetAngles(Angle(0,0,0))
			plate.Packed = self.Packed
			plate:Spawn()
			plate:Activate()
		end
	end
	
	self:StopParticles()
	if self.Packed then
		ParticleEffect( "slipgun_impact_pap", self:GetPos(), Angle(0,0,0) )
	else
		ParticleEffect( "slipgun_impact", self:GetPos(), Angle(0,0,0) )
	end
	
	self:EmitSound("weapons/slipgun/xplo"..math.random(1,2)..".wav")
	
	phys:SetVelocity(Vector(0,0,0))
	
	if !self.Exploded then
		if ent:IsWorld() then
			local ang = data.HitNormal:Angle()
			ang.p = math.abs( ang.p )
			ang.y = math.abs( ang.y )
			ang.r = math.abs( ang.r )
			if !(ang.p > 90 or ang.p < 60) then
				local plate = ents.Create("sliquifier_slip")
				plate:SetPos(self:GetPos())
				plate:SetAngles(data.HitNormal:Angle() + Angle(90,0,0))
				plate.Packed = self.Packed
				plate:Spawn()
				plate:Activate()
				self:Remove()
			end
		end
	end
	
	self.Exploded = true
end

function ENT:HasPrevTarg( ent )
 
    local entID = ent:GetCreationID()
   
    for _,targ in pairs(self.targetEnts) do
        if targ.id == entID then
            return true
        end
    end
   
    return false
   
end

function ENT:FindNearestEntity( pos, jump )
 
    local range = 128
    local foundEnt
 
    for _, ent in pairs( ents.FindInSphere(pos, range) ) do
		if ent:IsNPC() or ent.Type == "nextbot" then
			local distance = pos:DistToSqr( ent:GetPos() )
			-- can't target ents we already targeted
			if !self:HasPrevTarg( ent ) then
				if ( distance <= range*range and distance != 0 ) then
					range = distance
					foundEnt = ent
				end
			end
		end
    end
	
    if !jump then return foundEnt end
	
	if !IsValid(foundEnt) then SafeRemoveEntity(self) return end
	
	self:SetPos(foundEnt:GetPos()+Vector(0,0,32))
	if self.Packed then
		ParticleEffect( "slipgun_impact_pap", self:GetPos(), Angle(0,0,0) )
	else
		ParticleEffect( "slipgun_impact", self:GetPos(), Angle(0,0,0) )
	end
	
	table.insert(self.targetEnts,{ent=foundEnt,id=foundEnt:GetCreationID()})
	
	local dmginfo = DamageInfo()
	dmginfo:SetDamage(5500000)
	dmginfo:SetAttacker(self.Owner)
	dmginfo:SetInflictor(self)
	dmginfo:SetDamageType(DMG_ACID)
	foundEnt:TakeDamageInfo(dmginfo)
	
	local plate = ents.Create("sliquifier_slip")
	plate:SetPos(foundEnt:GetPos() + Vector(0,0,8))
	plate:SetAngles(Angle(0,0,0))
	plate.Packed = self.Packed
	plate:Spawn()
	plate:Activate()
	
	timer.Simple(0.5, function() 
		if IsValid(self) then
			self:FindNearestEntity(self:GetPos(), true)
		end
	end)
   
end

function ENT:StartTouch( ent )
	if ent:IsValid() and ent != self.Owner then
		local dmginfo = DamageInfo()
		dmginfo:SetDamage(5500000)
		dmginfo:SetAttacker(self.Owner)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamageType(DMG_ACID)
		ent:TakeDamageInfo(dmginfo)
		
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_NONE)
		if (ent:IsPlayer() || ent:IsNPC() || ent.Type == "nextbot") then
			self:SetPos(ent:GetPos()+Vector(0,0,32))
			--self:SetParent(ent) --this bastard was responsible for a glitch.
			timer.Simple(0.1, function() 
				if IsValid(self) then
					self:FindNearestEntity(self:GetPos(), true)
				end
			end)
			timer.Simple(0.2, function() 
				if IsValid(self) then
					self:FindNearestEntity(self:GetPos(), true)
				end
			end)
			self:FindNearestEntity(self:GetPos(), true)
		
			local plate = ents.Create("sliquifier_slip")
			plate:SetPos(ent:GetPos() + Vector(0,0,8))
			plate:SetAngles(Angle(0,0,0))
			plate.Packed = self.Packed
			plate:Spawn()
			plate:Activate()
		end
	end
	
	self:StopParticles()
	if self.Packed then
		ParticleEffect( "slipgun_impact_pap", self:GetPos(), Angle(0,0,0) )
	else
		ParticleEffect( "slipgun_impact", self:GetPos(), Angle(0,0,0) )
	end
end