extends Node2D

class_name KarmaDisplay
#Elementos de cena
@export var karmText: RichTextLabel
#dicionários
var outlineColors: Dictionary = {
	0 : "fe0000",
	1 : "008300",
	2 : "ffde00",
	3 : "64a5ff",
	4 : "0163c6",
	5 : "ffff3a",
	6 : "a5a5a5",
	7 : "943a3a",
	8 : "5b315b",
	9 : "51ff00",
	10 : "525252",
	11 : "ff4200",
}
var karmaTitle: Dictionary = {
	0 : "Karma0",
	1 : "Karma1",
	2 : "Karma2",
	3 : "Karma3",
	4 : "Karma4",
	5 : "Karma5",
	6 : "Karma6",
	7 : "Karma7",
	8 : "Karma8",
	9 : "Karma9",
	10 : "Karma10",
	11 : "Karma11",
}

func editText(playerKarma: Enums.Karma):
	var karma: String = tr(StringName(karmaTitle[playerKarma]))
	var outlineColor: String = "#" + outlineColors[playerKarma]
	karmText.text = "[center][color="+ outlineColor +"]" + karma + "[/color][/center]"
