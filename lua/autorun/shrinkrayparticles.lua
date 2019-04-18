game.AddParticles("particles/babygun_fx.pcf")
PrecacheParticleSystem("babygun_muzzle")	-- Muzzle Flash particle
PrecacheParticleSystem("babygun_muzzlesmoke")
PrecacheParticleSystem("babygun_proj")
PrecacheParticleSystem("babygun_ring")
PrecacheParticleSystem("babygun_ring_inverted")
--PrecacheParticleSystem("babygun_impact")

sound.Add(
{
    name = "Weapon_Shrinkray.idle",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/shrinkray/reload/wpn_shrink_fins_fixed.wav"
})
sound.Add(
{
    name = "Weapon_Shrinkray.Mag_in",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/shrinkray/reload/wpn_shrink_mag_in.wav"
})
sound.Add(
{
    name = "Weapon_Shrinkray.Mag_out",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/shrinkray/reload/wpn_shrink_mag_out.wav"
})
sound.Add(
{
    name = "Weapon_Shrinkray.Futz",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/shrinkray/reload/wpn_shrink_futz.wav"
})
sound.Add(
{
    name = "Weapon_Shrink.Raise",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
	sound = "weapons/shrinkray/plr/wpn_shrink_plr_f.wav"
})
sound.Add({
	name = 			"Weapon_Shrink.Shoot",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		"weapons/shrinkray/plr/wpn_shrink_plr_quad.wav"
})

CreateConVar( "nz_shrinkray_shrinkplayers", "1", FCVAR_NONE, "Enables/Disables the 31-79 JGb215's ability to shrink players." )

local babyDieTable = {"weapons/zmb/mini/squashed/zmb_mini_squashed01.wav","weapons/zmb/mini/squashed/zmb_mini_squashed02.wav","weapons/zmb/mini/squashed/zmb_mini_squashed03.wav","weapons/zmb/mini/squashed/zmb_mini_squashed04.wav"}
local kickSoundTable = {"weapons/zmb/mini/kicked/zmb_mini_kicked01.wav","weapons/zmb/mini/kicked/zmb_mini_kicked02.wav","weapons/zmb/mini/kicked/zmb_mini_kicked03.wav","weapons/zmb/mini/kicked/zmb_mini_kicked04.wav"}

if SERVER then
    util.AddNetworkString( "KickBabyGunServer" )
    
    local function kickBaby(victim, attacker)
        local tr = attacker:GetEyeTrace();
        local shot_length = tr.HitPos:Length()
        local multiplyscale = math.random(1500,3000)
        local aim = attacker:GetAimVector()
        
		victim:SetNWBool("ShouldKickBaby", false)
        victim:EmitSound(kickSoundTable[math.random(1,table.Count(kickSoundTable))])
		
		local dmg = DamageInfo()
		dmg:SetDamage(victim:Health())
		dmg:SetAttacker(attacker)
		dmg:SetDamageForce(Vector (aim.x*multiplyscale*3, aim.y*multiplyscale*3, math.random(4000,7000)))
		
		if victim:IsNPC() then
			victim:SetVelocity( Vector(aim.x*multiplyscale,aim.y*multiplyscale,math.random(200,350)) )
			victim:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			victim:SetLocalAngularVelocity(Angle(math.random(250,500),math.random(0,5),0))
			
			local identifier = victim:EntIndex().."kickBabyLanded"
			timer.Create( identifier, 0.2, 0, function()
				if victim:IsOnGround() then
					local dmg2 = DamageInfo()
					dmg2:SetDamage(victim:Health())
					dmg2:SetAttacker(attacker)
					victim:TakeDamageInfo(dmg2)
					
					victim:EmitSound(babyDieTable[math.random(1,table.Count(babyDieTable))])
					local startp = victim:GetPos()
					local traceinfo = {start = startp, endpos = startp - Vector(0,0,50), filter = victim, mask = MASK_NPCWORLDSTATIC}
					local trace = util.TraceLine(traceinfo)
					local todecal1 = trace.HitPos + trace.HitNormal
					local todecal2 = trace.HitPos - trace.HitNormal
					util.Decal("Blood", todecal1, todecal2)    
					local gib = ents.Create("ent_gib")
					if IsValid(gib) then
						gib:SetPos(startp + Vector(0,0,1))
						gib:Spawn()
						local phys = gib:GetPhysicsObject()
						if (phys:IsValid()) then
							phys:SetVelocity(Vector(math.random(-50,50),math.random(-50,50),150) * math.random(2,3))
						end
					end
					victim:Remove()
					
					if timer.Exists(identifier) then
						timer.Remove(identifier)
					end
				end
			end)
			
		else
			victim:SetPos(victim:GetPos()+Vector(0,0,32))
			timer.Simple(0.1, function() 
				victim:TakeDamageInfo(dmg)
			end)
		end
    end
    
    net.Receive("KickBabyGunServer", function(len, ply)
        local b = net.ReadEntity()
        if IsValid(b) then
            if b:GetNWBool("ShouldKickBaby") and b:GetPos():DistToSqr(ply:GetPos()) < 1225 then
                if b:IsNPC() or scripted_ents.GetType( b:GetClass() ) == "nextbot" or b:IsPlayer() then
                    kickBaby(b, ply)
                end
            end
        end
    end)
end

if CLIENT then
	hook.Add("Think","KickBabyGunClient",function()
		for a,b in pairs(ents.FindInSphere( LocalPlayer():GetPos(), 35 )) do
			if b:IsNPC() or scripted_ents.GetType( b:GetClass() ) == "nextbot" or b:IsPlayer() and LocalPlayer() ~= b then
				if b:GetNWBool("ShouldKickBaby") then
					net.Start("KickBabyGunServer")
					net.WriteEntity(b)
					net.SendToServer()
				end
			end
		end
	end)
end

hook.Add("EntityTakeDamage", "BabyHit", function(target, dmginfo)
	if dmginfo:GetAttacker():GetNWBool("IsBaby") then
		dmginfo:SetDamage(dmginfo:GetDamage()*0.2)
	end
end)

hook.Add("PlayerDeath", "FixShrunkenPlayers", function(ply)
	ply:SetViewOffset(Vector(0,0,64))
	ply:SetModelScale(1,0)
	ply:SetNWBool("ShouldKickBaby",false)
	ply:SetNWBool("IsBaby",false)
	ply:SetNWBool("BabyOnGround",false)
	if ply:LookupBone("ValveBiped.Bip01_Head1") ~= nil then
		ply:ManipulateBoneScale(ply:LookupBone("ValveBiped.Bip01_Head1"),Vector(1,1,1))
	end
end)

hook.Add("EntityEmitSound", "BabySounds", function(data)
	if data.Entity:GetNWBool("IsBaby") and !table.HasValue( babyDieTable, data.OriginalSoundName ) and !table.HasValue( kickSoundTable, data.OriginalSoundName ) and data.OriginalSoundName != "weapons/shrinkray/effects/evt_unshrink.wav" and data.OriginalSoundName != "weapons/shrinkray/effects/evt_shrink.wav" then
		data.Pitch = 168
		return true
	end
end)