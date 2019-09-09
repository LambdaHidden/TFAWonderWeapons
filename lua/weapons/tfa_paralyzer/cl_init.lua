include("shared.lua")
SWEP.Slot             = 1
SWEP.SlotPos          = 1
language.Add( "rotor_ammo", "Rotor coolant" )
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
		fix,fix1 = 0,0
	end
	vm:ManipulateBoneAngles(68,Angle(-360-0.36*clip+fix, 0, 0))
	vm:ManipulateBoneAngles(69,Angle(-360-3.6*clip+fix, 0, 0))
	vm:ManipulateBoneAngles(70,Angle(-360-36*clip+fix, 0, 0))
	/*
	if clip == -1 then
		vm:ManipulateBoneAngles(84,Angle(0,0,150+fix))
	else
		vm:ManipulateBoneAngles(68,Angle(0,0,-180-180*clip/self.Primary.ClipSize+fix))
	end
	*/
	--vm:ManipulateBoneAngles(85,Angle(0,0,4+253*rpm/10+fix1))
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

/*
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
	
	--o:SetVelocity(o:GetForward()*-30 )
	
	o:SetAnimation(PLAYER_ATTACK1)
	
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
*/