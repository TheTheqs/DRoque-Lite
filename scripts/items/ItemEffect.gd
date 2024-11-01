extends Node

class_name ItemEffect
#classe básica, feita apenas para modularizar os itens e evitar repetição de códigos e linhas
#ela apenas comprime o efeito de um item

#função para ser sobrescrita
func itemEffect(_digimon: Digimon) -> void:
	pass

func priorityCalc(_digimon: Digimon) -> int:
	return 0
