extends Spatial

onready var cam = $Camera

var rotate_sens = 0.3
var zoom_speed = 2.0
var pan_speed = 0.02

var is_rotating = false
var is_panning = false


func _input(event):

	# ====================================
	# MOUSE BUTTON
	# ====================================
	if event is InputEventMouseButton:

		# =========================
		# MIDDLE CLICK
		# =========================
		if event.button_index == BUTTON_MIDDLE:

			if event.pressed:

				# SHIFT + MIDDLE = PAN
				if Input.is_key_pressed(KEY_SHIFT):
					is_panning = true
				else:
					is_rotating = true

			else:

				is_rotating = false
				is_panning = false


		# =========================
		# ZOOM
		# =========================
		if event.pressed:

			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				cam.translate(Vector3(0, 0, -zoom_speed))

			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				cam.translate(Vector3(0, 0, zoom_speed))


	# ====================================
	# MOUSE DRAG
	# ====================================
	if event is InputEventMouseMotion:

		# =========================
		# ROTATE
		# =========================
		if is_rotating:

			rotation_degrees.y -= event.relative.x * rotate_sens
			rotation_degrees.x -= event.relative.y * rotate_sens


		# =========================
		# PAN
		# =========================
		if is_panning:

			translation += -transform.basis.x * event.relative.x * pan_speed
			translation += transform.basis.y * event.relative.y * pan_speed
