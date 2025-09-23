extends Component
class_name SlotableComponent
func _init() -> void:
	component_id = "Slotable"

## LITERALLY just tells InvSlotElements that this actor
## Is a-ok with being in an inventory slot.

@export var id:String
