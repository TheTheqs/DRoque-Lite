extends Node2D

class_name SkillSpawner
#skill recebida
var currentSkill: Skill
var exchangeTexture: CompressedTexture2D = preload("res://assets/sprites/vfx/special effects/ExchangeAnimation.png")
#elementos de cena
@export var relatedDigimon: Digimon
@export var skillSprite: Sprite2D
@export var animator: AnimationPlayer

func _ready():
	self.visible = false
	if(relatedDigimon.tamer is Player):
		skillSprite.flip_h = true

func spawSkill(skill: Skill) -> void:
	skillSprite.hframes = skill.textureRange
	skillSprite.vframes = 1
	relatedDigimon.BTM.inAction()
	currentSkill = skill
	skillSprite.texture = skill.texture
	var animationCommand: String = "action" + str(skill.textureRange)
	#manipulação do speed scale para algumas habilidade que ficam melhores quando lentas
	if(skill.isSlow):
		animator.speed_scale = 1.0
	else:
		animator.speed_scale = 2.0
	animator.play(animationCommand)
	self.visible = true

func _onAnimationFinished(anim_name: String) -> void:
	self.visible = false
	skillSprite.hframes = 1
	if("action" in anim_name):
		relatedDigimon.gotTargeted(currentSkill)
	relatedDigimon.BTM.outAction("Skill Spawner")

func exchangeAnimation() -> void:
	relatedDigimon.BTM.inAction()
	self.skillSprite.texture = self.exchangeTexture
	self.skillSprite.hframes = 5
	self.skillSprite.vframes = 4
	self.visible = true
	self.animator.play("Exchange")
