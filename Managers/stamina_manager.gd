extends Node

# These 2 variables are what you need to change to change the number of
#dash charges and the refill rate. Nothing else should change in the script
var max_charges: float = 3.0
var refill_rate: float = 1.0

var max_charge_bar: float
var curr_charge_bar: float
var max_refill_bar: float
var curr_refill_bar: float

func _ready() -> void:
	max_charge_bar = max_charges
	curr_charge_bar = max_charge_bar
	max_refill_bar = max_charges * 100.0
	curr_refill_bar = max_refill_bar

func _physics_process(delta: float) -> void:
	# if refill is less than max, replenish
	if curr_refill_bar < max_refill_bar:
		curr_refill_bar += refill_rate
	
	# clamping of refill bar
	if curr_refill_bar > max_refill_bar:
		curr_refill_bar = max_refill_bar
	if curr_refill_bar < 0:
		curr_refill_bar = 0
	
	# setting charge bar based on refill bar
	curr_charge_bar = floor(curr_refill_bar/100.0)

func has_charge() -> bool:
	return curr_charge_bar > 0

func use_charge() -> void:
	if has_charge():
		curr_refill_bar -= 100
