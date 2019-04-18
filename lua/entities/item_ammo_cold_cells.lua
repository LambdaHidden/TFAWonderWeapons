AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Nuke"
ENT.Spawnable = false
ENT.Category = "Other"
ENT.Model = Model( "models/coldcells.mdl" )

function ENT:Initialize()
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetSolid( SOLID_BBOX )
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
	if SERVER then
		self:SetTrigger(true)
		self:SetUseType(SIMPLE_USE)
	end
	self.used = false
end

function ENT:SpawnFunction(ply,tr)
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create("item_ammo_cold_cells")
	ent:SetPos(SpawnPos+Vector(0,0,3))
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Touch(ent)
	if SERVER then
		if !self.used and (IsValid(ent) and ent:IsPlayer()) then
			local ammo = ent:GetAmmoCount(ammotype)
			if 9999 >=ammo + 6 then
				ent:GiveAmmo( 6, ammotype)
				self.used = true
				self:Remove()
			end
		end
	end
end

function ENT:Use(ent)
	self:Touch(ent)
end