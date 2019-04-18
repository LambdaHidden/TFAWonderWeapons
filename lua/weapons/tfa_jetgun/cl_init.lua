include("shared.lua")
SWEP.Slot             = 1
SWEP.SlotPos          = 1
language.Add( "rotor_ammo", "Rotor coolant" )
killicon.Add( "weapon_jetgun", "killicon/weapon_jetgun", color_white )
local oldang,snd = 0,SWEP.snd
local angle_origin = Angle(0,0,0)
local mr,mR,IsValid=math.random,math.Rand,IsValid
local snd1=SWEP.snd1

function SWEP:Deploy()
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.6)
	self:SetRPM(0)
	if IsValid(self.Owner) then
		self:SyncMeter(self.Owner,true)
	end
	self:SetAnimFix(true)
end

function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = self.DrawAmmo
	self.AmmoDisplay.PrimaryClip = self:Clip1()
	return self.AmmoDisplay
end
function SWEP:SyncMeter(o,first)
local o = self.Owner
	local vm,clip,rpm,fix,fix1 = o:GetViewModel(),self:Clip1(),self:GetRPM(),0,0
	if first then
		fix,fix1 = 20,30
	end
	if clip == -1 then
		vm:ManipulateBoneAngles(84,Angle(0,0,150+fix))
	else
		vm:ManipulateBoneAngles(84,Angle(0,0,-180-180*clip/self.Primary.ClipSize+fix))
	end
	vm:ManipulateBoneAngles(85,Angle(0,0,4+253*rpm/10+fix1))
end

if game.SinglePlayer() then
	local nextthink = 0
	function SWEP:Think2()
		local ss,tme = self.ShutdownSound,CurTime()
		if ss then
			if ss <= tme then
				self.ShutdownSound = nil
				--self:EmitSound(snd1)
			end
		else
			if nextthink < tme then
				nextthink = tme + 0.1
				if IsValid(self.Owner) then
					self:SyncMeter(self.Owner)
				end
			end
		end
	end
end


function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.6)
		return false
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
	o:SetVelocity(o:GetForward()*-30 )
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
			end
			local trace = {}
			trace.filter = o
			trace.start = sp
			trace.endpos = trace.start + o:GetForward() * 100
			local tr = util.TraceLine(trace)
			local ent = tr.Entity
			if IsValid() and (ent:IsPlayer() and hook.Run("PlayerShouldTakeDamage",v,o)) or ent:IsNPC() or ent.Type == "nextbot" then
			local pos = self.Owner:GetShootPos() 
	        local ppos = pos + (self.Owner:GetForward() * 0)		
			ParticleEffect("bloodburst",o:GetShootPos() + o:GetForward() * 60 + o:GetUp() * -25 + o:GetRight() * 10,o:GetAngles(),o)
			ParticleEffect("bloodburst",o:GetShootPos() + o:GetForward() * 10 + o:GetUp() * -25 + o:GetRight() * 10,o:GetAngles(),o)	
			elseif gamemode.Get("sandbox") and ent:IsPlayer() then
			local pos = self.Owner:GetShootPos() 
	        local ppos = pos + (self.Owner:GetForward() * 0)		
			ParticleEffect("bloodburst",o:GetShootPos() + o:GetForward() * 60 + o:GetUp() * -25 + o:GetRight() * 10,o:GetAngles(),o)
			ParticleEffect("bloodburst",o:GetShootPos() + o:GetForward() * 10 + o:GetUp() * -25 + o:GetRight() * 10,o:GetAngles(),o)		
	end
end
	self:TakePrimaryAmmo(1)
	local rpm = self:GetRPM()
	if rpm < 10 then
		self:SetRPM(rpm+1)
	end
	self:SyncMeter(o)
	local rec = self.Primary.Recoil
	o:ViewPunch(Angle( mR(-rec, rec), mR(-rec, rec), 0))
	ParticleEffect("jet_muzzle",o:GetShootPos() + o:GetForward() * 60 + o:GetUp() * -10 + o:GetRight() * 10,o:GetAngles(),o)
end

