
SWEP.Gun					= ("weapon_wunderwaffe") --Make sure this is unique.  Specically, your folder name.
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Base				= "tfa_gun_base"
SWEP.Category				= "TFA Wonder Weapons" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer = nil --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "Deika & Hidden" --Author Tooltip
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "" --Purpose Tooltip
SWEP.Instructions				= "" --Instructions Tooltip
SWEP.Spawnable				= true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?
SWEP.PrintName				= "Wunderwaffe DG-2"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 2				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 10			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter if enabled in the GUI.
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.
SWEP.Primary.Recoil 		   = 0.5
SWEP.Type					= "Wonder Weapon"
SWEP.Range = 2*GetConVarNumber( "sk_vortigaunt_zap_range",100)*12	
SWEP.ArcEffect = "tesla_beam"
SWEP.NZWonderWeapon = true

game.AddAmmoType( {
 name = "Tesla Bulbs",
 dmgtype = DMG_BULLET,
 tracer = TRACER_LINE,
 plydmg = 0,
 npcdmg = 0,
 force = 2000,
 minsplash = 10,
 maxsplash = 5
} )

--[[WEAPON HANDLING]]--

--Firing related
SWEP.Primary.Sound 			= Sound("Weapon_WunderWaffe.Shoot")				-- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound 			= nil				-- This is the sound of the weapon, when silenced.
SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage		= 115					-- Damage, in standard damage points.
SWEP.Primary.HullSize = 0 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.
SWEP.Primary.NumShots	= 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic			= true					-- Automatic/Semi Auto
SWEP.Primary.RPM				= 60					-- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Semi				= nil					-- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Burst				= nil					-- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Primary.BurstDelay				= nil					-- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater = false

SWEP.IronInSound = nil --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = nil --Sound to play when ironsighting out?  nil for default

SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = false --Silenced by default?

-- Selective Fire Stuff

SWEP.SelectiveFire		= false --Allow selecting your firemode?
SWEP.DisableBurstFire	= false --Only auto/single?
SWEP.OnlyBurstFire		= false --No auto, only burst/single?
SWEP.DefaultFireMode 	= "Auto" --Default to auto or whatev
SWEP.FireModeName = nil --Change to a text value to override it

--Ammo Related

SWEP.Primary.ClipSize			= 3					-- This is the size of a clip
SWEP.Primary.DefaultClip			= 18				-- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.MaxAmmo			= 15
SWEP.Primary.Ammo			= "Tesla Bulbs"					-- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.DisableChambering = true --Disable round-in-the-chamber

--Recoil Related
SWEP.Primary.KickUp            = 0.5                -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown            = 0.3                    -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal            = 0.2                -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.5     --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

--Firing Cone Related

SWEP.Primary.Spread		= .01					--This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .005	-- Ironsight accuracy, should be the same for shotguns

--[[PROJECTILES]]--

SWEP.ProjectileEntity = "obj_blank_proj" --Entity to shoot
SWEP.ProjectileVelocity = 50000 --Entity to shoot's velocity
SWEP.ProjectileModel = nil --Entity to shoot's model

--[[VIEWMODEL]]--

SWEP.ViewModel			= "models/weapons/wunderwaffe/v_wunderwaffe.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 75		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.MaterialTable = nil --Make sure the viewmodel and the worldmodel have the same material ids.  Next, fill this in with your desired submaterials.
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.VMPos = Vector(0.25, -3, -1.50)
SWEP.VMAng = Vector(0, 0, 0)

--[[WORLDMODEL]]--

SWEP.WorldModel			= "models/weapons/wunderwaffe/w_wunderwaffe.mdl" -- Weapon world model path

SWEP.WMBodyGroups = nil--{
	--[0] = 1,
	--[1] = 4,
	--[2] = etc.
--}

SWEP.HoldType 				= "ar2"		

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 0,
        Forward = 0,
        },
        Ang = {
        Up = -1,
        Right = -2,
        Forward = 178
        },
		Scale = 1
}





--[[IRONSIGHTS]]--

SWEP.data 				= {}
SWEP.data.ironsights			= 1 --Enable Ironsights
SWEP.Secondary.IronFOV			= 70					-- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.

SWEP.IronSightsPos = Vector(-5.10, -3.25, 2.0)
SWEP.IronSightsAng = Vector(-1.55, 0, 0)
SWEP.RunSightsPos = Vector(5.225, -14.674, -3.217)
SWEP.RunSightsAng = Vector(-4.222, 70, -17.588)

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_LUA --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation


--[[INSPECTION]]--

--SWEP.InspectPos = Vector(0,0,0) --Replace with a vector, in style of ironsights position, to be used for inspection
--SWEP.InspectAng = Vector(0,0,0) --Replace with a vector, in style of ironsights angle, to be used for inspection



--[[Stuff you SHOULD NOT touch after this]]--

--Allowed VAnimations.  These are autodetected, so not really needed except as an extra precaution.  Do NOT change these, unless absolutely necessary.

SWEP.CanDrawAnimate=true
SWEP.CanDrawAnimateEmpty=false
SWEP.CanDrawAnimateSilenced=false
SWEP.CanHolsterAnimate=true
SWEP.CanHolsterAnimateEmpty=false
SWEP.CanIdleAnimate=true
SWEP.CanIdleAnimateEmpty=false
SWEP.CanIdleAnimateSilenced=false
SWEP.CanShootAnimate=true
SWEP.CanShootAnimateSilenced=false
SWEP.CanReloadAnimate=true
SWEP.CanReloadAnimateEmpty=false
SWEP.CanReloadAnimateSilenced=false
SWEP.CanDryFireAnimate=false
SWEP.CanDryFireAnimateSilenced=false
SWEP.CanSilencerAttachAnimate=false
SWEP.CanSilencerDetachAnimate=false

--Misc

SWEP.ShouldDrawAmmoHUD=false--THIS IS PROCEDURALLY CHANGED AND SHOULD NOT BE TWEAKED.  BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.DefaultFOV=90 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.

--Disable secondary crap

SWEP.Secondary.ClipSize			= 0					-- Size of a clip
SWEP.Secondary.DefaultClip			= 0					-- Default ammo to give...
SWEP.Secondary.Automatic			= false					-- Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none" -- Self explanitory, ammo type.

--[[EFFECTS]]--
--Attachments
SWEP.MuzzleAttachment			= "1" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "2" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled = false --Enable muzzle flash
SWEP.MuzzleAttachmentRaw = nil --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = nil --Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.SmokeParticle = nil --Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = true --Disable automatic ejection smoke

--Convar support

SWEP.ConDamageMultiplier = 1

SWEP.Base				= "tfa_gun_base"

DEFINE_BASECLASS( SWEP.Base )

function SWEP:NZMaxAmmo(maxammo)
if SERVER then
self.Primary.NZMaxAmmo = 15
end
BaseClass.NZMaxAmmo( self, maxammo ) 
end

SWEP.LightNum = 3
function SWEP:FireAnimationEvent(pos, ang, event, options)
	local vm = self.Owner:GetViewModel()
	
	-- First Raise = 9091
	-- Pullout = 9001
	-- Fire = 9061
	-- Finish Reload = 9071
	-- Start Reload = 9081
	
		self.LightNum = math.Clamp(self.Weapon:Clip1() + self.Owner:GetAmmoCount(self.Primary.Ammo), 0, 3)

if event == 9091 then -- First Raise

				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 2)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 3)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 4)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 5)
				
end

if event == 9001 then -- Pullout
			if self.Weapon:Clip1() == 3 then
				vm:StopParticles()
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 2)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 3)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 4)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 5)
			elseif self.Weapon:Clip1() == 2 then
				vm:StopParticles()
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 2)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 3)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 5)
			elseif self.Weapon:Clip1() == 1 then
				vm:StopParticles()
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 2)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 5)
			elseif self.Weapon:Clip1() == 0 then
				vm:StopParticles()
	end
end
			

if event == 9081 then -- Start Reload	
vm:StopParticles()
end

if event == 9061 then -- Fire
			if self.Weapon:Clip1() == 3 then
				vm:StopParticles()
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 2)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 3)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 4)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 5)
			elseif self.Weapon:Clip1() == 2 then
				vm:StopParticles()
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 2)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 3)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 5)
			elseif self.Weapon:Clip1() == 1 then
				vm:StopParticles()
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 2)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 5)
			elseif self.Weapon:Clip1() == 0 then
				vm:StopParticles()
		end
		ParticleEffectAttach( "tesla_mflash", PATTACH_POINT_FOLLOW, vm, 1)
end
	if event == 9071 then -- Finish Reload
			if self.LightNum == 3 then
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 2)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 3)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 4)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 5)
			elseif self.LightNum == 2 then
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 2)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 3)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 5)
			elseif self.LightNum == 1 then
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 2)
				ParticleEffectAttach( "tesla_vm_glow", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 5)
			
		end
	end
end

function SWEP:PrimaryAttack( old )
	if !self:CanPrimaryAttack() then return	end	
	local own = self.Owner
	if SERVER then
		local orb1 = ents.Create("wunderwaffe_entity_ball")
		if self:GetIronSights() then
			pos = own:GetShootPos() + own:GetUp()*-6
		elseif ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT )) then
			pos = own:GetShootPos() + own:GetUp()*-6 + own:GetRight()*5
		else
			pos = own:GetShootPos() + own:GetUp()*-6 + own:GetRight()*5
		end
		orb1:SetPos(pos)
		orb1:SetAngles((own:GetEyeTrace().HitPos - pos):Angle())
		orb1.Owner = own
		orb1:Spawn()
		orb1:Activate()
	end
	local vm = self.Owner:GetViewModel()
	--self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	--own:SetAnimation( PLAYER_ATTACK1 )
	BaseClass.PrimaryAttack( self, old )
end

SWEP.NZPaPName = "Wunderwaffe DG-3 JZ"

-- Nzombies stuff

SWEP.DisableChambering = true
SWEP.Primary.MaxAmmo = 15

-- Max Ammo function

function SWEP:NZMaxAmmo()

	local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
    end
end

-- PaP Function
function SWEP:OnPaP()
	self.Ispackapunched = 1
	self.Primary.ClipSize = 6
	self.Primary.MaxAmmo = 30
	self:ClearStatCache()
	return true
end

SWEP.Ispackapunched = 0
function SWEP:PreDrawViewModel( vm )
	if self.Ispackapunched == 1 then
		vm:SetSubMaterial(0, "models/weapons/common/wawpap.vmt")
		vm:SetSubMaterial(4, "models/weapons/common/wawpap.vmt")
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(4, nil)
	end
end
