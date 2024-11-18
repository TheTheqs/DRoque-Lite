extends StatusEffect

class_name Evolution
#value
var evolutionIndex: int

func _init(index: int) -> void:
	self.statusId = 41
	self.statusType = Enums.StatusType.BUFF
	self.evolutionIndex = index

func applyingEffect(digimon: Digimon) -> void:
	digimon.Evolve(digimon.possibleEvolution[self.evolutionIndex])

func getStatus() -> StatusEffect:
	return Evolution.new(self.evolutionIndex)
