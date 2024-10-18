extends Node2D

class_name SpawnedNumber

#Elementos de cena
@export var currentNumber: RichTextLabel
@export var outTimer: Timer

#Variável de controle de posição
var limitPosition: int = 60
var currentPosition: int = 0
var velocity: int = 2
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

func showNumber(number: String, nnumber: NumberSpawner) -> void:
	self.numberSpawner = nnumber
	self.modulate.a = 1
	currentNumber.text = number
	set_process(true)


func outTimeOut():
	numberSpawner.sweepQueue()
	self.queue_free()
