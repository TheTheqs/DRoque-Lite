extends Node2D

class_name SpawnedNumber

#Elementos de cena
@export var currentNumber: RichTextLabel
@export var outTimer: Timer

#Variável de controle de posição
var limitPosition: int = 50
var currentPosition: float = 0
var velocity: float = 1.5
var moduleRatio: float = 0.016
#variável de callback
var numberSpawner: NumberSpawner

func _process(_delta):
	if(currentPosition < limitPosition):
		self.position.y -= velocity
		currentPosition += velocity
	if(self.modulate.a - moduleRatio <= 0):
		self.modulate.a = 0
	else:
		self.modulate.a -= moduleRatio
	if(self.modulate.a == 0):
		outTimer.start(0.2)
		set_process(false)

func showNumber(number: String) -> void:
	self.modulate.a = 1
	currentNumber.text = number
	set_process(true)


func outTimeOut():
	self.queue_free()
