class_name RaceCar
extends CharacterBody2D

signal position_changed(world_position: Vector2)
signal keyboard_event_received(details: String)

const MAX_FORWARD_SPEED := 520.0
const MAX_REVERSE_SPEED := 170.0
const ACCELERATION := 470.0
const BRAKE_POWER := 720.0
const ROLLING_DRAG := 170.0
const TURN_SPEED := 2.9

var drive_speed := 0.0
var virtual_input := {"left": false, "right": false, "accelerate": false, "brake": false}
var android_keyboard_input := {"left": false, "right": false, "accelerate": false, "brake": false}

func _ready() -> void:
	# O Windows envia teclas fisicas; Android/emuladores podem enviar keycodes logicos.
	# Registramos ambos para manter teclado utilizavel nas duas plataformas.
	add_keycode_binding("accelerate", KEY_W)
	add_keycode_binding("accelerate", KEY_UP)
	add_keycode_binding("brake", KEY_S)
	add_keycode_binding("brake", KEY_DOWN)
	add_keycode_binding("turn_left", KEY_A)
	add_keycode_binding("turn_left", KEY_LEFT)
	add_keycode_binding("turn_right", KEY_D)
	add_keycode_binding("turn_right", KEY_RIGHT)
	add_keycode_binding("restart", KEY_R)
	queue_redraw()

func add_keycode_binding(action: StringName, keycode: Key) -> void:
	var key_event := InputEventKey.new()
	key_event.keycode = keycode
	InputMap.action_add_event(action, key_event)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			keyboard_event_received.emit("TECLA  code:%d  fisica:%d  unicode:%d" % [event.keycode, event.physical_keycode, event.unicode])
		var action := get_android_keyboard_action(event)
		if not action.is_empty():
			android_keyboard_input[action] = event.pressed
			if event.pressed:
				Input.action_press(action)
			else:
				Input.action_release(action)

func get_android_keyboard_action(event: InputEventKey) -> String:
	# Alguns teclados Android enviam letras como unicode, em vez de keycode.
	# Tratamos ambos os formatos e preservamos as setas como alternativa.
	if event.keycode == KEY_W or event.physical_keycode == KEY_W or event.unicode == 119 or event.keycode == KEY_UP:
		return "accelerate"
	if event.keycode == KEY_S or event.physical_keycode == KEY_S or event.unicode == 115 or event.keycode == KEY_DOWN:
		return "brake"
	if event.keycode == KEY_A or event.physical_keycode == KEY_A or event.unicode == 97 or event.keycode == KEY_LEFT:
		return "left"
	if event.keycode == KEY_D or event.physical_keycode == KEY_D or event.unicode == 100 or event.keycode == KEY_RIGHT:
		return "right"
	return ""

func _physics_process(delta: float) -> void:
	var forward_pressed: bool = Input.is_action_pressed("accelerate") or Input.is_key_pressed(KEY_W) or virtual_input.accelerate or android_keyboard_input.accelerate
	var brake_pressed: bool = Input.is_action_pressed("brake") or Input.is_key_pressed(KEY_S) or virtual_input.brake or android_keyboard_input.brake
	var steer := Input.get_axis("turn_left", "turn_right")
	if Input.is_key_pressed(KEY_A) or virtual_input.left or android_keyboard_input.left:
		steer -= 1.0
	if Input.is_key_pressed(KEY_D) or virtual_input.right or android_keyboard_input.right:
		steer += 1.0
	if forward_pressed:
		drive_speed = move_toward(drive_speed, MAX_FORWARD_SPEED, ACCELERATION * delta)
	elif brake_pressed:
		if drive_speed > 0.0:
			drive_speed = move_toward(drive_speed, 0.0, BRAKE_POWER * delta)
		else:
			drive_speed = move_toward(drive_speed, -MAX_REVERSE_SPEED, ACCELERATION * delta)
	else:
		drive_speed = move_toward(drive_speed, 0.0, ROLLING_DRAG * delta)
	var traction: float = clampf(abs(drive_speed) / MAX_FORWARD_SPEED, 0.16, 1.0)
	rotation += steer * TURN_SPEED * traction * sign(drive_speed if drive_speed != 0.0 else 1.0) * delta
	velocity = Vector2.RIGHT.rotated(rotation) * drive_speed
	move_and_slide()
	if get_slide_collision_count() > 0:
		drive_speed *= 0.72
	position_changed.emit(global_position)

func _draw() -> void:
	draw_colored_polygon(PackedVector2Array([Vector2(25, 0), Vector2(8, -15), Vector2(-20, -13), Vector2(-25, 0), Vector2(-20, 13), Vector2(8, 15)]), Color("d94b4b"))
	draw_rect(Rect2(-7, -10, 17, 20), Color("ffd166"), false, 3.0)
	draw_rect(Rect2(-17, -18, 9, 7), Color("20232e"))
	draw_rect(Rect2(-17, 11, 9, 7), Color("20232e"))
	draw_circle(Vector2(17, 0), 4.0, Color("fff4c2"))
