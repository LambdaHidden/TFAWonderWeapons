include("shared.lua")
language.Add( "cold_cells_ammo", "Cold Cells" )
killicon.Add( "freeze_swep", "killicon/freeze_swep", color_white )
SWEP.WepSelectIcon = surface.GetTextureID("killicon/freeze_swep.png" )
local fl_fr = false
net.Receive("FreezeSWEP",function(len)
	local uint = net.ReadUInt(1)
	if uint == 0 then
		fl_fr = net.ReadUInt(1) == 0
	elseif uint == 1 then
		local int = net.ReadUInt(16)
		int = Entity(int)
		if IsValid(int) then
			int.RemoveRagdollOnDeath = true
		end
	end
end)
hook.Add("CreateClientsideRagdoll","FreezeRagdollRemove",function(ent,rag)
	if ent.RemoveRagdollOnDeath then 
		rag:Remove()
	end
end)
hook.Add("RenderScreenspaceEffects","FreezeScreen",function()
	if !fl_fr then return end
	DrawMaterialOverlay( "HUD/freeze_screen", -0.06 )
end)
sound.Add({
	name = 			"Weapon_Freezegun.Shoot",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		"weapons/freeze_shot.wav"
})
sound.Add({
	name = 			"Weapon_Freezegun.Open",
	channel = 		CHAN_ITEM,
	volume = 		0.5,
	sound = 		"weapons/fly_freeze_open.wav"
})
sound.Add({
	name = 			"Weapon_Freezegun.Off",
	channel = 		CHAN_ITEM,
	volume = 		0.5,
	sound = 		"weapons/fly_freeze_off.wav"
})
sound.Add({
	name = 			"Weapon_Freezegun.Twist",
	channel = 		CHAN_ITEM,
	volume = 		0.5,
	sound = 		"weapons/fly_freeze_twist.wav"
})
sound.Add({
	name = 			"Weapon_Freezegun.Backon",
	channel = 		CHAN_ITEM,
	volume = 		0.5,
	sound = 		"weapons/fly_freeze_backon.wav"
})
sound.Add({
	name = 			"Weapon_Freezegun.Finish",
	channel = 		CHAN_ITEM,
	volume = 		0.5,
	sound = 		"weapons/fly_freeze_finish.wav"	
})



