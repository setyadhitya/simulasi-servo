extends Spatial

onready var servo = $Objek/servolengan
onready var updown = $Objek/updown

var busy = false

var servo_awal
var updown_awal

var current_plate = -1

var alas = {}

# =====================================================
# DATA SPOT
# =====================================================

var spot_data = {
	1: {"z": -11, "extra": 0},
	2: {"z": 11, "extra": 0},

	3: {"z": -11, "extra": 6},
	4: {"z": 11, "extra": 6},

	5: {"z": -11, "extra": 12},
	6: {"z": 11, "extra": 12},

	7: {"z": -11, "extra": 18},
	8: {"z": 11, "extra": 18},

	9: {"z": -11, "extra": 24},
	10: {"z": 11, "extra": 24},
}


func _ready():

	servo_awal = servo.translation
	updown_awal = updown.translation

	for i in range(1, 11):
		alas[i] = get_node("Objek/alasmobil" + str(i))


# =====================================================
# AMBIL MOBIL
# =====================================================

func move_to_plate(index):

	if busy:
		return

	if current_plate != -1:
		return

	busy = true
	current_plate = index

	var tween = Tween.new()
	add_child(tween)

	var plate = alas[index]

	var arah_z = spot_data[index]["z"]
	var extra = spot_data[index]["extra"]

	var alas_awal = plate.translation
	# naik lift sesuai lantai
	var servo_lantai = servo_awal + Vector3(0, extra, 0)
	var updown_lantai = updown_awal + Vector3(0, extra, 0)
	# =================================================
	# POSISI
	# =================================================

	# STEP 1
	# STEP 1
	var servo_samping = servo_lantai + Vector3(0, 0, arah_z)

	# STEP 2
	var servo_naik = servo_samping + Vector3(0, 0.3, 0)
	var updown_naik = updown_awal + Vector3(0, 0.3, 0)
	var alas_naik = alas_awal + Vector3(0, 0.3, 0)

	# STEP 3
	var servo_tengah = servo_naik + Vector3(0, 0, -arah_z)
	var alas_tengah = alas_naik + Vector3(0, 0, -arah_z)

	# STEP 4
	var servo_standby = servo_lantai

	var updown_standby = updown_lantai
	var alas_standby = alas_tengah + Vector3(0, -0.3, 0)

	# STEP 5
	var servo_bawah = servo_standby + Vector3(0, -14 - extra, 0)
	var updown_bawah = updown_standby + Vector3(0, -14 - extra, 0)
	var alas_bawah = alas_standby + Vector3(0, -14 - extra, 0)

	# STEP 6
	var alas_keluar = alas_bawah + Vector3(-14, 0, 0)

# =================================================
# STEP 1 — NAIK KE LANTAI
# =================================================

	tween.interpolate_property(
	servo,
	"translation",
	servo.translation,
	servo_lantai,
	1,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	0
)

	tween.interpolate_property(
	updown,
	"translation",
	updown.translation,
	updown_lantai,
	1,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	0
)

# =================================================
# STEP 2 — GESER KE SAMPING
# =================================================

	tween.interpolate_property(
	servo,
	"translation",
	servo_lantai,
	servo_samping,
	1,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	1
)

# =================================================
# STEP 3 — ANGKAT PLATE
# =================================================

	tween.interpolate_property(
	servo,
	"translation",
	servo_samping,
	servo_naik,
	0.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	2
)

	tween.interpolate_property(
	updown,
	"translation",
	updown_lantai,
	updown_naik,
	0.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	2
)

	tween.interpolate_property(
	plate,
	"translation",
	alas_awal,
	alas_naik,
	0.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	2
)

# =================================================
# STEP 4 — TARIK KE TENGAH
# =================================================

	tween.interpolate_property(
	servo,
	"translation",
	servo_naik,
	servo_tengah,
	1.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	2.5
)

	tween.interpolate_property(
	plate,
	"translation",
	alas_naik,
	alas_tengah,
	1.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	2.5
)

# =================================================
# STEP 5 — TURUN STANDBY
# =================================================

	tween.interpolate_property(
	servo,
	"translation",
	servo_tengah,
	servo_standby,
	0.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4
)

	tween.interpolate_property(
	updown,
	"translation",
	updown_naik,
	updown_standby,
	0.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4
)

	tween.interpolate_property(
	plate,
	"translation",
	alas_tengah,
	alas_standby,
	0.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4
)

# =================================================
# STEP 6 — TURUN PENUH
# =================================================

	tween.interpolate_property(
	servo,
	"translation",
	servo_standby,
	servo_bawah,
	2,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4.5
)

	tween.interpolate_property(
	updown,
	"translation",
	updown_standby,
	updown_bawah,
	2,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4.5
)

	tween.interpolate_property(
	plate,
	"translation",
	alas_standby,
	alas_bawah,
	2,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4.5
)

# =================================================
# STEP 7 — KELUAR
# =================================================

	tween.interpolate_property(
	plate,
	"translation",
	alas_bawah,
	alas_keluar,
	1,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	6.5
)

	tween.start()

	yield(tween, "tween_all_completed")

	tween.queue_free()

	busy = false


# =====================================================
# RETURN PLATE
# =====================================================

func return_plate(index):

	if busy:
		return

	if current_plate != index:
		return

	busy = true

	var tween = Tween.new()
	add_child(tween)

	var plate = alas[index]

	var arah_z = spot_data[index]["z"]
	var extra = spot_data[index]["extra"]

	var alas_awal = plate.translation
	# naik lift sesuai lantai
	var servo_lantai = servo_awal + Vector3(0, extra, 0)
	var updown_lantai = updown_awal + Vector3(0, extra, 0)
	# =================================================
	# STEP 1
	# =================================================

	var alas_masuk = alas_awal + Vector3(14, 0, 0)

	# =================================================
	# STEP 2
	# =================================================

	var naik_y = 14.3 - extra

	var servo_naik = servo_awal + Vector3(0, naik_y, 0)
	var updown_naik = updown_awal + Vector3(0, naik_y, 0)
	var alas_naik = alas_masuk + Vector3(0, naik_y, 0)

	# =================================================
	# STEP 3
	# =================================================

	var servo_spot = servo_naik + Vector3(0, 0, arah_z)
	var alas_spot = alas_naik + Vector3(0, 0, arah_z)

	# =================================================
	# STEP 4
	# =================================================

	var servo_turun = servo_spot + Vector3(0, -0.3, 0)
	var updown_turun = updown_naik + Vector3(0, -0.3, 0)
	var alas_turun = alas_spot + Vector3(0, -0.3, 0)

	# =================================================
	# STEP 5
	# =================================================

	var servo_balik = servo_turun + Vector3(0, 0, -arah_z)

	# =================================================
	# STEP 1 — MASUK
	# =================================================

	tween.interpolate_property(
		plate,
		"translation",
		alas_awal,
		alas_masuk,
		1,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		0
	)

	# =================================================
	# STEP 2 — NAIK
	# =================================================

	tween.interpolate_property(
		servo,
		"translation",
		servo.translation,
		servo_naik,
		2,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		1
	)

	tween.interpolate_property(
		updown,
		"translation",
		updown.translation,
		updown_naik,
		2,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		1
	)

	tween.interpolate_property(
		plate,
		"translation",
		alas_masuk,
		alas_naik,
		2,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		1
	)

	# =================================================
	# STEP 3 — KE SPOT
	# =================================================

	tween.interpolate_property(
		servo,
		"translation",
		servo_naik,
		servo_spot,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		3
	)

	tween.interpolate_property(
		plate,
		"translation",
		alas_naik,
		alas_spot,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		3
	)

	# =================================================
	# STEP 4 — TURUN
	# =================================================

	tween.interpolate_property(
		servo,
		"translation",
		servo_spot,
		servo_turun,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		4.5
	)

	tween.interpolate_property(
		updown,
		"translation",
		updown_naik,
		updown_turun,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		4.5
	)

	tween.interpolate_property(
		plate,
		"translation",
		alas_spot,
		alas_turun,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		4.5
	)

	# =================================================
	# STEP 5 — BALIK TENGAH
	# =================================================

	tween.interpolate_property(
		servo,
		"translation",
		servo_turun,
		servo_balik,
		1,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		5
	)

	tween.start()

	yield(tween, "tween_all_completed")

	tween.queue_free()

	busy = false
	current_plate = -1


# =====================================================
# BUTTON SPOT
# =====================================================

func _on_SpotA_pressed():
	move_to_plate(1)

func _on_SpotB_pressed():
	move_to_plate(2)

func _on_SpotC_pressed():
	move_to_plate(3)

func _on_SpotD_pressed():
	move_to_plate(4)

func _on_SpotE_pressed():
	move_to_plate(5)

func _on_SpotF_pressed():
	move_to_plate(6)

func _on_SpotG_pressed():
	move_to_plate(7)

func _on_SpotH_pressed():
	move_to_plate(8)

func _on_SpotI_pressed():
	move_to_plate(9)

func _on_SpotJ_pressed():
	move_to_plate(10)


# =====================================================
# BUTTON RETURN
# =====================================================

func _on_ReturnPlateA_pressed():
	return_plate(1)

func _on_ReturnPlateB_pressed():
	return_plate(2)

func _on_ReturnPlateC_pressed():
	return_plate(3)

func _on_ReturnPlateD_pressed():
	return_plate(4)

func _on_ReturnPlateE_pressed():
	return_plate(5)

func _on_ReturnPlateF_pressed():
	return_plate(6)

func _on_ReturnPlateG_pressed():
	return_plate(7)

func _on_ReturnPlateH_pressed():
	return_plate(8)

func _on_ReturnPlateI_pressed():
	return_plate(9)

func _on_ReturnPlateJ_pressed():
	return_plate(10)
