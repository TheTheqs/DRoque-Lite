extends Node2D

class_name EvasionShake
#classe que vai provocar o efeito de vibração quando o status entra em ação.
var digimonSprite: Sprite2D
#variáveis de controle de tempo
var timePassed: float = 0.0
var frequency: float = 1.0  #frequência do tremeluzir (quantas vezes por segundo)
var shakeIntensity: float = 2.0
var minAlpha: float = 0.2 #mínimo de transparência
var maxAlpha: float = 0.9  #transparência máxima 
#limite em tela

func startEffect(newSprite: Sprite2D) -> void:
	digimonSprite = newSprite
	set_process(true)

func endEffect() -> void:
	digimonSprite.position.x = 0
	digimonSprite.position.y = 0
	digimonSprite.modulate.a = 1.0
	set_process(false)
	self.queue_free()

#função que faz o digimon tremer
func applyTrembleEffect(delta: float) -> void:
	self.timePassed += delta * self.frequency
	#tremor
	digimonSprite.position.x += shakeIntensity
	shakeIntensity *= -1
	#transparência
	var alpha = lerp(minAlpha, maxAlpha, 0.5 * (1 + sin(timePassed * PI)))
	digimonSprite.modulate.a = alpha

func _process(delta: float) -> void:
	applyTrembleEffect(delta)
