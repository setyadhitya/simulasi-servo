extends Camera

export var zoom_speed = 1.5
export var rotate_speed = 0.01
export var pan_speed = 0.06

var rotating = false
var panning = false

var pivot = Vector3.ZERO

onready var pivot_node = get_parent()


func _unhandled_input(event):

	# =================================
	# MOUSE BUTTON
	# =================================
	if event is InputEventMouseButton:

		if event.button_index == BUTTON_MIDDLE:

			if event.pressed:

				# SHIFT + MIDDLE = PAN
				if Input.is_key_pressed(KEY_SHIFT):
					panning = true
					rotating = false

				# MIDDLE ONLY = ROTATE
				else:
					rotating = true
					panning = false

					update_pivot(event.position)

			else:
				rotating = false
				panning = false


		# =================================
		# ZOOM
		# =================================
		if event.button_index == BUTTON_WHEEL_UP:
			translate_object_local(Vector3(0,0,-zoom_speed))

		if event.button_index == BUTTON_WHEEL_DOWN:
			translate_object_local(Vector3(0,0,zoom_speed))



	# =================================
	# MOUSE MOVE
	# =================================
	if event is InputEventMouseMotion:

		var delta = event.relative


		# =================================
		# ROTATE
		# =================================
		if rotating:

			# ROTATE HORIZONTAL
			pivot_node.rotate_y(-delta.x * rotate_speed)

			# ROTATE VERTICAL
			pivot_node.rotate_object_local(
				transform.basis.x.normalized(),
				-delta.y * rotate_speed
			)



		# =================================
		# PAN
		# =================================
		elif panning:

			var move = (
				-transform.basis.x * delta.x +
				transform.basis.y * delta.y
			) * pan_speed

			pivot_node.translate(move)



# =================================
# UPDATE PIVOT
# =================================
func update_pivot(mouse_pos):

	var space_state = get_world().direct_space_state

	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * 1000

	var result = space_state.intersect_ray(from, to)

	if result:
		pivot = result.position
		pivot_node.global_transform.origin = pivot
