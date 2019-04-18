if (SERVER) then AddCSLuaFile("shared.lua")end
----------------------------------------------
ENT.Base     	= "base_nextbot"
ENT.Spawnable	= false
ENT.HasWindup = true
--ENT.WindupSND = "weapons/humangun/fx_timer.mp3"
--ENT.Winduptime = 0
ENT.Hasscream = true
ENT.NextScream = 0
ENT.OurHealth = 40;

if CLIENT then language.Add("nextbot_vrill_human","Citizen")end

function ENT:Initialize()
	self.Entity:SetCollisionBounds(Vector(-4,-4,0), Vector(4,4,64))
	self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
	self:SetHealth(40)
	self:SetModel("models/ciaguy/cia_guy.mdl")
	if self.SetTargetPriority then
		self:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
	end
	if SERVER then 
		self.loco:SetStepHeight(35)
		self.loco:SetAcceleration(900)
		self.loco:SetDeceleration(900)
		self:SetSolidMask(MASK_NPCSOLID_BRUSHONLY)
		self.Anim = false
	end 
	if self.HasWindup then
		
			if IsValid(self) then
				self.timerSound = CreateSound(self, "weapons/humangun/fx_timer.wav")
	            self.timerSound:Play()
			end 
		end
		
end
function ENT:Think()
	if IsValid(self) then
		if SERVER then
			self:Scream()
			if self:WaterLevel() >= 2 then
				self:TakeDamage(self:Health() + 1)
			end
		end
	end
end
local math_random = math.random
local function getrandmin(rad,maxrad)
	rad = math_random(rad,maxrad)
	return math_random(0,1) == 1 and -rad or rad
end
local function getrand(minrad,maxrad)
	return Vector(getrandmin(minrad,maxrad),getrandmin(minrad,maxrad),0)
end
function ENT:MoveFunction(rad,maxrad,opt)
	local pos = self:GetPos() + getrand(rad,maxrad)
	while !util.IsInWorld(pos) do
		pos = self:GetPos() + getrand(rad,maxrad)
	end
	self:MoveToPos(pos,opt)
end
function ENT:OnKilled(ent,dmginfo)
	if CLIENT then return end
	for k,v in pairs(ents.FindInSphere(self:GetPos(),512)) do
		local c = v:GetClass()
		if string.find(c,"nbnz") then
			v:SetEnemy(nil)
		elseif string.find(c,"nz_zombie") then
			v:SetTarget(nil)
		end
	end
	ParticleEffect("tank_gore",self:GetPos(),Angle(0,0,0))
	self:EmitSound("weapons/humangun/fx_explode"..math.random(1,2)..".mp3",511,100)
	self:Remove()
	self.timerSound:Stop()
    self.screamSound:Stop()
end


function ENT:RunBehaviour()
	while (true) do
		ParticleEffectAttach("vrill_human_aura",PATTACH_ABSORIGIN_FOLLOW,self,0)
		self:PlaySequenceAndWait("react")
		self.loco:SetDesiredSpeed(120)
		self:StartActivity(ACT_RUN_PROTECTED)
		self:MoveFunction(100,200)
		self:StartActivity(ACT_RUN)
		--self:EmitSound("weapons/humangun/fx_timer.mp3")
		self:MoveFunction(1000,1500,{maxage=5.27})
		--ParticleEffect("ubersniper_victim_redmist",self:GetPos(),Angle(0,0,0),nil)
		--ParticleEffect("tank_gore",self:GetPos(),Angle(0,0,0))
		--self:EmitSound("weapons/humangun/fx_explode"..math.random(1,2)..".mp3",511,100)
		for k,v in pairs(ents.FindInSphere(self:GetPos(),300)) do
			if v:IsPlayer() then continue end
			v:TakeDamage(200,self.Owner,self)
		end
		SafeRemoveEntity(self)
	end 
end



function ENT:Scream()
	if CurTime() < self.NextScream then return end
		if self.Scream then
		if self.Hasscream then
			if IsValid(self) then
				self.screamSound = CreateSound(self, "weapons/humangun/fx_scream"..math.random(1,6)..".mp3")
	            self.screamSound:Play()
			end 
		end 
		end
	for k,v in pairs(ents.FindInSphere(self:GetPos(),512)) do
		local c = v:GetClass()
		if (string.find(c,"nbnz")) then
			if (string.find(c,"paris_cosmonaut") or string.find(c,"thief")) then continue end
			v:SetEnemy(self)
		elseif string.find(c,"nz_zombie") then
			v:SetTarget(self)
		end
	end
	self.NextScream = CurTime() + math.random(3,5)
end
