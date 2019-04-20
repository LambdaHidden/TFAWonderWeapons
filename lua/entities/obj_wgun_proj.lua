AddCSLuaFile()
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

sound.Add( {
	name = "wg_explode",
	volume = 1.0,
	level = 80,
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
	--eff:SetKeyValue("start_active", "1")
	eff:SetPos(self:GetPos())
	eff:SetParent(self)
	eff:Spawn()
	eff:Activate()
	timer.Create("effstart", 0.02, 1, function()
		if IsValid(eff) then
			eff:Fire("Start")
		end
	end)
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
function ENT:Draw()
	local Pos = self:GetPos()
	if SERVER then return end
	
	render.SetMaterial(Material("sprites/blueglow2"))
	render.DrawSprite(self:GetPos(), 50, 50, Color(255, 255, 255))
end
if SERVER then
	function ENT:OnCollide(ent,hitpos)
		if self.DoRemove then return end
		if self.Owner == ent then
			return true
		end
		self.DoRemove = true
		--self.Trail:SetParent(self.Effect)
		self.Effect:SetParent(NULL)
		SafeRemoveEntityDelayed(self.Effect,1)
		self.Effect:Fire("Stop")
		self:PhysicsDestroy()
		SafeRemoveEntityDelayed(self,0)
		self:NextThink(CurTime())
		timer.Destroy("effstart")
		local d = DamageInfo()
			d:SetDamage( ent:Health() )
			d:SetAttacker( self.Owner )
			d:SetDamageType( DMG_SHOCK )
			if ent != self.Owner then
				ent:TakeDamageInfo( d )
			end
		--debugoverlay.Sphere(hitpos,5,1)
		ParticleEffect( self.CollidePCF, hitpos, self:GetAngles() )
		--ParticleEffectAttach("zomb_elec",PATTACH_POINT_FOLLOW,ent,0)
		--ent:EmitSound("staff/lightning/victim_shocked.mp3")
		self:EmitSound(self.CollideSND)
		return true
	end
	function ENT:StartTouch(ent)
		if (ent:GetClass() == "prop_dynamic") or (ent:GetClass() == "nz_spawn_zombie_normal") or (ent:GetClass() == "nz_spawn_zombie_special") or (ent:GetClass() == "nz_spawn_player") then return end
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