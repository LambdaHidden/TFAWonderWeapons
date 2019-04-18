AddCSLuaFile()
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false
ENT.OurHealth = 25; -- Amount of damage that the entity can handle - set to 0 to make it indestructible
ENT.TrailSND = "weapons/projectile_whoosh.wav"
ENT.HasTimeout = true
ENT.HasWindup = true
ENT.WindupSND = "weapons/proj_windup.wav"
ENT.Winduptime = 0.5
ENT.TimeoutPeriod = 3
ENT.CollideSND = {"weapons/projectile_impact.wav",}

function ENT:Initialize()
    --self:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )
	self:SetNoDraw(false)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:DrawShadow(false)
	self:SetCollisionGroup( COLLISION_GROUP_PROJECTILE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetSolidFlags(FSOLID_NOT_STANDABLE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self.cspSound = CreateSound(self, self.TrailSND)
	self.cspSound:Play()
	if CLIENT then return end
	self:SetTrigger(true)
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
	    phys:SetVelocity(self.Owner:GetForward() * 500)
		phys:SetMass( 1 )
		phys:EnableGravity( false )
		phys:EnableDrag( false )
		phys:Wake()
		--phys:ApplyForceCenter(self:GetForward()*3500)
end
	if self.HasTimeout then
		timer.Simple(self.TimeoutPeriod,function()
			if IsValid(self) then
				self:Explosion()
			end 
		end)
		end 
		if self.HasWindup then
		timer.Simple(self.Winduptime,function()
			if IsValid(self) then
				self.cspSound = CreateSound(self, self.WindupSND)
	            self.cspSound:Play()
			end 
		end)
		end 
	end



if SERVER then
	function ENT:Think()
	end
    function ENT:PhysicsCollide(data,phys)	
		if self:IsValid() && !self.Hit then
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		self.Hit = true
		end	
		if data.HitEntity:IsWorld() == false and data.HitEntity:GetClass() ~= "obj_scavenger_proj" and data.HitEntity:IsNPC() == false and data.HitEntity:IsPlayer() == false and  data.HitEntity:IsValid() then
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetParent(data.HitEntity)
		self.Stuck = true
		self.Hit = true
		end
		
		if data.HitEntity:IsWorld() then
		self:SetMoveType(MOVETYPE_NONE)
		end
		
		local angs = self:GetAngles()
		local ang = data.HitNormal:Angle()
        ang.p = ang.p + 0		
		self:SetPos(data.HitPos + ((data.HitNormal / 5) * -11))
		local pos = self.Owner:GetPos() - self:GetPos()
		local normalized = pos:Angle()
	
		timer.Simple(.001,function() 
		local get = self:GetPos()
		
		local getx = get.x
		local gety = get.y
		local getz = get.z
		
		local roundx = math.Round(get.x,-2)
		local roundy = math.Round(get.y)
		local roundz = math.Round(get.z)
				
		end)
		self:EmitSound(self.CollideSND[1], 75, 100)
	  	end
end

function ENT:Explosion()
			if CLIENT then return end			
			self:EmitSound("weapons/proj_explode.wav")
                    ParticleEffect("ubersniper_explosion_base",self:GetPos(),Angle(0,0,0),nil)
					util.ScreenShake(self.Entity:GetPos(), 1000, 255, 0.3, 500)
					self:Remove()
                        for k,v in pairs(ents.FindInSphere(self.Entity:GetPos(),250)) do
						
                            local ppos = v:GetPos()
							local dmginfo = DamageInfo()
                            if (v:IsPlayer() and hook.Run("PlayerShouldTakeDamage",v,self.Owner)) then
								dmginfo:SetDamage(25)
								dmginfo:SetDamageType( DMG_BLAST ) 
								dmginfo:SetInflictor(self.Entity)
								dmginfo:SetAttacker( self.Owner )
								v:TakeDamageInfo(dmginfo)
								if string.find(v:GetClass(),"romero") then
									v:TakeDamage(v.health/15,self.Owner,self.Weapon)-- It takes approx 15 scavenger shots to kill Romero in CotD.
								end
                            else
							if v:IsNPC() or v.Type == "nextbot" then
							   v:TakeDamage(11500,self.Owner,self.Entity)
							else
                               v:TakeDamage(11500,self.Owner,self.Entity)
							   
                            end
                        end
                    end            
                end         
function ENT:Touch(ent)
		if IsValid(ent) && !self.Stuck then
		if ent == self.Owner then return false end
			if ent:IsNPC() || (ent:IsPlayer() && ent != self:GetOwner()) || ent:IsVehicle() || ent.Type == "nextbot" then
				self:SetSolid(SOLID_NONE)
				self:SetMoveType(MOVETYPE_NONE)
				self:SetParent(ent)
				self.Stuck = true
				self.Hit = true
				end
		end
 end

 function ENT:OnTakeDamage(dmg)
	self:TakePhysicsDamage(dmg); -- React physically when getting shot/blown
 
	if(self.OurHealth <= 0) then return; end -- If the health-variable is already zero or below it - do nothing
 
	self.OurHealth = self.OurHealth - dmg:GetDamage(); -- Reduce the amount of damage took from our health-variable
 
	if(self.OurHealth <= 0) then -- If our health-variable is zero or below it
    self:Explosion()
	self.cspSound:Stop()
    end
end

 


