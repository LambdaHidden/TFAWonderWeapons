AddCSLuaFile()

SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-1,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false
SWEP.Blowback_Shell_Effect = "nil"-- ShotgunShellEject shotgun or ShellEject for a SMG    
SWEP.MuzzleFlashEffect = nil
SWEP.TracerCount 		= 0 	--0 disables, otherwise, 1 in X chance
SWEP.Primary.Delay			= 0.35
 
SWEP.UseHands				= true
SWEP.Type					= "Wonder Weapon"
SWEP.Category				= "TFA Wonder Weapons"
SWEP.Author				= "Moon, Deika & Hidden"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Zap Gun Dual Wield"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 4				-- Slot in the weapon selection menu
SWEP.SlotPos				= 20			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "duel"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Primary.HullSize = nil
SWEP.SelectiveFire		= false
SWEP.CanBeSilenced		= true
SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/wavegun/c_zapwave_gun.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/wavegun/w_zapguns.mdl"	-- Weapon world model
SWEP.WorldModelCombined = "models/weapons/wavegun/w_wavegun.mdl"
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Ispackapunched = 0
SWEP.NZPaPName = "Porter's X2 Zap Gun Dual Wield"
SWEP.NZWonderWeapon = true

SWEP.Primary.Sound			= Sound("Weapon_Zapgun.Fire")			-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 300			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 16		-- Size of a clip
SWEP.Primary.DefaultClip		= 80		-- Bullets you start with
--Recoil Related
SWEP.Primary.KickUp			= 0.17				-- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown			= 0.13				-- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal			= 0.2					-- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.3 	--Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "Tesla Bulbs"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 80		-- How much you 'zoom' in. Less is more! 	

SWEP.Secondary.Ammo			= "AR2AltFire"
SWEP.Secondary.DefaultClip	= 14
SWEP.Secondary.ClipSize		= 2

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 0

SWEP.Primary.NumShots	= nil		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 115	-- Base damage per bullet
SWEP.Primary.Spread		= .007	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-2.8, -0.1, 0.38)
SWEP.IronSightsAng = Vector(0, -1.52, 0)
SWEP.RunSightsPos = Vector (0, 0, 0)
SWEP.RunSightsAng = Vector (0, 0, 0)
SWEP.InspectPos = Vector(-0.71, -0.625, -1.537)
SWEP.InspectAng = Vector(25.525, 9.576, 0.023)

SWEP.VMPos = Vector(0, 0, -0.3) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(0, 0, 0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.


SWEP.CanDrawAnimate=true
SWEP.CanDrawAnimateEmpty=false
SWEP.CanDrawAnimateSilenced=true
SWEP.CanHolsterAnimate=true
SWEP.CanHolsterAnimateEmpty=false
SWEP.CanIdleAnimate=false
SWEP.CanIdleAnimateEmpty=false
SWEP.CanIdleAnimateSilenced=false
SWEP.CanShootAnimate=true
SWEP.CanShootAnimateSilenced=true
SWEP.CanReloadAnimate=true
SWEP.CanReloadAnimateEmpty=false
SWEP.CanReloadAnimateSilenced=true
SWEP.CanDryFireAnimate=false
SWEP.CanDryFireAnimateSilenced=false
SWEP.CanSilencerAttachAnimate=true
SWEP.CanSilencerDetachAnimate=true

SWEP.AllowSprintAttack = false

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_ANI --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint", --Number for act, String/Number for sequence
		["value_empty"] = "sprint",
		["is_idle"] = true
	},--looping animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
		["transition"] = true
	}
}

SWEP.SprintAnimationSilenced = {
    ["loop"] = {
        ["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
        ["value"] = ACT_VM_PULLBACK, --Number for act, String/Number for sequence
        ["is_idle"] = true
    },--looping animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_LOWERED_TO_IDLE, --Number for act, String/Number for sequence
		["transition"] = true
	}
}

SWEP.BaseAnimations = {
	["reload"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD
	},
	["reload_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD_SILENCED
	},
	["holster"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_HOLSTER
	},
	["holster_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_TO_LOWERED
	}
}

DEFINE_BASECLASS( SWEP.Base )

function SWEP:Initialize()
	self:SetNWString("dw_state", "dw")
	return BaseClass.Initialize(self)
end

function SWEP:CanPrimaryAttack()
	if self.AllowSprintAttack == false and self:GetSprinting() then return end

	if ( self.Weapon:Clip1() <= 0 and self:GetNWString("dw_state") == "dw" ) or ( self.Weapon:Clip2() <= 0 and self:GetNWString("dw_state") == "combined" ) then

		self:EmitSound( "Weapon_Pistol.Empty" )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:Reload()
		return false

	end

	return true

end

function SWEP:PrimaryAttack()
	if self:CanPrimaryAttack() then
		self:FireRocket()
		self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
	end
end

function SWEP:SecondaryAttack()
	if self:CanPrimaryAttack() then
		self:FireRocket2()
		self.Weapon:SetNextSecondaryFire(CurTime()+1/(self.Primary.RPM/60))
	end

end

function SWEP:FireRocket()
	local vm = self.Owner:GetViewModel()
	local own = self.Owner
	self.ShouldAmmoFix = true
	if SERVER then
		if self:GetNWString("dw_state") == "combined" then
			if self:Clip2() == 0 then timer.Simple(0.2, function() self:Reload() end) return end
			local ang = self.Owner:GetAngles()
			local pos = self.Owner:GetShootPos() + self.Owner:GetForward()*10 + self.Owner:GetUp()* -8 + self.Owner:GetRight()*8
			if self:GetIronSights() == false then
				pos = self.Owner:GetShootPos() + self.Owner:GetForward()*10 + self.Owner:GetUp()* -8 + self.Owner:GetRight()*8
			else
				pos = self.Owner:GetShootPos() + self.Owner:GetForward()*10 + self.Owner:GetUp()* -8
			end
			local orb1 = ents.Create("obj_wgun_proj2")
			self.Owner:EmitSound( "Weapon_Wavegun.Fire" )
			self.Weapon:TakeSecondaryAmmo(1)
			self.Owner:ViewPunch( Angle( math.Rand(-0.5,-0.4)*12, math.Rand(-1,1), 0 ) )
			--orb1.Trail = util.SpriteTrail(orb1,1,Color(255,50,255,255),false,32,0,0.75,0.118,"effects/laser_citadel1.vmt")
			orb1:SetPos(pos)
			orb1:SetAngles(ang)
			orb1.Owner = own
			if self.Ispackapunched == 1 then
				orb1.TrailPCF = "wgun_trail_child_pap"
				orb1.CollidePCF = "wgun_impact_pap"
			else
				orb1.TrailPCF = "wgun1_trail_child"
				orb1.CollidePCF = "wgun_impact"
			end
			orb1:Spawn()
			orb1:Activate()
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_SILENCED )
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
		else
			self.Owner:EmitSound(self.Primary.Sound)
			local pos = self.Owner:GetShootPos() + self.Owner:GetForward()*30 + self.Owner:GetUp()* -8 + self.Owner:GetRight()*-16
			local orb1 = ents.Create("obj_wgun_proj")
			self.Owner:ViewPunch( Angle( math.Rand(-0.5,-0.4), 0, 0 ) )
			self.Weapon:TakePrimaryAmmo(1)
			orb1:SetPos(pos)
			orb1:SetAngles((self.Owner:GetEyeTrace().HitPos - pos):Angle())
			orb1.Owner = own
			if self.Ispackapunched == 1 then
				orb1.TrailPCF = "rgun1_trail_child1_pap"
				orb1.CollidePCF = "rgun1_impact_pap"
			else
				orb1.TrailPCF = "rgun1_trail_child1_pap"
				orb1.CollidePCF = "rgun1_impact_pap"
			end
			orb1:Spawn()
			orb1:Activate()
			if self:GetIronSights() then
				self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
			else
				self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			end
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			ParticleEffectAttach( "mwave_muzzleflash_l", PATTACH_POINT_FOLLOW, vm, 2 )
			--ParticleEffectAttach( "mwave_muzzleflash_l", PATTACH_POINT_FOLLOW, self, 2 )
		end
	end
end

function SWEP:FireRocket2()
	local own = self.Owner
	local vm = self.Owner:GetViewModel()
	local pos = self.Owner:GetShootPos() + self.Owner:GetForward()*30 + self.Owner:GetUp()* -8 + self.Owner:GetRight()* 16
	local ply = player
	if self:GetNWString("dw_state") == "dw" then
		if SERVER then
			local orb1 = ents.Create("obj_wgun_proj")
			orb1:SetPos(pos)
			orb1:SetAngles((self.Owner:GetEyeTrace().HitPos - pos):Angle())
			orb1.Owner = own
			if self.Ispackapunched == 1 then
				orb1.TrailPCF = "rgun1_trail_child1_pap"
				orb1.CollidePCF = "rgun1_impact_pap"
			else
				orb1.TrailPCF = "rgun1_trail_child1_pap"
				orb1.CollidePCF = "rgun1_impact_pap"
			end
			orb1:Spawn()
			orb1:Activate()
		end
		self.Weapon:EmitSound(self.Primary.Sound)
		self.Weapon:TakePrimaryAmmo(1)
		self.Owner:ViewPunch( Angle( math.Rand(-0.5,-0.4), 0, 0 ) )
		self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		ParticleEffectAttach( "mwave_muzzleflash_r", PATTACH_POINT_FOLLOW, vm, 1 )
		--ParticleEffectAttach( "mwave_muzzleflash_r", PATTACH_POINT_FOLLOW, self, 1 )
	end
end

local tldata

function SWEP:Locomote(flipis, is, flipsp, spr, flipwalk, walk)
	if not (flipis or flipsp or flipwalk) then return end
	if not (self:GetStatus() == TFA.Enum.STATUS_IDLE or (self:GetStatus() == TFA.Enum.STATUS_SHOOTING and self:CanInterruptShooting())) then return end
	tldata = nil

	if flipis then
		if is and self:GetStat("IronAnimation.in") then
			tldata = self:GetStat("IronAnimation.in") or tldata
		elseif self:GetStat("IronAnimation.out") and not flipsp then
			tldata = self:GetStat("IronAnimation.out") or tldata
		end
	end

	if flipsp then
		if spr and self:GetStat("SprintAnimation.in") and not self:GetSilenced() then
			tldata = self:GetStat("SprintAnimation.in") or tldata
		elseif spr and self:GetStat("SprintAnimationSilenced.in") and self:GetSilenced() then
			tldata = self:GetStat("SprintAnimationSilenced.in") or tldata
		elseif self:GetStat("SprintAnimation.out") and not flipis and not spr and not self:GetSilenced() then
			tldata = self:GetStat("SprintAnimation.out") or tldata
		elseif self:GetStat("SprintAnimationSilenced.out") and not flipis and not spr and self:GetSilenced() then
			tldata = self:GetStat("SprintAnimationSilenced.out") or tldata
		end
	end

	if flipwalk then
		if walk and self:GetStat("WalkAnimation.in") then
			tldata = self:GetStat("WalkAnimation.in") or tldata
		elseif self:GetStat("WalkAnimation.out") and (not flipis and not flipsp) and not walk then
			tldata = self:GetStat("WalkAnimation.out") or tldata
		end
	end

	--self.Idle_WithHeld = true
	if tldata then return self:PlayAnimation(tldata) end
	--self:SetNextIdleAnim(-1)

	return false, -1
end


function SWEP:ChooseHolsterAnim()
	if not self:VMIV() then return end

	if self:GetActivityEnabled(ACT_VM_IDLE_TO_LOWERED) and self:GetSilenced() then
		typev, tanim = self:ChooseAnimation("holster_silenced")
	elseif self:GetActivityEnabled(ACT_VM_HOLSTER) then
		typev, tanim = self:ChooseAnimation("holster")
	else
		local _
		_, tanim = self:ChooseIdleAnim()

		return false, tanim
	end

	if typev ~= TFA.Enum.ANIMATION_SEQ then
		return self:SendViewModelAnim(tanim)
	else
		return self:SendViewModelSeq(tanim)
	end
end

/*
function SWEP:ChooseSprintAnim()
    if self:GetNWString("dw_state") == "combined" then
		return self:PlayAnimation(self:GetStat("SprintAnimationSilenced.loop"))
    else
        return self:PlayAnimation(self:GetStat("SprintAnimation.loop"))
    end
end
*/

function SWEP:ChooseSprintAnim()
	if not self:VMIV() then return end
	
    if self:GetSilenced() then
		return self:PlayAnimation(self:GetStat("SprintAnimationSilenced.loop"))
    else
        return self:PlayAnimation(self:GetStat("SprintAnimation.loop"))
    end
end

function SWEP:Reload(released)
	local ct = CurTime()
	self:PreReload(released)
	if hook.Run("TFA_PreReload",self,released) then return end

	if self.Owner:IsNPC() then
		return
	end

	if not self:VMIV() then return end

	if not self:IsJammed() then
		if self:Ammo1() <= 0 then return end
		if self:GetStat("Primary.ClipSize") < 0 then return end
	end

	if ( not released ) and ( not self:GetLegacyReloads() ) then return end
	if self:GetLegacyReloads() and not self:GetOwner():KeyDown(IN_RELOAD) then return end

	if self:GetNWBool("changing") then return end
	if self:GetNWBool("isreloading") then return end
	if self:GetNWString("dw_state") == "dw" and (self:Clip1() == self.Primary.ClipSize) then return end
	if self:GetNWString("dw_state") == "combined" and (self:Clip2() == self.Secondary.ClipSize) then return end
		
	local vm = self.Owner:GetViewModel()
	if !self:GetSilenced() and (self:Clip1() < self.Primary.ClipSize) then
		if (self.Owner:GetAmmoCount( self.Primary.Ammo ) == 0) then return end
		self:SetNWBool("isreloading", true)
		
		local _, tanim = self:ChooseReloadAnim()
		self:SetStatus(TFA.Enum.STATUS_RELOADING)
		self:SetStatusEnd(ct + self:GetActivityLength( tanim, true ) )
		self:SetNextPrimaryFire(ct + self:GetActivityLength( tanim, false ) )
		
		timer.Create("reload",self:GetActivityLength( tanim, false ),1,function() self:SetNWBool("isreloading", false) end)
	elseif self:GetSilenced() and (self:Clip2() < self.Secondary.ClipSize) then
		if (self.Owner:GetAmmoCount( self.Secondary.Ammo ) == 0) then return end
		self:SetNWBool("isreloading", true)
		
		local _, tanim = self:ChooseReloadAnim()
		self:SetStatus(TFA.Enum.STATUS_RELOADING)
		self:DefaultReload(ACT_VM_RELOAD_SILENCED)
		self:SetStatusEnd(ct + self:GetActivityLength( tanim, true ) )
		self:SetNextPrimaryFire(ct + self:GetActivityLength( tanim, false ) )
		
		timer.Create("reload",self:GetActivityLength( tanim, false ),1,function() 
			self:SetNWBool("isreloading", false)
			local amm = math.Clamp(self.Owner:GetAmmoCount( self.Secondary.Ammo ) - self:Clip2(), 0, 2 )
			self:SetClip2(self:Clip2()+amm)
			self.Owner:SetAmmo(self.Owner:GetAmmoCount( self.Secondary.Ammo ) - amm, self.Secondary.Ammo)
		end)
	end
	self:PostReload(released)
	hook.Run("TFA_PostReload",self)

	--return BaseClass.Reload(self)
end

SWEP.CanChangeStates = true
function SWEP:ToggleDWCombine()
	local vm = self.Owner:GetViewModel()
	if self.CanChangeStates == true then
		if self:GetNWBool("isreloading") then return end
		self:SetNWBool("changing",true)
		--self:SetIronSights( false )
		if self:GetNWString("dw_state") == "dw" then --combine weps
			self:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
			self:SetNextPrimaryFire(CurTime()+1.95)
			self:SetNextSecondaryFire(CurTime()+1.95)
			self:SetNWString("dw_state","combined")
			self:SetSilenced(true)
			timer.Simple(1.8,function()
				self.data.ironsights			= 1
				self:ClearStatCache("data.ironsights")
			end)
			self:SetHoldType("ar2")
			self:ClearStatCache("HoldType")
			self.WorldModel = "models/weapons/wavegun/w_wavegun.mdl"
			if self.Ispackapunched == 0 then
				self.PrintName = "Wave Gun"
			else
				self.PrintName = "Max Wave Gun"
				self.NZPaPName = "Max Wave Gun"
			end
		elseif self:GetNWString("dw_state") == "combined" then --detach weps
			self.WorldModel = "models/weapons/wavegun/w_zapguns.mdl"
			self:PreDrawViewModel()

			self:SetNWString("dw_state","dw")
			self:SetSilenced(false)
			self:SetHoldType("duel")
			self:ClearStatCache("HoldType")
			self.data.ironsights			= 0
			self:ClearStatCache("data.ironsights")
			self:SendWeaponAnim(ACT_VM_DETACH_SILENCER)
			if self.Ispackapunched == 0 then
				self.PrintName = "Zap Gun Dual Wield"
			else
				self.PrintName = "Porter's X2 Zap Gun Dual Wield"
				self.NZPaPName = "Porter's X2 Zap Gun Dual Wield"
			end
			
			if self.PrimaryEmpty1 == 1 then
				self:SetClip1( self:Clip1()+1 )
			end
		end
		self.CanChangeStates = false
		timer.Simple(1.82,function() self.CanChangeStates = true self:SetNWBool("changing",false) end)
	end
end


SWEP.ShouldAmmoFix = false
function SWEP:Think2()
	BaseClass.Think2(self)
	if (self.Owner:KeyDown(IN_USE) and self.Owner:KeyDown(IN_RELOAD)) then 
		self:ToggleDWCombine()
	end
	
	if self:GetNWString("dw_state") == "combined" then
		self:SetHoldType("ar2")
	else
		self:SetHoldType("duel")
	end
	
	
	if self.ShouldAmmoFix then
		if self:Ammo1() == 0 and self:Ammo2() > 0 and self:GetNWString("dw_state") == "combined" then
			self.Owner:SetAmmo( 1, "Tesla Bulbs" )
			if self:Clip1() == 0 then
				self:SetClip1( 1 )
				self.PrimaryEmpty = 1
			else
				self:SetClip1( self:Clip1()-1 )
			end
			self.PrimaryEmpty1 = 1
		end
		if self.PrimaryEmpty1 == 1 and self:GetNWString("dw_state") == "dw" then
			if self.PrimaryEmpty == 1 then
				self:SetClip1( 0 )
				self.PrimaryEmpty = 0
			end
			self.PrimaryEmpty1 = 0
			self.Owner:SetAmmo( 0, "Tesla Bulbs" )
		end
	end
	
end

-- Nzombies stuff

SWEP.DisableChambering = true
SWEP.Primary.MaxAmmo = 64
SWEP.Secondary.MaxAmmo = 12

-- Max Ammo function

function SWEP:NZMaxAmmo()
	local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo
	local ammo_type2 = self:GetSecondaryAmmoType() or self.Secondary.Ammo
	
	if SERVER then
		self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self.Owner:SetAmmo( self.Secondary.MaxAmmo, ammo_type2 )
	end
end

function SWEP:PreDrawViewModel( vm )
	if self.Ispackapunched == 1 then
		if self:GetNWString("dw_state") == "dw" then
			vm:SetSubMaterial(0, "models/weapons/common/bo1_pap_camo_c.vmt")
			vm:SetSubMaterial(2, "models/weapons/common/bo1_pap_camo_c.vmt")
		else
		end
	end
end

-- PaP Function
function SWEP:OnPaP()
	self.Ispackapunched = 1
	self.Primary.ClipSize = 24
	self.Primary.DefaultClip = 124
	self.Primary.MaxAmmo = 100
	self.Secondary.ClipSize = 4
	self.Secondary.DefaultClip = 28
	self.Secondary.MaxAmmo = 24
	self:SetClip2(4)
	self:ClearStatCache()
	return true
end