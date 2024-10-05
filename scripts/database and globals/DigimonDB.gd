extends Node

class_name DigimonDB
#Dictionary With Curret Data
var digimons : Dictionary = {
	0 : load("res://resources/digimons/Agumon.tres"),
	1 : load("res://resources/digimons/Monodramon.tres"),
	2 : load("res://resources/digimons/Veemon.tres"),
	3 : load("res://resources/digimons/Guilmon.tres"),
	4 : load("res://resources/digimons/Dorumon.tres"),
	5 : load("res://resources/digimons/Betamon.tres")
}

#Database Functions
func getDigimonData(index: int) -> DigimonData:
	return digimons[index]
