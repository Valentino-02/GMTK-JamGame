extends Node

var ParticleUp:ParticleProcessMaterial = load("res://assets/Particles/UpwardParticles.tres")
var ParticleDown:ParticleProcessMaterial = load("res://assets/Particles/UpwardParticles.tres")
var ParticleExplo:ParticleProcessMaterial = load("res://assets/Particles/ExplosionParticles.tres")

var healthUp:Texture = load("res://assets/Particles/StatParticleHealth+.png")
var healthDown:Texture = load("res://assets/Particles/StatParticleHealth-.png")
var damageUp:Texture = load("res://assets/Particles/StatParticleDmg+.png")
var damageDown:Texture = load("res://assets/Particles/StatParticleDmg-.png")
var goldUp:Texture = load("res://assets/Particles/StatParticleGold+.png")
var goldDown:Texture = load("res://assets/Particles/StatParticleGold-.png")

var dust:Texture



func play_particles(node:GPUParticles2D, type:String, up:bool=true):
	node.emitting = false
	var dir:String = "Up"
	if not up: dir = "Down"
	node.texture = get(type+dir)
	node.process_material = get("Particle"+dir)
	node.emitting = true

func play_death_particles(node:GPUParticles2D, texture=dust):
	node.process_material = ParticleExplo
	node.texture = texture
	node.emitting = true
	
