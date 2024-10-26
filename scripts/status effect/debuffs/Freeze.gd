extends StatusEffect

class_name Freeze
#Bloco de gelo usado para simular um congelamento no digimon.
var iceBlock: Sprite2D = Sprite2D.new()
#construtora
func _init() -> void:
	self.statusId = 6
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.isExpirable = true
	self.canCount = true
	self.duration = 1
	iceBlock.texture = preload("res://assets/sprites/vfx/static effects/IceBlock.png")
	iceBlock.modulate.a = 0.2
	

func applyingEffect(digimon: Digimon) -> void:
	digimon.isDisabled = true
	digimon.digimonAnimator.play("freeze")
	digimon.call_deferred("add_child", iceBlock)

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.digimonAnimator.play("Idle")
	iceBlock.queue_free()
	digimon.isDisabled = false

func getStatus() -> StatusEffect:
	var newFreeze: Freeze = Freeze.new()
	newFreeze.schance = self.schance
	return newFreeze