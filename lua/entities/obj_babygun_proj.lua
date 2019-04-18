AddCSLuaFile()
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

function ENT:Initialize()
	self:SetModel( "models/dav0r/hoverball.mdl" )
	self:SetNoDraw(true)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:DrawShadow(false)
	self:SetCollisionGroup( COLLISION_GROUP_PROJECTILE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetSolidFlags(FSOLID_NOT_STANDABLE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	if CLIENT then return end
	self:SetTrigger(true)
	local eff = ents.Create("info_particle_system")
	eff:SetKeyValue("effect_name", self.TrailPCF)
	eff:SetKeyValue("start_active", "1")
	eff:SetPos(self:GetPos())
	eff:SetParent(self)
	eff:Spawn()
	eff:Activate()
	self.Effect = eff
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass( 1 )
		phys:EnableGravity( false )
		phys:EnableDrag( false )
		phys:Wake()
		phys:ApplyForceCenter(self:GetForward()*1000)
	else
		self:Remove()
	end
	self.LifeTime = CurTime() + math.Rand(3,4)
end
if SERVER then
	function ENT:OnCollide(ent,hitpos)
		if self.DoRemove then return end
		if self.Owner == ent then return end
		if ent:IsWorld() then
			ParticleEffect( self.ImpactPCF, self:GetPos(), Angle(0,0,0), nil )
			self.DoRemove = true
			self.Effect:SetParent(NULL)
			SafeRemoveEntityDelayed(self.Effect,1)
			self.Effect:Fire("Stop")
			self:PhysicsDestroy()
			SafeRemoveEntityDelayed(self,0)
		end
		
		self:NextThink(CurTime())
		
		for k,v in pairs (ents.FindInSphere(hitpos,128)) do
			if engine.ActiveGamemode() == "nzombies" then
                if IsValid(v) and (v:IsNPC() or scripted_ents.GetType(v:GetClass()) == "nextbot") then
                    if v:GetNWBool("IsBaby") ~= true and v:GetNWBool("IsBaby") ~= false then v:SetNWBool("IsBaby",false) end
                    if !v:GetNWBool("IsBaby") then
                        v:SetModelScale(0.4,0.5)
                        timer.Simple(0.25,function() 
							if IsValid(v) then
								v:EmitSound( "weapons/shrinkray/effects/evt_shrink.wav" ) 
							end
						end)
						ParticleEffectAttach( "babygun_ring", PATTACH_POINT_FOLLOW, v, 1 )
                        if v:LookupBone("ValveBiped.Bip01_Head1") ~= nil then
                            v:ManipulateBoneScale(v:LookupBone("ValveBiped.Bip01_Head1"),Vector(3.5,3.5,3.5))
                        end
                        v:SetNWBool("IsBaby",true)
                        v:SetNWBool("ShouldKickBaby",true)
                        v:SetNWBool("CanAddVelocity",true) 
						v:SetNWInt("backuphealth", v:Health())
						v:SetHealth(1)
                        v:SetNWBool("BabyOnGround",false)
						timer.Simple(math.random(self.Timer,self.Timer + 0.15),function()
                            if v:IsValid() and v:OnGround() and !v:GetNWBool("IsBaby") then
                                v:SetModelScale(1,0.5)
								v:SetHealth(v:GetNWInt("backuphealth"))
                                if v:LookupBone("ValveBiped.Bip01_Head1") ~= nil then
                                    v:ManipulateBoneScale(v:LookupBone("ValveBiped.Bip01_Head1"),Vector(1,1,1))
                                end
                                v:SetNWBool("ShouldKickBaby",false)    
                                v:SetNWBool("IsBaby",false)
                                v:EmitSound( "weapons/shrinkray/effects/evt_unshrink.wav" )
								ParticleEffectAttach( "babygun_ring_inverted", PATTACH_POINT_FOLLOW, v, 1 )
                            end
						end)
                    end
                end
			else
				if v ~= self.Owner and IsValid(v) and (v:IsNPC() or scripted_ents.GetType(v:GetClass()) == "nextbot" or v:IsPlayer()) then
					if v:IsPlayer() and !GetConVar("nz_shrinkray_shrinkplayers"):GetBool() then return end
                    if v:GetNWBool("IsBaby") ~= true and v:GetNWBool("IsBaby") ~= false then v:SetNWBool("IsBaby",false) end
                    if !v:GetNWBool("IsBaby") then
                        v:SetModelScale(0.4,0.5)
                        timer.Simple(0.25,function() 
							if IsValid(v) then
								v:EmitSound( "weapons/shrinkray/effects/evt_shrink.wav" ) 
							end
						end)
						ParticleEffectAttach( "babygun_ring", PATTACH_POINT_FOLLOW, v, 1 )
                        if v:LookupBone("ValveBiped.Bip01_Head1") ~= nil then
                            v:ManipulateBoneScale(v:LookupBone("ValveBiped.Bip01_Head1"),Vector(3.5,3.5,3.5))
                        end
                        v:SetNWBool("IsBaby",true)
                        v:SetNWBool("ShouldKickBaby",true)
                        v:SetNWBool("CanAddVelocity",true) 
						v:SetNWInt("backuphealth", v:Health())
						v:SetHealth(1)
                        v:SetNWBool("BabyOnGround",false)
						if v:IsPlayer() then
							v:SetViewOffset(Vector(0,0,25))
						end
                        timer.Simple(math.random(5,5.15),function()
                            if v:IsValid() and v:OnGround() and v:GetNWBool("IsBaby") then
                                v:SetModelScale(1,0.5)
								v:SetHealth(v:GetNWInt("backuphealth"))
                                if v:LookupBone("ValveBiped.Bip01_Head1") ~= nil then
                                    v:ManipulateBoneScale(v:LookupBone("ValveBiped.Bip01_Head1"),Vector(1,1,1))
                                end
                                v:SetNWBool("ShouldKickBaby",false)    
                                v:SetNWBool("IsBaby",false)
                                v:EmitSound( "weapons/shrinkray/effects/evt_unshrink.wav" )
								ParticleEffectAttach( "babygun_ring_inverted", PATTACH_POINT_FOLLOW, v, 1 )
								if v:IsPlayer() then
									v:SetViewOffset(Vector(0,0,64))
								end
                            end
                        end)   
                    end
                end
            end
		end
		return true
	end
	function ENT:StartTouch(ent)
		if self.Owner == ent then return end
		self:OnCollide(ent,self:GetPos())
	end
	function ENT:Think(engine)
		local ct = CurTime()
		if self.DoRemove then
			self:SetMoveType(MOVETYPE_NONE)
			self:NextThink(ct+1)
			return true
		end
		if self.LifeTime < ct then
			self:OnCollide(self,self:GetPos())
		end
		self:NextThink(ct+0.1)
		return true
	end
	function ENT:PhysicsCollide(data)
		self:OnCollide(data.HitEntity,data.HitPos)
	end
end
 function ENT:Explode()
 self:EmitSound("weapons/shrinkray/plr/wpn_shrink_plr_flux_l.wav")
 end
function Ragdoll(npc,time)
 
    local hp = npc:Health()
    local mdl = npc:GetModel()
    local skin = npc:GetSkin()
    local class = npc:GetClass()
    local wep = npc:GetActiveWeapon()
    if wep:IsValid() then wep = wep:GetClass() else wep = nil end
    local bones = {}
    for i=1,npc:GetBoneCount() do
        bones[i] = npc:GetBoneMatrix(i)
    end
   
    local rag = ents.Create("prop_ragdoll")
    rag:SetModel(mdl)
    rag:SetPos(npc:GetPos())
    rag:SetAngles(npc:GetAngles())
    npc:Remove()
   
    local tbl = {hp=hp,mdl=mdl,skin=skin,class=class,rag=rag,wep=wep}
   
    rag:Spawn()
    rag:SetSkin(skin)
   
    for k,v in pairs (bones) do
        rag:SetBoneMatrix(k,v)
    end
   
    return rag
 
end