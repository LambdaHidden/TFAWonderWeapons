AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
local CurTime = CurTime

local mr,mR=math.random,math.Rand
local snd,snd1,explo,hit1,hit2 = SWEP.snd,SWEP.snd1,SWEP.explo,SWEP.hit1,SWEP.hit2

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() or self.Overheated then
		return
	end
	if self:Clip1() == 1 then
		self.Overheated = true
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
	if o:GetAngles().pitch < 45 then
		o:SetVelocity(o:GetForward()*-30 )
	else
		o:SetVelocity(o:GetForward()*-70 )
	end
	o:SetAnimation(PLAYER_ATTACK1)
	
	local dmginfo = DamageInfo()
	dmginfo:SetDamage(1000)
	dmginfo:SetDamageType(DMG_PARALYZE)
	dmginfo:SetAttacker(o)
	dmginfo:SetInflictor(self)
	
	local dmginfo2 = DamageInfo()
	dmginfo2:SetDamage(5)
	dmginfo2:SetDamageType(DMG_PARALYZE)
	dmginfo2:SetAttacker(o)
	dmginfo2:SetInflictor(self)
	
	for k, v in pairs(ents.FindInCone(o:GetShootPos(), o:GetAimVector(), 100, 0.7)) do
		if v:IsNPC() then
			v:SetPlaybackRate(0.5)
			--v:SetVelocity(Vector(math.Clamp(v:GetVelocity().x - (v:GetVelocity().x*0.01), 0, 600), math.Clamp(v:GetVelocity().y - (v:GetVelocity().y*0.01), 0, 600)), math.Clamp(v:GetVelocity().z - v:GetVelocity().z*0.01, 0, 600))
			--v:SetVelocity(v:GetVelocity()*0.99)
			
			v:TakeDamageInfo(dmginfo2)
		end
		if v.Type == "nextbot" then
			v.loco:SetDesiredSpeed( math.Clamp(v.loco:GetVelocity():Length()-5, 0, 600))
			if v.loco:GetVelocity() == Vector(0,0,0) then
				v:TakeDamageInfo(dmginfo)
			end
		end
		if v:IsPlayer() and v != o then
			if !v:OnGround() then
				v:SetVelocity(o:GetAimVector()*70)
			end
		end
	end
	self:TakePrimaryAmmo(1)
	
	local rec = self.Primary.Recoil
	o:ViewPunch(Angle( mR(-rec, rec), mR(-rec, rec), 0))
	ParticleEffect("jet_muzzle",o:GetShootPos() + o:GetForward() * 60 + o:GetUp() * -10 + o:GetRight() * 10,o:GetAngles(),o)
end
