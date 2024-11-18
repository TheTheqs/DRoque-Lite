extends StatusSkill
#Essa é uma pseudo habilidade, significa que ela nao vai ser usada diretamente, e sim pelo efeito secundário de outra habilidade ou trigger.
class_name Evolver
var currentIndex: int

func _init() -> void:
	self.needsAnimation = false
	self.hasAnimation = false
	statusEffects.append(Evolution.new(0))

func priorityCheck(_digimon: Digimon) -> void:
	priority = 0

func skillSingularity(_digimon: Digimon) -> void:
	self.statusEffects[0].evolutionIndex = self.currentIndex
