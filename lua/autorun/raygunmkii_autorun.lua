game.AddParticles("particles/raygun2_trail.pcf")
PrecacheParticleSystem("rgun2_trail")
PrecacheParticleSystem("rgun2_trail_pap")

sound.Add({
	name = 			"Weapon_Raygun2.Shoot",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		"raygun_mk2/shot/shot1.wav"
})

sound.Add(
{
    name = "Weapon_Raygun2.Raise",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 80,
    sound = "raygun_mk2/reload/raise.wav"
})
sound.Add(
{
    name = "Weapon_Raygun2.Switch",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 80,
    sound = "raygun_mk2/reload/switch.wav"
})
sound.Add(
{
    name = "Weapon_Raygun2.Magin",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 80,
    sound = "raygun_mk2/reload/putin.wav"
})
sound.Add(
{
    name = "Weapon_Raygun2.Magout",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 80,
    sound = "raygun_mk2/reload/pullout.wav"
})



