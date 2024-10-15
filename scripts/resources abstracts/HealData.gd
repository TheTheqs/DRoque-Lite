extends Resource

class_name HealData
#classe dinâmica, ela é criada para construir elementos na interface quando há cura
var healValue: float
var isMana: bool
#função construtora
func buildData(nhealValue: float, nisMana: bool) -> void:
	self.healValue = nhealValue
	self.isMana = nisMana
