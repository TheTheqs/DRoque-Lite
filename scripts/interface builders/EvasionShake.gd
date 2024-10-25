extends Node2D

class_name EvasionShake
#classe que vai provocar o efeito de vibração quando o status entra em ação.
var digimonSprite: Sprite2D
#variáveis de controle de tempo
var shakeIntensity: float = 2.0

func startEffect(newSprite: Sprite2D) -> void:
	digimonSprite = newSprite
	set_process(true)

func endEffect() -> void:
	set_process(false)
	digimonSprite.position.x = 0
	digimonSprite.position.y = 0
	self.queue_free()

#função que faz o digimon tremer
func applyTrembleEffect(_delta: float) -> void:
	#tremor
	digimonSprite.position.x += shakeIntensity
	shakeIntensity *= -1

func _process(delta: float) -> void:
	applyTrembleEffect(delta)
