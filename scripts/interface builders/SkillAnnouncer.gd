extends Node2D

class_name SkillAnnouncer
#elementos de cena
@export var currentIcon: Sprite2D
@export var anime: AnimationPlayer
@export var changeIconTimer: Timer
#fila de ícones para exibir
var iconsToShow: Array[CompressedTexture2D]
var onShow: bool = false

func _ready() -> void:
	self.visible = false

func blinkIcon() -> void:
	changeIconTimer.stop()
	if(iconsToShow.size() > 0):
		currentIcon.texture = iconsToShow[0]
		iconsToShow.remove_at(0)
		anime.play("blink")
	else:
		print("Erro, no icon to show")

func announceSkill(icon: CompressedTexture2D) -> void:
	if(not onShow):
		iconsToShow.append(icon)
		blinkIcon()
		self.visible = true
		onShow = true
	else:
		iconsToShow.append(icon)

func changeIcon() -> void:
	if(iconsToShow.size() > 0):
		blinkIcon()
	else:
		self.visible = false
		onShow = false

func finishBlink(anim_name: String) -> void:
	if(anim_name == "blink"):
		changeIconTimer.start(1.0)
