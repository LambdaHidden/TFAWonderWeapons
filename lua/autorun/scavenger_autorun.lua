game.AddParticles("particles/scavenger.pcf")
	PrecacheParticleSystem("ubersniper_explosion_base")
	PrecacheParticleSystem("ubersniper_victim_redmist")
game.AddParticles("particles/neuro_gore.pcf")
	PrecacheParticleSystem("tank_gore")


sound.Add(
{
    name = "Weapon_Scavenger.MagOut",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/mag_out.mp3"
})
sound.Add(
{
    name = "Weapon_Scavenger.MagIn",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/mag_in.mp3"
})
sound.Add(
{
    name = "Weapon_Scavenger.Beep",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/beep_onfullyreloaded.mp3"
})
sound.Add(
{
    name = "Weapon_Scavenger.BoltBack",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/bolt_back.mp3"
})
sound.Add(
{
    name = "Weapon_Scavenger.BoltForward",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/bolt_forward.mp3"
})
sound.Add({
	name = 			"Weapon_Scavenger.Shoot",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		"weapons/scavenger_shot.mp3"
})