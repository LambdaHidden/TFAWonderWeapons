AddCSLuaFile()
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

sound.Add( {
	name = "wg_explode",
	volume = 1.0,
	level = 100,
	pitch = {100, 100},
	sound = "weapons/zapwavegun/microwave_flux_r.wav"
} )

ENT.CollideSND = "wg_explode"
ENT.Damage = 335
ENT.MoveSpeed = 3500
function ENT:Initialize()
	self:SetModel( "models/dav0r/hoverball.mdl" )
	self:SetNoDraw(true)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:DrawShadow(false)
	self:SetCollisionGroup( COLLISION_GROUP_PROJECTILE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetSolidFlags(FSOLID_NOT_STANDABLE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	if CLIENT then return end
	self:SetTrigger(true)
	local eff = ents.Create("info_particle_system")
	eff:SetKeyValue("effect_name", self.TrailPCF)
	eff:SetKeyValue("start_active", "1")
	eff:SetPos(self:GetPos())
	eff:SetParent(self)
	eff:Spawn()
	eff:Activate()
	self.Effect = eff
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass( 1 )
		phys:EnableGravity( false )
		phys:EnableDrag( false )
		phys:SetBuoyancyRatio( 0 )
		phys:Wake()
		phys:ApplyForceCenter(self:GetForward()*3500)
	else
		self:Remove()
	end
	self.LifeTime = CurTime() + math.Rand(3,4)
end
if SERVER then
	function ENT:OnCollide(ent,hitpos)
		if self.DoRemove then return end
		if self.Owner == ent then return end
		if (ent:GetClass() == "worldspawn") then
			self.DoRemove = true
			self.Effect:SetParent(NULL)
			SafeRemoveEntityDelayed(self.Effect,1)
			self.Effect:Fire("Stop")
			self:PhysicsDestroy()
			SafeRemoveEntityDelayed(self,0)
		end
		local own = self.Owner
		
		--self.Trail:SetParent(self.Effect)
		self:NextThink(CurTime())
		
		for k, v in pairs(ents.FindInSphere(hitpos, 256)) do
		if scripted_ents.GetType( v:GetClass() ) == "nextbot" then
			if v != self.Owner and IsValid(v) then
				if v:GetNWBool("IsInflating") ~= true and v:GetNWBool("IsInflating") ~= false then v:SetNWBool("IsInflating",false) end
				if !v:GetNWBool("IsInflating") then
					v:SetNWBool("IsInflating",true)
					v:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
					--v:StopMoving()
					v.loco:SetDesiredSpeed(0)
					if string.find(v:GetClass(), "nz_zombie") then
						v:SetBlockAttack(true)
					end
					v:StartActivity( ACT_IDLE )
					timer.Simple(1,function() if IsValid(v) then v:EmitSound( "weapons/zapwavegun/microwave_cooking.wav" ) end end)
					--v:SetSequence(ACT_VICTORY_DANCE)
					timer.Simple(3,function()
						--v:SetSchedule(SCHED_ALERT_STAND)
						if IsValid(v) then
							local d = DamageInfo()
							d:SetDamage( v:Health() )
							d:SetAttacker( own )
							d:SetDamageForce( Vector(math.random(-20,20),math.random(-20,20),128) )
							d:SetDamageType( DMG_ENERGYBEAM )
							v:TakeDamageInfo( d )
						end
					end)
					-- if v:LookupBone("ValveBiped.Bip01_Head1") ~= nil then
						-- v:ManipulateBoneScale(v:LookupBone("ValveBiped.Bip01_Head1"),Vector(3.5,3.5,3.5))
					-- end
					v:SetNWBool("IsInflating",true)
				end
			end
		elseif v:IsNPC() then
		if v != self.Owner and IsValid(v) then
			if (SERVER and string.find(v:GetClass(),"helicopter")) then
				v:Fire("selfdestruct")
			elseif not string.find(v:GetClass(),"helicopter") then
				local own = self.Owner
				if v:GetNWBool("IsInflating") ~= true and v:GetNWBool("IsInflating") ~= false then v:SetNWBool("IsInflating",false) end
				if !v:GetNWBool("IsInflating") then
					v:SetNWBool("IsInflating",true)
					v:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
					--v:StopMoving()
					v:SetSchedule(SCHED_NPC_FREEZE)
					timer.Simple(1,function() if IsValid(v) then v:EmitSound( "weapons/zapwavegun/microwave_cooking.wav" ) end end)
					--v:SetSequence(ACT_VICTORY_DANCE)
					timer.Simple(3,function()
						v:SetSchedule(SCHED_ALERT_STAND)
						if IsValid(v) then
							local d = DamageInfo()
							d:SetDamage( v:Health() )
							d:SetAttacker( own )
							d:SetDamageForce( Vector(math.random(-20,20),math.random(-20,20),128) )
							d:SetDamageType( DMG_ENERGYBEAM )
							v:TakeDamageInfo( d )
						end
					end)
					-- if v:LookupBone("ValveBiped.Bip01_Head1") ~= nil then
						-- v:ManipulateBoneScale(v:LookupBone("ValveBiped.Bip01_Head1"),Vector(3.5,3.5,3.5))
					-- end
					v:SetNWBool("IsInflating",true)
				end
			end
			end
			elseif v:GetClass() == ("func_button") then
				local own = self.Owner
				local d = DamageInfo()
				d:SetDamage( v:Health() )
				d:SetAttacker( own )
				d:SetDamageType( DMG_ENERGYBEAM )
				v:TakeDamageInfo( d )
			end
		end
		--debugoverlay.Sphere(hitpos,5,1)
		ParticleEffect( self.CollidePCF, hitpos, self:GetAngles() )
		self:EmitSound(self.CollideSND)
		return true
	end
	function ENT:StartTouch(ent)
		if self.Owner == ent then return end
		self:OnCollide(ent,self:GetPos())
	end
	function ENT:Think(engine)
		local ct = CurTime()
		if self.DoRemove then
			self:SetMoveType(MOVETYPE_NONE)
			self:NextThink(ct+1)
			return true
		end
		if self.LifeTime < ct then
			self:OnCollide(self,self:GetPos())
		end
		self:NextThink(ct+0.1)
		return true
	end
	function ENT:PhysicsCollide(data)
		self:OnCollide(data.HitEntity,data.HitPos)
	end
end