SWEP.Firstdraw = 1
SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-1,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false
SWEP.Blowback_Shell_Effect = "nil"-- ShotgunShellEject shotgun or ShellEject for a SMG    
SWEP.MuzzleFlashEffect = "raygun_sparks"
SWEP.TracerName 		= "raygun_trail"
SWEP.TracerCount 		= 0 	--0 disables, otherwise, 1 in X chance
SWEP.Primary.Delay			= 0.35
 
SWEP.UseHands				= true
SWEP.DisableChambering		= true
SWEP.Type					= "Wonder Weapon"
SWEP.Category				= "TFA Wonder Weapons"
SWEP.Author				= "Raven & Hidden"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Ray Gun"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 21			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "pistol"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Primary.HullSize = 150
SWEP.SelectiveFire		= false
SWEP.CanBeSilenced		= false
SWEP.ViewModelFOV			= 60
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/raygun/v_raygun.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/raygun/w_raygun.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.Ispackapunched = 0
SWEP.NZPaPName = "Porter's X2 Ray Gun"
SWEP.NZWonderWeapon = false

game.AddAmmoType({
	name = "Cold Cell Batteries",
	dmgtype = DMG_BLAST,
	tracer = TRACER_NONE,
	plydmg = 50,
	npcdmg = 20,
	force = 2000,
	minsplash = 10,
	maxsplash = 20
})

SWEP.Primary.Sound			= Sound("raygun_fire.wav")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 181			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 20		-- Size of a clip
SWEP.Primary.DefaultClip		= 180		-- Bullets you start with
--Recoil Related
SWEP.Primary.KickUp			= 0.17				-- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown			= 0.13				-- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal			= 0.2					-- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.3 	--Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "Cold Cell Batteries"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 80		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1
SWEP.FireModes = {
	"Auto"
}
SWEP.Primary.NumShots	= nil		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 115	-- Base damage per bullet
SWEP.Primary.Spread		= .007	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-5.39, 0.602, 1.29)
SWEP.IronSightsAng = Vector(-1.8, 0.05, 0)
SWEP.RunSightsPos = Vector (4.76, 0, -0.201)
SWEP.RunSightsAng = Vector (-5, 4.4, 9.1)
SWEP.InspectPos = Vector(5.92, 0, -1.441)
SWEP.InspectAng = Vector(13.199, 26.6, 10)

SWEP.customboboffset = Vector(0,0,0)

SWEP.ViewModelBoneMods = {
	["tag_view"] = { scale = Vector(1, 1, 1), pos = Vector(6.31, 0.75, -0.044), angle = Angle(0, 0, 0) }
}

SWEP.Offset = {
        Pos = {
        Up = 0,
        Right = 0,
        Forward = -2,
        },
        Ang = {
        Up = 0,
        Right = -9,
        Forward = 180,
        },
		Scale = 1.0
}

SWEP.VMPos = Vector(1, 0, -0.2) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(1, 0, 0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_LUA --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation


CurVMPos = Vector(1, 0, -0.2)
CurVMAng = Vector(1, 0, 0)

DEFINE_BASECLASS( SWEP.Base )

function SWEP:Think2()
	BaseClass.Think2(self)
		if ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT )) and !self:GetIronSights() and !self.Owner:KeyDown( IN_SPEED ) and !(self:GetStatus() == TFA.Enum.STATUS_RELOADING) and !(self:GetStatus() == TFA.Enum.STATUS_DRAW) then
			CurVMPos = Lerp(0.05, CurVMPos, Vector(-1, 0, -2.1))
			CurVMAng = Lerp(0.1, CurVMAng, Vector(1, 0, -2))
			--self.BobScaleCustom = 1
		else
			CurVMPos = Lerp(0.05, CurVMPos, Vector(1, 0, -0.2))
			CurVMAng = Lerp(0.1, CurVMAng, Vector(0, 0, 0))
		end
	self.VMPos = CurVMPos --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
	self.VMAng = CurVMPos --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
end

function SWEP:PrimaryAttack()
if !self:CanPrimaryAttack() then return end
	local own = self.Owner
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	if SERVER then
		local orb1 = ents.Create("obj_rgun_proj")
		//orb1.Trail = util.SpriteTrail(orb1,1,Color(50,255,50,255),false,32,0,0.75,0.118,"effects/laser_citadel1.vmt")
		local pos
		/*local obj,pos = own:LookupAttachment("anim_attachment_RH")
		if obj != 0 then
			pos = own:GetAttachment(obj).Pos-own:GetForward()*50 
		else
			pos = own:GetShootPos()-own:GetForward()*25 
		end*/
		--pos = util.TraceLine({start=own:EyePos(),endpos=pos,filter=own}).HitPos
		if self:GetIronSights() then
			pos = own:GetShootPos() + own:GetUp()*-6
		elseif ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT )) then
			pos = own:GetShootPos() + own:GetUp()*-12 + own:GetRight()*9
		else
			pos = own:GetShootPos() + own:GetUp()*-9 + own:GetRight()*16
		end
		--debugoverlay.Sphere(pos,5) 
		orb1:SetPos(pos)
		orb1:SetAngles((own:GetEyeTrace().HitPos - pos):Angle())
		orb1.Owner = own
		if self.Ispackapunched == 1 then
		orb1.TrailPCF = "rgun1_trail_child1_pap"
		orb1.CollidePCF = "rgun1_impact_pap"	
		else 
		orb1.TrailPCF = "rgun1_trail_child1"
		orb1.CollidePCF = "rgun1_impact"
end		
		orb1:Spawn()
		orb1:Activate()
	
end
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	own:SetAnimation( PLAYER_ATTACK1 )
	self:TakePrimaryAmmo(1)
	self.Weapon:EmitSound("raygun_fire.wav")
	--own:SetVelocity( (own:GetAimVector()* -75) )
	self.Owner:ViewPunch( Angle(-2, 0 ))
end

function SWEP:PreDrawViewModel( vm )
if self.Ispackapunched == 0 then
	self.Owner:GetViewModel():SetSubMaterial(3, nil)
end
end

-- Nzombies stuff

SWEP.DisableChambering = true
SWEP.Primary.MaxAmmo = 160

-- Max Ammo function

function SWEP:NZMaxAmmo()

	local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
    end
end

SWEP.Ispackapunched = 0
function SWEP:PreDrawViewModel( vm )
if self.Ispackapunched == 1 then
		self.Owner:GetViewModel():SetSubMaterial(0, "models/wunderwaffe/wawpap.vmt")
else
		self.Owner:GetViewModel():SetSubMaterial(0, nil)
		self.Owner:GetViewModel():SetSubMaterial(3, "models/weapons/raygun/ray_gun.vmt")
end
end

-- PaP Function
function SWEP:OnPaP()
self.Ispackapunched = 1
self.Primary.ClipSize = 40
self.Primary.MaxAmmo = 200
self:ClearStatCache()
return true
end


