AddCSLuaFile("shared.lua")
include('shared.lua')
 
ENT.TrailPCF = "tesla_beam_child1"
ENT.CollidePCF = "tesla_impact"
ENT.MoveSpeed = 3500
ENT.MaxChain = 10
ENT.ZAPRANGE = 150
 
local isNzombies = engine.ActiveGamemode():lower() == "nzombies"
 
function ENT:Initialize()
 
    self:SetModel("models/dav0r/hoverball.mdl")
    self:SetNoDraw(true)
    self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetSolidFlags(FSOLID_NOT_STANDABLE)
    self:SetTrigger(true)
    self:DrawShadow(false)
           
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
        phys:Wake()
        phys:SetMass(1)
        phys:EnableDrag(false)
        phys:EnableGravity(false)
        phys:SetBuoyancyRatio(0)
        phys:ApplyForceCenter(self:GetForward()*self.MoveSpeed)
    end
    self.snd = true
   
    -- we store the events here so that think can handle them
    self.touchEvents = {}
    self.targetEnts = {}
 
end
 
local blockedClasses = {
    ["prop_dynamic"] = true,
    ["nz_spawn_zombie_normal"] = true,
    ["nz_spawn_zombie_special"] = true,
    ["player_spawns"] = true,
   
}
 
function ENT:PhysSleep()
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:SetVelocity(Vector(0,0,0))
        phys:Sleep()
    end
end
 
function ENT:StartTouch(ent)
    --if !ent:Alive() then return end
 
    if blockedClasses[ent:GetClass()] ~= nil or ent == self.Owner then return end
 
    self:PhysSleep()
   
    local touchEvent = {
        ent = ent,
        pos = self:GetPos()
    }
    table.insert(self.touchEvents,touchEvent)
   
end
 
function ENT:Think()
   
    for index,touchEvent in pairs(self.touchEvents) do
        self:OnCollide(touchEvent.ent,touchEvent.pos)
        table.remove(self.touchEvents,index)
    end
   
end
 
function ENT:PhysicsCollide(data)
   
   
    self:PhysSleep()
   
    local touchEvent = {
        ent = data.HitEntity,
        pos = data.HitPos
    }
    table.insert(self.touchEvents,touchEvent)
   
end
 
-- ENT.MaxChain
function ENT:Zap(delay)
   
    timer.Simple(delay,function()
       
        if !self:IsValid() then return end
       
        -- a table containing all targetted ents
        local curIndex = #self.targetEnts
   
        local effectData = EffectData()
        effectData:SetMagnitude( 1.6 )
        effectData:SetEntity(nil)
       
        local prevEnt = self.targetEnts[curIndex]
        local targetEnt
       
        if prevEnt ~= nil and prevEnt.ent:IsValid() then
            targetEnt = self:FindNearestEntity( prevEnt.ent:GetPos() )
        else
            -- if the target ent is the initial entity of the chain
            targetEnt = self:FindNearestEntity(self:GetPos())
        end
       
        if targetEnt == nil or !targetEnt:IsValid() then return end
       
        table.insert(self.targetEnts,{ent=targetEnt,id=targetEnt:GetCreationID()})
       
        targetEnt:TakeDamageInfo( self.dmginfo )
        targetEnt:EmitSound("weapons/tesla_gun/bounce"..math.random(2)..".wav")
       
        --local raisebeam = Vector(0,0,40)
       
        if prevEnt ~= nil and prevEnt.ent:IsValid() then
            util.ParticleTracerEx( "tesla_beam", (prevEnt.ent:GetPos() + prevEnt.ent:OBBCenter()), (targetEnt:GetPos() + targetEnt:OBBCenter()), true, 1, 1 );   
        end
       
        effectData:SetOrigin(targetEnt:GetPos())
		if !targetEnt:IsPlayer() then
			util.Effect("lightning_zomzap", effectData)
		end
       
        ParticleEffectAttach( self.CollidePCF, PATTACH_ABSORIGIN_FOLLOW, targetEnt, 0)
 
    end)
   
end
 
function ENT:OnCollide(ent, pos)
	self:EmitSound("weapons/tesla_gun/proj_impact.wav")
    if isNzombies and ent.IsAlive != nil and ent:IsAlive() then return end
 
    --self.Effect:SetParent(NULL)
    SafeRemoveEntityDelayed(self.Effect,1)
    --self.Effect:Fire("Stop")
    self:SetTrigger(false)
    self:StopParticles()
    self:SetMoveType(MOVETYPE_NONE)
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    local ArcEffect = "tesla_beam"
   
    if SERVER then
       
        if !self:IsValid() or self.FindNearestEntity == nil then
            SafeRemoveEntity( self )
            return
        end
   
        local nearestent = self:FindNearestEntity(self:GetPos())
 
        local dmginfo = DamageInfo()
        --local raisebeam = Vector(0,0,40)
        dmginfo:SetDamagePosition( self:GetPos() )
        dmginfo:SetDamageType( DMG_GENERIC )
        dmginfo:SetAttacker( self.Owner )
        dmginfo:SetInflictor( self )
        dmginfo:SetDamageForce( Vector( 0, 0, 1000 ) )
        if self:GetPos():DistToSqr( self.Owner:GetPos() ) < 4096 then
            dmginfo:SetDamage(35)
            self.Owner:TakeDamageInfo(dmginfo)
        end
 
        if nearestent != nil and nearestent:IsValid() then
            dmginfo:SetDamage( nearestent:Health() )  
        else
            dmginfo:SetDamage(1000)
        end
 
        if nearestent !=nil and nearestent:IsValid() then
           
            -- expose
            self.dmginfo = dmginfo
       
            -- for initial target
            self:Zap(0,nearestent)
           
            -- the chaining targs
            for i=2,self.MaxChain do
                self:Zap(0.2*i)
            end
           
        else   
            ParticleEffect( self.CollidePCF, pos, self:GetAngles() )
            if ent:IsValid() then
                ent:TakeDamageInfo(dmginfo)
            end
            SafeRemoveEntity( self )
        end
    end
end
 
function ENT:HasPrevTarg( ent )
 
    local entID = ent:GetCreationID()
   
    for _,targ in pairs(self.targetEnts) do
        if targ.id == entID then
            return true
        end
    end
   
    return false
   
end
 
function ENT:FindNearestEntity( pos )
 
    local range = self.ZAPRANGE
    local foundEnt
 
    for _, ent in pairs( ents.FindByClass("npc_*") ) do
        local distance = pos:DistToSqr( ent:GetPos() )
 
        -- can't target ents we already targeted
        if !self:HasPrevTarg( ent ) then
            if ( distance <= range*range and distance != 0 ) then
                range = distance
                foundEnt = ent
            end
        end
       
    end
   
    if isNzombies then
        for _, ent in pairs( ents.FindByClass("nz_zombie_*") ) do
            local distance = pos:DistToSqr( ent:GetPos() )
           
            if ent == nil then return end
            if ent:IsPlayer() or ent == "drop_powerup" then continue end
           
            local distance = pos:DistToSqr( ent:GetPos() )
 
            -- can't target ents we already targetted
            if !self:HasPrevTarg( ent ) then
                if ( distance <= range*range and distance != 0 ) then
                    range = distance
                    foundEnt = ent
                end
            end
        end
    end
   
    return foundEnt
   
end