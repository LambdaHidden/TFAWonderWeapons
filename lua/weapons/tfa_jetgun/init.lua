AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
local CurTime = CurTime

local mr,mR=math.random,math.Rand
local snd,snd1,explo,hit1,hit2 = SWEP.snd,SWEP.snd1,SWEP.explo,SWEP.hit1,SWEP.hit2

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.6)
		local o = self:GetOwner()
		if not IsValid(o) then
			self:Remove()
			return
		end
		local prop = ents.Create("prop_physics")
		prop:SetModel(self.WorldModel)
		prop:SetPos(o:GetShootPos())
		prop:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		prop:Spawn()
		prop:SetOwner(o)
		local timing = mR(1,3)
		prop:Ignite(timing)
		local phys = prop:GetPhysicsObject()
		if IsValid( phys ) then
			local velocity = o:GetForward()
			velocity = velocity * 6000
			velocity = velocity + ( VectorRand() * 10 )
			phys:ApplyForceCenter( velocity )
		end
		o:StripWeapon(self:GetClass())
		timer.Simple(timing,function()
			local explode = ents.Create( "env_explosion" )
			explode:SetPos( prop:GetPos() )
			explode:SetOwner( prop:GetOwner() )
			explode:AddFlags(64)
			explode:SetKeyValue( "iMagnitude", mr(60,140) )
			explode:Spawn()
			explode:Fire( "Explode", 0, 0 )
			explode:EmitSound(explo)
			prop:Remove()
		end)
		return
	elseif self.Owner:WaterLevel() > 2 then 
		self.Weapon:EmitSound(snd1)
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK_EMPTY)
		self:SetNextPrimaryFire(CurTime() + 1.5)
		return
	end
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	if not self.ShutdownSound then
		self:EmitSound(Sound(self.Primary.Sound))
	end
	local del = CurTime()
	self.ShutdownSound = del + self.Primary.Delay*1.5
	self:SetNextPrimaryFire(del + self.Primary.Delay)
	local o = self.Owner
	if o == nil or o == NULL then
		return
	end
	self:SetAnimFix(false)
	o:SetVelocity(o:GetForward()*30 )
	o:SetAnimation(PLAYER_ATTACK1)
	local tr,sp = o:GetEyeTrace(),o:GetShootPos()
	if tr then
		local ed,dist = EffectData(),tr.HitPos:Distance(sp)
		if dist < 150 then
			ed:SetOrigin(tr.HitPos-o:GetForward()*16)
			ed:SetMagnitude(dist/200)
		else
			local rr = mr(150,300)
			ed:SetOrigin(sp+o:GetForward()*rr)
			ed:SetMagnitude(rr/200)
		end
		local obj = o:LookupAttachment("anim_attachment_RH")
		if obj ~= 0 then
			local pos = o:GetAttachment(obj)
			ed:SetStart(pos.Pos)
			ed:SetEntity(o)
		else
			ed:SetStart(sp)
			ed:SetAttachment(1)
			ed:SetEntity(self.Weapon)
		end
	end
	self:TakePrimaryAmmo(1)
	local rpm = self:GetRPM()
	if rpm < 10 then
		self:SetRPM(rpm+1)
	end
	local filter = {o}
	for i = 0, 7 do
	local pos1 = self.Owner:GetShootPos() 
	local ppos1 = pos1 + (self.Owner:GetForward() * 0)
	for k,v in pairs(ents.FindInSphere(ppos1,10)) do
		local trace = {}
		trace.filter = filter
		trace.start = sp
		trace.mask = MASK_SHOT_HULL
		local ang = o:GetAimVector():Angle()
		ang:RotateAroundAxis(ang:Up(), math.random(-i*2,i*2))
		ang:RotateAroundAxis(ang:Right(), math.random(-i*0.5,i*0.5))
		local forw = ang:Forward()
		trace.endpos = trace.start + forw * math.random(400,500)
		local tr = util.TraceLine(trace)
		local ent = tr.Entity
		if IsValid(ent) then
			if ent:IsPlayer() then
				if !hook.Run("PlayerShouldTakeDamage",ent,o) then
					filter[#filter+1] = ent
					continue
				end
			elseif ent:IsNPC() or ent.Type == "nextbot" then
			else
				continue
			end
			local dist = sp:Distance(ent:GetPos())
			if dist>120 then
				if not ent.m_mass then
					if ent.Type == "nextbot" then
						ent.m_mass = 40
					else
						local ph = ent:GetPhysicsObject()
						if IsValid(ph) then
							ent.m_mass = ph:GetMass()
						else
							ent.m_mass = 0
						end
					end
				end
				if ent.m_mass ~= 0 then
					local vel = forw*-mr(10000,10000)*self:GetRPM()/(dist+100)
					if ent.Type == "nextbot" then
						ent.loco:SetVelocity(vel)
					else
						ent:SetVelocity(vel)
					end
				end
							else
			ent:EmitSound(mr(1,2)==1 and hit1 or hit2)
			filter[#filter+1] = ent
			ParticleEffect("bloodburst",o:GetShootPos() + o:GetForward() * 60 + o:GetUp() * -25 + o:GetRight() * 10,o:GetAngles(),o)
			ParticleEffect("bloodburst",o:GetShootPos() + o:GetForward() * 10 + o:GetUp() * -25 + o:GetRight() * 10,o:GetAngles(),o)	
			end
			local a = Vector( -500, 0, 0 )
			local pos = self.Owner:GetShootPos() 
	        local ppos = pos + (self.Owner:GetForward() * 0)
		for k,v in pairs(ents.FindInSphere(ppos,55)) do
		if v == self.Owner then continue end
		if gamemode.Get("nzombies") and v:IsPlayer() and hook.Run("PlayerShouldTakeDamage",v,self.Owner) then 
		   return 
		end	
	 local c = v:GetClass()
	 if c == "nz_zombie_boss_panzer" then
	  v:TakeDamage(175,self.Owner,self.Weapon)
	 end
	 for k,v in pairs(ents.FindInSphere(ppos,45)) do
	 if v:IsNPC() or v.Type == "nextbot" then
	 local dmginfo = DamageInfo()
	 dmginfo:SetDamage( 11500000 ) 
	 dmginfo:SetDamageType( DMG_BULLET ) 
	 dmginfo:SetAttacker( self.Owner ) 
	 dmginfo:SetDamageForce(a)
	 v:TakeDamageInfo( dmginfo )  
	 end
	 end
	 end
	 for k,v in pairs(ents.FindInSphere(ppos,65)) do
	 if gamemode.Get("sandbox") and v:IsPlayer() or v:IsNPC() or v.Type == "nextbot" then
	 if v == self.Owner then continue end	
	 local dmginfo2 = DamageInfo()
	 dmginfo2:SetDamage( v:Health() )
	 dmginfo2:SetDamageType( DMG_BULLET ) 
	 dmginfo2:SetAttacker( self.Owner ) 
	 dmginfo2:SetDamageForce(a)
	 v:TakeDamageInfo( dmginfo2 ) 
				 end
			 end
         end
	 end
end
	local rec = self.Primary.Recoil
	o:ViewPunch(Angle( mR(-rec, rec), mR(-rec, rec), 0))
	ParticleEffect("jet_muzzle",o:GetShootPos() + o:GetForward() * 60 + o:GetUp() * -10 + o:GetRight() * 10,o:GetAngles(),o)
end
