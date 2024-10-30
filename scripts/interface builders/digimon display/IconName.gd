extends Node

class_name IconName
#elementos de cena
@export var digimonIcon: Sprite2D
@export var typeIcon: Sprite2D
@export var elementIcon: Sprite2D
@export var digimonName: Label
#convert dicks
var getElementIcon : Dictionary = {
	0 : preload("res://assets/interface/Icons/elements/neutral_dot.png"),
	1 : preload("res://assets/interface/Icons/elements/fire_dot.png"),
	2 : preload("res://assets/interface/Icons/elements/water_dot.png"),
	3 : preload("res://assets/interface/Icons/elements/plant_dot.png"),
	4 : preload("res://assets/interface/Icons/elements/thunder_dot.png"),
	5 : preload("res://assets/interface/Icons/elements/earth_dot.png"),
	6 : preload("res://assets/interface/Icons/elements/wind_dot.png"),
	7 : preload("res://assets/interface/Icons/elements/light_dot.png"),
	8 : preload("res://assets/interface/Icons/elements/darknes_dot.png"),
}
var getTypeIcon : Dictionary = {
	0 : preload("res://assets/interface/Icons/types/virus.png"),
	1 : preload("res://assets/interface/Icons/types/data.png"),
	2 : preload("res://assets/interface/Icons/types/vaccine.png"),
	3 : preload("res://assets/interface/Icons/types/free.png")
}
#função de exibição
func showContent(digimon: Digimon) -> void:
	self.digimonIcon.texture = digimon.digimonIcon
	self.elementIcon.texture = getElementIcon[digimon.element]
	self.typeIcon.texture = getTypeIcon[digimon.digimonType]
	self.digimonName.text = digimon.digimonName
