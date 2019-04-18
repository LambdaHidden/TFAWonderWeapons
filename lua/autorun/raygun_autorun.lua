game.AddParticles("particles/raygun.pcf")
PrecacheParticleSystem("rgun1_impact")
PrecacheParticleSystem("rgun1_trail")
PrecacheParticleSystem("rgun1_trail_child1")

sound.Add({
	name = 			"Weapon_Raygun.Shoot",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		"weapons/raygun/raygun_shot.wav"
})
sound.Add(
{
    name = "Weapon_Raygun.Open",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 80,
    sound = "weapons/raygun/wpn_ray_reload_open.wav"
})
sound.Add(
{
    name = "Weapon_Raygun.Magout",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 80,
    sound = "weapons/raygun/wpn_ray_reload_battery_out.wav"
})
sound.Add(
{
    name = "Weapon_Raygun.Magin",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 80,
    sound = "weapons/raygun/wpn_ray_reload_battery.wav"
})
sound.Add(
{
    name = "Weapon_Raygun.Close",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 80,
    sound = "weapons/raygun/wpn_ray_reload_close.wav"
})
sound.Add(
{
    name = "Weapon_Raygun.Draw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/raygun/raygun_aquire.wav"
})


