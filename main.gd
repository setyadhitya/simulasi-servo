extends Spatial

onready var servo = $Objek/servolengan
onready var updown = $Objek/updown
onready var alas1 = $Objek/alasmobil1
onready var alas2 = $Objek/alasmobil2
onready var mobil1 = $Objek/mobil1

var busy = false
var servo_awal
var updown_awal
var alas_awal1
var mobil_awal1
var current_plate = ""

func _ready():
	servo_awal = servo.translation
	updown_awal = updown.translation

func return_plate(alas, arah_z):
	if busy:
		return
	busy = true
	var tween = Tween.new()
	add_child(tween)
	# =========================
	# POSISI AWAL
	# =========================
	var alas_keluar = alas.translation
	var alas_masuk = alas_keluar + Vector3(14, 0, 0)
	# =========================
	# NAIK PENUH
	# =========================
	var alas_naik = alas_masuk + Vector3(0, 14, 0)
	var servo_bawah = servo_awal + Vector3(0, -14, 0)
	var servo_naik = servo_awal + Vector3(0, 0.3, 0)
	var updown_bawah = updown_awal + Vector3(0, -14, 0)
	var updown_naik = updown_awal + Vector3(0, 0.3, 0)
	# =========================
	# GESER KE SPOT
	# =========================
	var servo_samping = servo_awal + Vector3(0, 0, arah_z)
	var alas_spot = alas_naik + Vector3(0, 0, arah_z)
	# =========================
	# TURUN DI SPOT
	# =========================
	var servo_turun = servo_samping + Vector3(0, -0.3, 0)
	var alas_turun = alas_spot + Vector3(0, -0.3, 0)
	var updown_turun = updown_naik + Vector3(0, -0.3, 0)
	# =========================
	# 1. MASUKKAN PLATE
	# =========================
	tween.interpolate_property(
		alas,
		"translation",
		alas_keluar,
		alas_masuk,
		1,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		0
	)
	# =========================
	# 2. NAIK PENUH
	# =========================
	tween.interpolate_property(
		alas,
		"translation",
		alas_masuk,
		alas_naik,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		1
	)
	tween.interpolate_property(
		servo,
		"translation",
		servo_bawah,
		servo_naik,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		1
	)
	tween.interpolate_property(
		updown,
		"translation",
		updown_bawah,
		updown_naik,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		1
	)
	# =========================
	# 3. GESER KE SPOT
	# =========================
	tween.interpolate_property(
		servo,
		"translation",
		servo_naik,
		servo_samping,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		2.5
	)
	tween.interpolate_property(
		alas,
		"translation",
		alas_naik,
		alas_spot,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		2.5
	)
	# =========================
	# 4. TURUN DI SPOT
	# =========================
	tween.interpolate_property(
		servo,
		"translation",
		servo_samping,
		servo_turun,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		4
	)
	tween.interpolate_property(
		alas,
		"translation",
		alas_spot,
		alas_turun,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		4
	)
	tween.interpolate_property(
		updown,
		"translation",
		updown_naik,
		updown_turun,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		4
	)
	# =========================
	# 5. SERVO KEMBALI
	# =========================
	tween.interpolate_property(
		servo,
		"translation",
		servo_turun,
		servo_awal,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		4.5
	)
	tween.start()
	yield(tween, "tween_all_completed")
	tween.queue_free()
	busy = false
	
func move_to_plate(alas, arah_z):
	if busy:
		return
	busy = true
	var tween = Tween.new()
	add_child(tween)
	# =========================
	# POSISI AWAL
	# =========================
	var alas_awal = alas.translation
	# =========================
	# STEP 1 - GESER SAMPING
	# =========================
	var servo_samping = servo_awal + Vector3(0, 0, arah_z)
	# =========================
	# STEP 2 - NAIK SEDIKIT
	# =========================
	var servo_naik_local = servo_samping + Vector3(0, 0.3, 0)
	var updown_naik_local = updown_awal + Vector3(0, 0.3, 0)
	var alas_naik = alas_awal + Vector3(0, 0.3, 0)
	# =========================
	# STEP 3 - BALIK KE TENGAH
	# =========================
	var servo_balik = servo_awal + Vector3(0, 0.3, 0)
	var alas_balik = alas_awal + Vector3(0, 0.3, -arah_z)
	# =========================
	# STEP 4 - TURUN STANDBY
	# =========================
	var servo_turun = servo_awal
	var updown_turun = updown_awal
	var alas_turun = alas_awal + Vector3(0, 0, -arah_z)
	# =========================
	# STEP 5 - TURUN PENUH
	# =========================
	var servo_bawah = servo_awal + Vector3(0, -14, 0)
	var updown_bawah = updown_awal + Vector3(0, -14, 0)
	var alas_bawah = alas_awal + Vector3(0, -13.7, -arah_z)
	# =========================
	# STEP 6 - KELUAR
	# =========================
	var alas_keluar = alas_bawah + Vector3(-14, 0, 0)
	# =========================
	# 1. GESER SAMPING
	# =========================
	tween.interpolate_property(
		servo,
		"translation",
		servo_awal,
		servo_samping,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		0
	)
	# =========================
	# 2. NAIK
	# =========================
	tween.interpolate_property(
		servo,
		"translation",
		servo_samping,
		servo_naik_local,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		1.5
	)
	tween.interpolate_property(
		updown,
		"translation",
		updown_awal,
		updown_naik_local,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		1.5
	)
	tween.interpolate_property(
		alas,
		"translation",
		alas_awal,
		alas_naik,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		1.5
	)
	# =========================
	# 3. BALIK KE TENGAH
	# =========================
	tween.interpolate_property(
		servo,
		"translation",
		servo_naik_local,
		servo_balik,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		2
	)
	tween.interpolate_property(
		alas,
		"translation",
		alas_naik,
		alas_balik,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		2
	)
	# =========================
	# 4. TURUN STANDBY
	# =========================
	tween.interpolate_property(
		servo,
		"translation",
		servo_balik,
		servo_turun,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		3.5
	)
	tween.interpolate_property(
		updown,
		"translation",
		updown_naik_local,
		updown_turun,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		3.5
	)
	tween.interpolate_property(
		alas,
		"translation",
		alas_balik,
		alas_turun,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		3.5
	)
	# =========================
	# 5. TURUN PENUH
	# =========================
	tween.interpolate_property(
		servo,
		"translation",
		servo_turun,
		servo_bawah,
		2,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		4
	)
	tween.interpolate_property(
		updown,
		"translation",
		updown_turun,
		updown_bawah,
		2,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		4
	)
	tween.interpolate_property(
		alas,
		"translation",
		alas_turun,
		alas_bawah,
		2,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		4
	)
	# =========================
	# 6. KELUAR
	# =========================
	tween.interpolate_property(
		alas,
		"translation",
		alas_bawah,
		alas_keluar,
		1,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		6
	)
	tween.start()
	yield(tween, "tween_all_completed")
	tween.queue_free()
	busy = false
	
func _on_SpotA_pressed():
	if current_plate != "":
		return
	current_plate = "A"
	move_to_plate(alas1, -11)

func _on_SpotB_pressed():
	if current_plate != "":
		return
	current_plate = "B"
	move_to_plate(alas2, 11)

func _on_ReturnPlateA_pressed():
	if current_plate != "A":
		return
	return_plate(alas1, -11)
	current_plate = ""

func _on_ReturnPlateB_pressed():
	if current_plate != "B":
		return
	return_plate(alas2, 11)
	current_plate = ""
