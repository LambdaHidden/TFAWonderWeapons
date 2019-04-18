game.AddParticles("particles/jet_muzzle.pcf")
PrecacheParticleSystem("jet_muzzle")

sound.Add(
{
    name = "Weapon_Jetgun.draw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/fly_minigun_on.wav"
})
sound.Add(
{
    name = "Weapon_Jetgun.shoot",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/jetgun_shoot.wav"
})

if CLIENT then return end
local class = "weapon_jetgun"
hook.Add("PlayerCanPickupWeapon","PreventAmmoPickuping",function(ply,wep)
	if wep:GetClass() == class and ply:HasWeapon(class) then
		return false
	end
end)