extends Node2D

class_name StatusEffect
#identificação
var statusId: int
var statusName: String
var statusIcon: CompressedTexture2D
var statusDescription: String
var statusType: Enums.StatusType

#stacks e persistência
var isExpirable: bool = false
var canCount: bool = false
var duration: int
var isStackable: bool = false
var schance: float
var stacks: int
var stacksLimit: int
var isPersistent: bool = false

#triggers
var statusTriggers: Array[Trigger]

#funções abstratas, obrigatóriamente devem ser sobreescritas
func applyingEffect(_digimon: Digimon) -> void:
	pass

func unapplyingEffect(_digimon: Digimon) -> void:
	pass
#função chamada quando o efeito ja está aplicado e precisa ser sobreposto
func effectOverlap(_digimon: Digimon) -> void:
	pass

func calculateChance(digimon: Digimon) -> void:
	schance = digimon.getAccuracy(self, digimon.enemy)

func getStatus() -> StatusEffect:
	return self

func setStats() -> void:
	self.statusName = "StatusName" + str(self.statusId)
	self.statusDescription = "StatusDescription" + str(self.statusId)
