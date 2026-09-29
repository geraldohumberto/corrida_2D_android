extends Node2D

const TRACK_OUTER := Rect2(120, 90, 1760, 1020)
const TRACK_INNER := Rect2(560, 355, 880, 490)
const START_POSITION := Vector2(335, 925)

var car: RaceCar
var lap_label: Label
var time_label: Label
var message_label: Label
var race_time := 0.0
var lap := 0
var checkpoint := 0
var finished := false

func _ready() -> void:
	create_track_collisions()
	create_car()
	create_interface()
	queue_redraw()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		restart_race()
	if not finished:
		race_time += delta
		time_label.text = "TEMPO  %02d:%05.2f" % [int(race_time) / 60, fmod(race_time, 60.0)]

func create_car() -> void:
	car = RaceCar.new()
	car.name = "Jogador"
	car.position = START_POSITION
	var shape := CollisionShape2D.new()
	var capsule := CapsuleShape2D.new()
	capsule.radius = 14.0
	capsule.height = 48.0
	shape.shape = capsule
	shape.rotation = PI / 2.0
	car.add_child(shape)
	add_child(car)
	car.position_changed.connect(check_progress)
	car.keyboard_event_received.connect(show_keyboard_diagnostic)
	var camera := Camera2D.new()
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 7.0
	camera.zoom = Vector2(0.68, 0.68)
	car.add_child(camera)

func create_track_collisions() -> void:
	add_wall(Vector2(1000, 65), Vector2(1840, 50))
	add_wall(Vector2(1000, 1135), Vector2(1840, 50))
	add_wall(Vector2(95, 600), Vector2(50, 1120))
	add_wall(Vector2(1905, 600), Vector2(50, 1120))
	add_wall(Vector2(1000, 330), Vector2(930, 50))
	add_wall(Vector2(1000, 870), Vector2(930, 50))
	add_wall(Vector2(535, 600), Vector2(50, 590))
	add_wall(Vector2(1465, 600), Vector2(50, 590))

func add_wall(center: Vector2, size: Vector2) -> void:
	var wall := StaticBody2D.new()
	wall.position = center
	var collision := CollisionShape2D.new()
	var rectangle := RectangleShape2D.new()
	rectangle.size = size
	collision.shape = rectangle
	wall.add_child(collision)
	add_child(wall)

func create_interface() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var ui := Control.new()
	ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layer.add_child(ui)
	lap_label = make_label("VOLTA  1 / 3", 28)
	lap_label.position = Vector2(28, 22)
	ui.add_child(lap_label)
	time_label = make_label("TEMPO  00:00.00", 28)
	time_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	time_label.position = Vector2(650, 22)
	time_label.size = Vector2(282, 40)
	ui.add_child(time_label)
	message_label = make_label("COMPLETE 3 VOLTAS", 22)
	message_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	message_label.position = Vector2(300, 70)
	message_label.size = Vector2(360, 34)
	ui.add_child(message_label)
	create_touch_button(ui, "◀", Vector2(28, 420), "left")
	create_touch_button(ui, "▶", Vector2(138, 420), "right")
	create_touch_button(ui, "▲", Vector2(792, 420), "accelerate")
	create_touch_button(ui, "▼", Vector2(682, 420), "brake")
	var restart := Button.new()
	restart.text = "REINICIAR"
	restart.position = Vector2(390, 485)
	restart.size = Vector2(180, 42)
	restart.pressed.connect(restart_race)
	ui.add_child(restart)

func make_label(text_value: String, font_size: int) -> Label:
	var label := Label.new()
	label.text = text_value
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", Color("fff4c2"))
	label.add_theme_color_override("font_outline_color", Color("191b23"))
	label.add_theme_constant_override("outline_size", 6)
	return label

func create_touch_button(parent: Control, caption: String, pos: Vector2, action: String) -> void:
	var button := Button.new()
	button.text = caption
	button.position = pos
	button.size = Vector2(94, 94)
	button.modulate = Color(1, 1, 1, 0.72)
	button.add_theme_font_size_override("font_size", 36)
	button.button_down.connect(func(): car.virtual_input[action] = true)
	button.button_up.connect(func(): car.virtual_input[action] = false)
	parent.add_child(button)

func show_keyboard_diagnostic(details: String) -> void:
	message_label.text = details

func check_progress(world_position: Vector2) -> void:
	if finished:
		return
	# Checkpoints em ordem anti-horária; evita ganhar voltas ao cruzar só a linha inicial.
	if checkpoint == 0 and world_position.x > 1650 and world_position.y > 700:
		checkpoint = 1
	elif checkpoint == 1 and world_position.x > 1450 and world_position.y < 240:
		checkpoint = 2
	elif checkpoint == 2 and world_position.x < 330 and world_position.y < 430:
		checkpoint = 3
	elif checkpoint == 3 and world_position.x < 430 and world_position.y > 800:
		lap += 1
		checkpoint = 0
		lap_label.text = "VOLTA  %d / 3" % min(lap + 1, 3)
		if lap >= 3:
			finished = true
			message_label.text = "CORRIDA CONCLUÍDA!  %s" % time_label.text
		else:
			message_label.text = "VOLTA %d COMPLETA" % lap

func restart_race() -> void:
	car.position = START_POSITION
	car.rotation = 0.0
	car.drive_speed = 0.0
	race_time = 0.0
	lap = 0
	checkpoint = 0
	finished = false
	lap_label.text = "VOLTA  1 / 3"
	message_label.text = "COMPLETE 3 VOLTAS"

func _draw() -> void:
	draw_rect(Rect2(0, 0, 2000, 1200), Color("5c4032"))
	draw_rect(TRACK_OUTER, Color("2b303b"))
	draw_rect(TRACK_OUTER.grow(-26), Color("3b4350"))
	draw_rect(TRACK_INNER, Color("6c4a35"))
	draw_rect(TRACK_INNER.grow(25), Color("2b303b"), false, 18.0)
	for y in range(850, 1010, 24):
		for x in range(410, 458, 24):
			draw_rect(Rect2(x, y, 12, 12), Color("f7e7b0") if (x + y) % 48 == 0 else Color("252a33"))
	for x in range(210, 520, 55):
		draw_rect(Rect2(x, 720, 30, 7), Color("d6a23d"))
	for x in range(1480, 1780, 55):
		draw_rect(Rect2(x, 720, 30, 7), Color("d6a23d"))
