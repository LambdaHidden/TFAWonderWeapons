game.AddParticles("particles/thundergun_smokering.pcf")
	PrecacheParticleSystem("smoke_base")


sound.Add(
{
    name = "Weapon_Thundergun.Eject",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "thundergun/fly_thundergun_eject.wav"
})
sound.Add(
{
    name = "Weapon_Thundergun.Lock",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "thundergun/fly_thundergun_cell_slide_lock.wav"
})
sound.Add(
{
    name = "Weapon_Thundergun.Replace",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "thundergun/fly_thundergun_cell_replace.wav"
})

sound.Add(
{
    name = "Weapon_Thundergun.SwitchOn",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "thundergun/fly_thundergun_cell_on.wav"
})
sound.Add({
	name = 			"Weapon_Thundergun.Shoot",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		"thundergun/fly_thundergun_shoot.wav"
})