extends StatusEffect

class_name Evade
#elementos para serem introduzidos na Cena
var shakeAnimationScene: PackedScene = preload("res://scenes/entities/EvasionShake.tscn")
var shakeInstance: EvasionShake = null

func _init() -> void:
	self.statusId = 19
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.statusTriggers.append(EvadeTrigger.new(self))

func applyingEffect(digimon: Digimon) -> void:
	digimon.onGotHited.append(statusTriggers[0])
	shakeInstance = shakeAnimationScene.instantiate()
	digimon.call_deferred("add_child", shakeInstance)
	digimon.digimonSprite.modulate.a = 0.6
	shakeInstance.startEffect(digimon.digimonSprite)
	

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.digimonSprite.modulate.a = 1.0
	digimon.onGotHited.erase(statusTriggers[0])
	if shakeInstance != null and shakeInstance.is_inside_tree():
		shakeInstance.queue_free()

func getStatus() -> StatusEffect:
	return Evade.new()
