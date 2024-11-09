extends Node

class_name DigimonDB
#Dictionary With Curret Data
var digimons : Dictionary = {
	0 : "res://resources/digimons/Agumon.tres",
	1 : "res://resources/digimons/Monodramon.tres",
	2 : "res://resources/digimons/Veemon.tres",
	3 : "res://resources/digimons/Guilmon.tres",
	4 : "res://resources/digimons/Dorumon.tres",
	5 : "res://resources/digimons/Betamon.tres",
}

#Database Functions
func getDigimonData(index: int) -> DigimonData:
	return load(digimons[index])
