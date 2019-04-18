 
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
 
function ENT:Initialize()
 
    --util.SpriteTrail( self, 1, Color( 127, 255, 0 ), false, 70, 10, .4, 1 / ( 15 + 1 ) * .5, "trails/laser.vmt" )
    --util.SpriteTrail( self, 1, Color( 255, 255, 255), true, 70, 2, .4, 1 / ( 15 + 1 ) * .5, "trails/laser.vmt" )
	
	self:SetModel("models/props_lab/tpplug.mdl")
	self:SetMoveCollide(MOVECOLLIDE_FLY_CUSTOM)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_CUSTOM )
	self:SetTrigger(true)
	self:EnableCustomCollisions(true)
	self:DrawShadow(false)

	local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
		phys:SetMass(1)
        phys:EnableDrag(false)
        phys:EnableGravity(false)
        phys:SetBuoyancyRatio(0)
    end
	self.snd = true
end

function ENT:Touch(entity)
	if IsValid(self:GetOwner()) and IsValid(entity) and entity != self:GetOwner() then
		local dmginfo = DamageInfo()
		dmginfo:SetDamage(2300)
		dmginfo:SetDamageType(DMG_AIRBOAT)
		dmginfo:SetAttacker(self:GetOwner())
		dmginfo:SetInflictor(self)
		entity:TakeDamageInfo(dmginfo)
	end
end

function ENT:PhysicsCollide(data, physobj)
	self:Explode()
	self:Remove()

end
 function ENT:Explode()
 self:EmitSound("raygun_mk2/imp/imp_"..math.random(3)..".wav")
 end
