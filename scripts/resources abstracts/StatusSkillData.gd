extends Resource

class_name StatusSkillData

#Atributos de identificação
@export var skillId: int
@export var skillIcon: CompressedTexture2D

#atributos de valores e comportamento
@export var staticPriority: int
@export var manaCost: int
@export var coolDown: int

#elementos vfx
@export var skillTexture: CompressedTexture2D
@export var textureRange: int
