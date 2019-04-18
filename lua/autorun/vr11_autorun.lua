game.AddParticles("particles/humangun.pcf")
	PrecacheParticleSystem("vrill_smoke")
	PrecacheParticleSystem("vrill_human_aura")
game.AddParticles("particles/neuro_gore.pcf")
	PrecacheParticleSystem("tank_gore")
game.AddParticles("particles/electric_arc.pcf")
	PrecacheParticleSystem("electric_arc_base")
game.AddParticles("particles/vr11_impact.pcf")
	PrecacheParticleSystem("vr11_impact_base")

sound.Add(
{
    name = "Weapon_VR11.ArmClose",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/humangun/foley/hg_arm_close.wav"
})
sound.Add(
{
    name = "Weapon_VR11.ArmOpen",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/humangun/foley/hg_arm_open.wav"
})
sound.Add(
{
    name = "Weapon_VR11.BatteryClose",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/humangun/foley/hg_battery_close.wav"
})
sound.Add(
{
    name = "Weapon_VR11.BatteryEject",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/humangun/foley/hg_battery_eject.wav"
})
sound.Add(
{
    name = "Weapon_VR11.BatteryInsert",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/humangun/foley/hg_battery_insert.wav"
})
sound.Add(
{
    name = "Weapon_VR11.BatteryOpen",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/humangun/foley/hg_battery_Open.wav"
})
sound.Add(
{
    name = "Weapon_VR11.Raise",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/humangun/raise_spinner.mp3"
})
sound.Add({
	name = 			"Weapon_VR11.Shoot",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		"weapons/humangun/vr11_shoot.mp3"
})

