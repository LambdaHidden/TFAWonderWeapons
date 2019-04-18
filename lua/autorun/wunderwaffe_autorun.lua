--AddCSLuaFile("autorun/particle_additions.lua")

game.AddParticles("particles/wunderwaffe_fx.pcf")
PrecacheParticleSystem("tesla_vm_glow")
PrecacheParticleSystem("tesla_vm_glow_pap")
PrecacheParticleSystem("tesla_beam_child1")
PrecacheParticleSystem("tesla_beam_child1_pap")
PrecacheParticleSystem("tesla_mflash")
PrecacheParticleSystem("tesla_mflash_child")
PrecacheParticleSystem("tesla_mflash_pap")
PrecacheParticleSystem("tesla_beam")
PrecacheParticleSystem("tesla_beam_b")
PrecacheParticleSystem("tesla_impact")
PrecacheParticleSystem("tesla_impact_child")
game.AddParticles("particles/lightning_trail.pcf")
PrecacheParticleSystem("lightning_trail")

-- -tools -nop4

sound.Add(
{
    name = "Weapon_WunderWaffe.FlipOff",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/tesla_gun/tesla_switch_flip_off.wav"
})
sound.Add(
{
    name = "Weapon_WunderWaffe.HandlePull",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/tesla_gun/tesla_handle_pullback.wav"
})
sound.Add(
{
    name = "Weapon_WunderWaffe.ClipIn",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/tesla_gun/tesla_clip_in.wav"
})
sound.Add(
{
    name = "Weapon_WunderWaffe.HandleRelease",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/tesla_gun/tesla_handle_release.wav"
})
sound.Add(
{
    name = "Weapon_WunderWaffe.FlipOn",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/tesla_gun/tesla_switch_flip_on.wav"
})
sound.Add({
	name = 			"Weapon_WunderWaffe.Shoot",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		"weapons/tesla_gun/tesla_fire.wav"
})