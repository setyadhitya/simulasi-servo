extends Spatial

onready var servo = $Objek/servolengan
onready var updown = $Objek/updown
onready var alas = $Objek/alasmobil

var busy = false

var servo_awal
var servo_kiri
var servo_naik
var servo_kanan
var servo_turun
var servo_turunpenuh

var updown_awal
var updown_naik
var updown_turun

var alas_awal
var alas_kanan
var alas_turunpenuh
var alas_naik
var alas_turun

func _ready():

	servo_awal = servo.translation
	updown_awal = updown.translation
	alas_awal = alas.translation
	
	# 1. Geser kiri
	servo_kiri = servo_awal + Vector3(0, 0, -11)

	# 2. Naik
	servo_naik = servo_kiri + Vector3(0, 0.3, 0)
	updown_naik = updown_awal + Vector3(0, 0.3, 0)
	alas_naik = alas_awal + Vector3(0, 0.3, 0)

	# 3. Ke kanan dalam posisi masih naik
	servo_kanan = servo_awal + Vector3(0, 0.3, 0)
	alas_kanan = alas_awal + Vector3(0, 0.3, 11)

	# 4. Turun ke posisi tengah
	servo_turun = servo_awal
	updown_turun = updown_awal
	alas_turun = alas_awal + Vector3(0, 0, 11)
	
	# 5. Turun penuh ke dasar
	servo_turunpenuh = servo_awal + Vector3(0, -14, 0)

func _on_Button_pressed():

	if busy:
		return

	busy = true

	var tween = Tween.new()
	add_child(tween)

	# =========================
	# 1. KE KIRI
	# =========================

	tween.interpolate_property(
		servo,
		"translation",
		servo_awal,
		servo_kiri,
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
		servo_kiri,
		servo_naik,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		1.5
	)
	
	tween.interpolate_property(
		updown,
		"translation",
		updown_awal,
		updown_naik,
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
	# 3. KE KANAN
	# =========================

	tween.interpolate_property(
		servo,
		"translation",
		servo_naik,
		servo_kanan,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		2.0
	)
	
	tween.interpolate_property(
		alas,
		"translation",
		alas_naik,
		alas_kanan,
		1.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		2.0
	)
	

	# =========================
	# 4. TURUN STANDBY
	# =========================

	tween.interpolate_property(
		servo,
		"translation",
		servo_kanan,
		servo_turun,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		3.5
	)

	tween.interpolate_property(
		updown,
		"translation",
		updown_naik,
		updown_turun,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		3.5
	)

	tween.interpolate_property(
		alas,
		"translation",
		alas_kanan,
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
		servo_turunpenuh,
		2,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		4
	)
	
	tween.start()

	yield(tween, "tween_all_completed")

	tween.queue_free()

	busy = false
