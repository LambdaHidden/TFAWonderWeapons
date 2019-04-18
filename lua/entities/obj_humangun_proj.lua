AddCSLuaFile()
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

ENT.TimeoutPeriod = 3
ENT.TrailPCF = "electric_arc_base"
ENT.CollidePCF = "vr11_impact_base"
--ENT.CollideSND = "weapons/raygun/proj_hit.mp3"
--ENT.Damage = 0
--ENT.MoveSpeed = 3500
function ENT:Initialize()
	self:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )
	self.Mins = self:OBBMins()
	self.Maxs = self:OBBMaxs()
	self:SetNoDraw(true)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetCollisionBounds( self:GetModelBounds())
	self:DrawShadow(false)
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
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
		phys:Wake()
		phys:ApplyForceCenter(self:GetForward()*3500)
	else
		self:Remove()
	end
	self.LifeTime = CurTime() + math.Rand(3,4)
end

	function ENT:OnCollide(ent,hitpos)
		if self.DoRemove then return end
		if self.Owner == ent then
			return true
		end
    SafeRemoveEntity(self)
	self.DoRemove = true
	self:PhysicsDestroy()
	SafeRemoveEntityDelayed(self,0)
	self:NextThink(CurTime())
	    local o = self.Owner
		local c = ent:GetClass()
        if c == "nz_zombie_boss_panzer" then
		        ent:TakeDamage(143,self.Owner,self.Weapon)
		elseif c == "nextbot_vrill_human" then
		SafeRemoveEntity(ent)
		util.BlastDamage(self.Owner,self.Owner,ent:GetPos(),150,200)
		--ParticleEffect("tank_gore",ent:GetPos(),Angle(0,0,0))
		self:StopSound("weapons/humangun/fx_timer.mp3")
		else
		if ent.Type == "nextbot" or ent:IsNPC() or (ent:IsPlayer() and hook.Run("PlayerShouldTakeDamage",o,ent)) then
		if ent == self.Owner then return end
	      if c == "nextbot_vrill_human" then return end
					local nb = ents.Create("nextbot_vrill_human")
					nb:SetPos(ent:GetPos())
					nb:SetAngles(ent:GetAngles())
					nb:Spawn()
					nb.Owner = o
				SafeRemoveEntity(ent)				
				BroadcastLua("AddVRAura("..ent:EntIndex()..")")
				timer.Simple(5.27,function()
					if !IsValid(v) then return end
					v:EmitSound("weapons/humangun/fx_explode"..math.random(1,2)..".mp3",511,100)
					if IsValid(self) then
						util.BlastDamage(self.Weapon,self.Owner,ent:GetPos(),300,200)
					end
					ent:TakeDamage(ent:Health(), o, self.Weapon)
					SafeRemoveEntity(ent)
				end)
			end
		ParticleEffect( self.CollidePCF, hitpos, self:GetAngles() )
		--self:EmitSound(self.CollideSND)
		
				return
			end
		return true
	end
	function ENT:StartTouch(ent)
		if (ent:GetClass() == "prop_dynamic") or (ent:GetClass() == "nz_spawn_zombie_normal") or (ent:GetClass() == "nz_spawn_zombie_special") or (ent:GetClass() == "nz_spawn_player") then return end
		self:OnCollide(ent,self:GetPos())
	end
	function ENT:Touch(ent)
	if (ent:GetClass() == "prop_dynamic") or (ent:GetClass() == "nz_spawn_zombie_normal") or (ent:GetClass() == "nz_spawn_zombie_special") or (ent:GetClass() == "nz_spawn_player") then return end
		self:OnCollide(ent,self:GetPos())
	end
	function ENT:Think(engine)
	local ct = CurTime()
	if CLIENT then
		local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.pos = self:GetPos()
		dlight.dir = self:GetPos()
		dlight.r = 227
		dlight.g = 233
		dlight.b = 54
		dlight.brightness = 3
		dlight.Decay = 1000
		dlight.Size = 150
		dlight.DieTime = ct + 1
	end
	end	
		if self.DoRemove then
			self:SetMoveType(MOVETYPE_NONE)
			self:NextThink(ct+1)
			return true
		end
		local ct = CurTime()
		
		self:NextThink(ct+0.1)
		return true
	end
	

	function ENT:PhysicsCollide(data)
		self:OnCollide(data.HitEntity,data.HitPos)
	end

if CLIENT then
	function AddVRAura(ind)
		local ent = Entity(ind)
		if IsValid(v) then
			ParticleEffectAttach("vrill_human_aura",PATTACH_ABSORIGIN_FOLLOW,v,0)
		end
	end
end


