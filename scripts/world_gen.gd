extends Node2D

@export var Height = 600
@export var Width = 500

#set up the random number genrator
var rng = RandomNumberGenerator.new()
#create genraters for the alt heat and other
var altitude_noise = FastNoiseLite.new()
var heat_noise = FastNoiseLite.new()
var humidity_noise = FastNoiseLite.new()
var soilcomp_noise = FastNoiseLite.new()

func _ready() -> void:
	altitude_noise.seed = rng.randi()
	heat_noise.seed = rng.randi()
	humidity_noise.seed = rng.randi()
	soilcomp_noise.seed = rng.randi()
	
	altitude_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	heat_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	humidity_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	soilcomp_noise.noise_type = FastNoiseLite.TYPE_PERLIN

#this is infiuced by are "starting location"
#are  "starting location" is teh place on eart were we are
# so for exaple rusha is very cold so we would have a lower base heat
#however we would still be able to change that to get more interesting biomes

#value that can be from 1 to -1 (genrated on a bell curve) so it does not infulce too much
var base_heat = clampf(rng.randfn(0.0, 0.15), -1.0, 1.0)
var base_altiude = clampf(rng.randfn(0.0, 0.15), -1.0, 1.0)
var base_humidity  = clampf(rng.randfn(0.0, 0.15), -1.0, 1.0)

func get_altitude(x: float, y: float) -> float:
	return clampf(
		(altitude_noise.get_noise_2d(x, y) + base_altiude)/2,
		-1.0, 1.0
	)


func get_heat(x: float, y: float) -> float:
	return clampf(
		(heat_noise.get_noise_2d(x, y) + base_heat)/2,
		-1.0, 1.0
	)


func get_humidity(x: float, y: float) -> float:
	return clampf(
		(humidity_noise.get_noise_2d(x, y) + base_humidity)/2,
		-1.0, 1.0
	)

func get_soilcomp(x: float,y: float) -> float:
	return clampf(
		soilcomp_noise.get_noise_2d(x, y),
		-1.0, 1.0
	)
