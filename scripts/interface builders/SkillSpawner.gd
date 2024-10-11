extends Node2D

class_name SkillSpawner
#skill recebida
var currentSkill: Skill
#elementos de cena
@export var relatedDigimon: Digimon
@export var skillSprite: Sprite2D
@export var animator: AnimationPlayer

func _ready():
	self.visible = false
	if(relatedDigimon.tamer is Player):
		skillSprite.flip_h = true

func spawSkill(skill: Skill) -> void:
	relatedDigimon.BTM.inAction()
	currentSkill = skill
	skillSprite.texture = skill.texture
	skillSprite.hframes = skill.textureRange
	var animationCommand: String = "action" + str(skill.textureRange)
	self.visible = true
	animator.play(animationCommand)

func _onAnimationFinished(anim_name):
	self.visible = false
	if("action" in anim_name):
		relatedDigimon.gotTargeted(currentSkill)
	relatedDigimon.BTM.outAction("Skill Spawner")
