--AddCSLuaFile("autorun/particle_additions.lua")

game.AddParticles("particles/sliquifier.pcf")
PrecacheParticleSystem("slipgun_blob")
PrecacheParticleSystem("slipgun_floorgoo")
PrecacheParticleSystem("slipgun_impact")

-- -tools -nop4

sound.Add(
{
    name = "Weapon_Slipgun.Shoot",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/slipgun/slipgun_shot_01.wav"
})
sound.Add(
{
    name = "Weapon_Slipgun.Insert",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/slipgun/slipgun_insert.wav"
})
sound.Add(
{
    name = "Weapon_Slipgun.Eject",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/slipgun/slipgun_eject.wav"
})
sound.Add(
{
    name = "Weapon_Slipgun.Ready",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/slipgun/slipgun_ready.wav"
})
sound.Add(
{
    name = "Weapon_Slipgun.Raise",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 80,
    sound = "weapons/slipgun/slipgun_raise.wav"
})