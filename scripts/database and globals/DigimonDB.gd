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
	86: "res://resources/digimons/Greymon.tres"
}

#Database Functions
func getDigimonData(index: int) -> DigimonData: #sempre bom lembrar que ese index é o ID do digimon!!!!
	return load(digimons[index])
