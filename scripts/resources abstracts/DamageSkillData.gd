extends Resource

class_name DamageSkillData

#Atributos de identificação
@export var skillId: int
@export var skillIcon: CompressedTexture2D

#atributos de valores e comportamento
@export var staticPriority: int
@export var element: Enums.Element
@export var damageType: Enums.DamageType
@export var damageSubType: Enums.DamageSubType
@export var ratio: float
@export var manaCost: int
@export var coolDown: int
@export var hasEffect: bool

#elementos vfx
@export var skillTexture: CompressedTexture2D
@export var textureRange: int
