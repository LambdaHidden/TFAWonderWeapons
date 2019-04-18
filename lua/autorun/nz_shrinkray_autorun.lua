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
--Playing this one from Lua instead of the model to avoid cutoff. To change it back, copy the sound from Weapon_Shrinkray.Mag_in.
sound.Add(
{
    name = "Weapon_Shrink.Raise",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
	sound = ""
})
sound.Add({
	name = 			"Weapon_Shrink.Shoot",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		"weapons/shrinkray/plr/wpn_shrink_plr_fire.wav"
})
sound.Add({
	name = 			"Weapon_Shrink.ShootPap",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		"weapons/shrinkray/plr/wpn_shrink_plr_fire_upgraded.wav"
})

game.AddParticles("particles/babygun_fx.pcf")
PrecacheParticleSystem("babygun_muzzle")
PrecacheParticleSystem("babygun_muzzle_pap")	-- Muzzle Flash particle
PrecacheParticleSystem("babygun_muzzlesmoke")
PrecacheParticleSystem("babygun_muzzlesmoke_pap")
PrecacheParticleSystem("babygun_proj")
PrecacheParticleSystem("babygun_proj_pap")
PrecacheParticleSystem("babygun_ring")
PrecacheParticleSystem("babygun_ring_inverted")
PrecacheParticleSystem("babygun_impact")
PrecacheParticleSystem("babygun_impact_pap")

CreateConVar( "nz_shrinkray_shrinkplayers", "1", FCVAR_NONE, "Enables/Disables the 31-79 JGb215's ability to shrink players." )

local babyDieTable = {"weapons/zmb/mini/squashed/zmb_mini_squashed01.wav","weapons/zmb/mini/squashed/zmb_mini_squashed02.wav","weapons/zmb/mini/squashed/zmb_mini_squashed03.wav","weapons/zmb/mini/squashed/zmb_mini_squashed04.wav"}
local kickSoundTable = {"weapons/zmb/mini/kicked/zmb_mini_kicked01.wav","weapons/zmb/mini/kicked/zmb_mini_kicked02.wav","weapons/zmb/mini/kicked/zmb_mini_kicked03.wav","weapons/zmb/mini/kicked/zmb_mini_kicked04.wav"}
hook.Add("Think","KickBabyGunCheck",function()
local babykicker = nil
    for k,v in pairs(player.GetAll()) do
        for a,b in pairs(ents.FindInSphere( v:GetPos(), 35 )) do
            if b:IsNPC() or scripted_ents.GetType( b:GetClass() ) == "nextbot" or b:IsPlayer() and v ~= b then
                if b:GetNWString("ShouldKickBaby") == "true" then
                    local aim = v:GetAimVector()
                    local force  = aim*(3*500)
                    if SERVER then
                        if b:IsNPC() or scripted_ents.GetType( b:GetClass() ) == "nextbot" or b:IsPlayer() then
                            local OldBoneScale = b:GetModelScale()
--                          rag:GetPhysicsObject():ApplyForceCenter(Vector(0,0,900))
                            if b:GetNWString("CanAddVelocity") == "true" then
                                local tr = v:GetEyeTrace();
                                local shot_length = tr.HitPos:Length()
                                local multiplyscale = math.random(1500,3000)
								
								b:EmitSound(kickSoundTable[math.random(1,table.Count(kickSoundTable))])
								timer.Simple(0.1,function()
									b:SetNWString("BabyOnGround","true")
								end)
								b:SetNWString("CanAddVelocity","false")
								if scripted_ents.GetType( b:GetClass() ) == "nextbot" then
									local dmg = DamageInfo()
									dmg:SetDamage(b:Health())
									dmg:SetAttacker(v)
									dmg:SetDamageForce(Vector (aim.x*multiplyscale*3, aim.y*multiplyscale*3, math.random(4000,7000)))
									b:SetPos(b:GetPos()+Vector(0,0,32))
									timer.Simple(0.1,function()
										b:TakeDamageInfo(dmg)
									end)
								else
									b:SetVelocity( Vector(aim.x*multiplyscale,aim.y*multiplyscale,math.random(200,350)) )
									b:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
									b:SetLocalAngularVelocity(Angle(math.random(250,500),math.random(0,5),0))
								end
                            end
                        end
                    end
                end
            end
        end
    
    for c,d in pairs(ents.GetAll()) do
 
        if IsValid(v) and d:IsValid() and d:IsOnGround() and d:GetNWString("BabyOnGround") == "true" and d:GetNWString("IsBaby") == "true" then           
            local dpos = d:GetPos()    
            if d:IsNPC() or scripted_ents.GetType( d:GetClass() ) == "nextbot" or d:IsPlayer() then
				if SERVER then
					local dmg = DamageInfo()
					dmg:SetDamage(d:Health())
					dmg:SetAttacker(v)
					d:TakeDamageInfo(dmg)
					if d:IsPlayer() then
						d:SetViewOffset(Vector(0,0,64))
						d:SetModelScale(1,0)
						d:SetNWString("ShouldKickBaby","false")
						d:SetNWString("IsBaby","false")
						d:SetNWString("BabyOnGround","false")
						if d:LookupBone("ValveBiped.Bip01_Head1") ~= nil then
                            d:ManipulateBoneScale(d:LookupBone("ValveBiped.Bip01_Head1"),Vector(1,1,1))
                        end
					end
				end
            end
            d:EmitSound(babyDieTable[math.random(1,table.Count(babyDieTable))])        
 
 
            local startp = dpos
            local traceinfo = {start = startp, endpos = startp - Vector(0,0,50), filter = ent, mask = MASK_NPCWORLDSTATIC}
            local trace = util.TraceLine(traceinfo)
            local todecal1 = trace.HitPos + trace.HitNormal
            local todecal2 = trace.HitPos - trace.HitNormal
            util.Decal("Blood", todecal1, todecal2)    
            if SERVER then
                local gib = ents.Create("ent_gib")
				if IsValid(gib) then
					gib:SetPos(dpos + Vector(0,0,1))
					gib:Spawn()
					local phys = gib:GetPhysicsObject()
					if (phys:IsValid()) then
						phys:SetVelocity(Vector(math.random(-50,50),math.random(-50,50),150) * math.random(2,3))
					end
				end
				d:Remove()
            end
        end
    end
	end
end)

hook.Add("PlayerDeath", "FixShrunkenPlayers", function(ply)
	ply:SetViewOffset(Vector(0,0,64))
	ply:SetModelScale(1,0)
	ply:SetNWString("ShouldKickBaby","false")
	ply:SetNWString("IsBaby","false")
	ply:SetNWString("BabyOnGround","false")
	if ply:LookupBone("ValveBiped.Bip01_Head1") ~= nil then
		ply:ManipulateBoneScale(ply:LookupBone("ValveBiped.Bip01_Head1"),Vector(1,1,1))
	end
end)

hook.Add("EntityTakeDamage", "BabyHit", function(target, dmginfo)
	if dmginfo:GetAttacker():GetNWString("IsBaby") == "true" then
		dmginfo:SetDamage(dmginfo:GetDamage()*0.2)
	end
end)

hook.Add("EntityEmitSound", "BabySounds", function(data)
	if data.Entity:GetNWString("IsBaby") == "true" and !table.HasValue( babyDieTable, data.OriginalSoundName ) and !table.HasValue( kickSoundTable, data.OriginalSoundName ) and data.OriginalSoundName != "weapons/shrinkray/effects/evt_unshrink.wav" and data.OriginalSoundName != "weapons/shrinkray/effects/evt_shrink.wav" then
		data.Pitch = 168
		return true
	end
end)