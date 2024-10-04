extends Node

class_name DigimonDB
#Dictionary With Curret Data
var digimons : Dictionary = {
	0 : preload("res://resources/digimons/Agumon.tres"),
	1 : preload("res://resources/digimons/Monodramon.tres"),
	2 : preload("res://resources/digimons/Veemon.tres"),
	3 : preload("res://resources/digimons/Guilmon.tres"),
	4 : preload("res://resources/digimons/Dorumon.tres"),
	5 : preload("res://resources/digimons/Betamon.tres")
}

#Database Functions
func getDigimonData(index: int) -> DigimonData:
	return digimons[index]
