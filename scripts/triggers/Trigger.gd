extends Node

class_name Trigger
#preencher com atributos de identificação
var action: Skill
var triggerId: int
#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(_digimon: Digimon, _context) -> bool:
	return false

func triggerValidation(digimon: Digimon, context) -> void:
	if(checkContext(digimon, context)):
		digimon.actionsToGo.append(action)
#Funciona assim. Quando o trigger ativa e ele tem uma ação intrínsica, essa ação é posta em fila do digimon.
#quando não há ação (entenda ação por uma animação necessária, seja de dano tomado etc), o efeito é ativado no próprio checkContext
