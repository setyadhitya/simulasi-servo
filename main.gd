extends Spatial

onready var servo = $Objek/servolengan
onready var updown = $Objek/updown
onready var alas1 = $Objek/alasmobil1
onready var mobil1 = $Objek/mobil1

var busy = false

var servo_awal
var servo_kiri
var servo_naik
var servo_kanan
var servo_turun
var servo_turunpenuh
var servo_naikpenuh
var servo_turunplate

var updown_awal
var updown_naik
var updown_turun
var updown_turunpenuh
var updown_naikpenuh
var updown_turunplate

var alas_awal1
var alas_kanan1
var alas_kiri1
var alas_turunpenuh1
var alas_naik1
var alas_turun1
var alas_keluar1
var alas_masuk1
var alas_naikpenuh1
var alas_turunplate1

var mobil_awal1
var mobil_kanan1
var mobil_turunpenuh1
var mobil_naik1
var mobil_turun1
var mobil_keluar1
var mobil_masuk1

func _ready():

	servo_awal = servo.translation
	updown_awal = updown.translation
	alas_awal1 = alas1.translation
	mobil_awal1 = alas1.translation

	# 1. Geser kiri
	servo_kiri = servo_awal + Vector3(0, 0, -11)

	# 2. Naik
	servo_naik = servo_kiri + Vector3(0, 0.3, 0)
	updown_naik = updown_awal + Vector3(0, 0.3, 0)
	alas_naik1 = alas_awal1 + Vector3(0, 0.3, 0)
	mobil_naik1 = mobil_awal1 + Vector3(0, 0.3, 0)

	# 3. Ke kanan dalam posisi masih naik
	servo_kanan = servo_awal + Vector3(0, 0.3, 0)
	alas_kanan1 = alas_awal1 + Vector3(0, 0.3, 11)
	mobil_kanan1 = mobil_awal1 + Vector3(0, 0.3, 11)

	# 4. Turun ke posisi tengah
	servo_turun = servo_awal
	updown_turun = updown_awal
	alas_turun1 = alas_awal1 + Vector3(0, 0, 11)
	mobil_turun1 = mobil_awal1 + Vector3(0, 0, 11)

	# 5. Turun penuh ke dasar
	servo_turunpenuh = servo_awal + Vector3(0, -14, 0)
	updown_turunpenuh = updown_awal + Vector3(0, -14, 0)
	alas_turunpenuh1 = alas_awal1 + Vector3(0, -13.7, 11)
	mobil_turunpenuh1 = mobil_awal1 + Vector3(0, -13.7, 11)

	# 6. Mobil keluar
	alas_keluar1 = alas_turunpenuh1 + Vector3(-14, 0, 0)
	mobil_keluar1 = mobil_turunpenuh1 + Vector3(-14, 0, 0)

	# 7. Masukan carport
	alas_masuk1 = alas_keluar1 + Vector3(14, 0, 0)
	alas_naikpenuh1 = alas_masuk1 + Vector3(0, 14, 0)
	servo_naikpenuh = servo_turunpenuh + Vector3(0, 14.3, 0)
	updown_naikpenuh = updown_turunpenuh + Vector3(0, 14.3, 0)
	alas_kiri1 = alas_naikpenuh1 + Vector3(0, 0, -11)
	servo_turunplate = servo_kiri + Vector3(0, -0.3, 0)
	alas_turunplate1 = alas_kiri1 + Vector3(0, -0.3, 0)
	updown_turunplate = updown_naikpenuh + Vector3(0, -0.3, 0)
	
	
	




func _on_ReturnPlate_pressed():
	if busy:
		return

	busy = true

	var tween = Tween.new()
	add_child(tween)

# =========================
# 1. Alas Keluar
# =========================

	tween.interpolate_property(
	alas1,
	"translation",
	alas_keluar1,
	alas_masuk1,
	1,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	0
	)

	# =========================
	# 2. Naik Ke Spot
	# =========================
	tween.interpolate_property(
	alas1,
	"translation",
	alas_masuk1,
	alas_naikpenuh1,
	1.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	1
	)
	
	tween.interpolate_property(
	servo,
	"translation",
	servo_turunpenuh,
	servo_naikpenuh,
	1.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	1
	)
	
	tween.interpolate_property(
	updown,
	"translation",
	updown_turunpenuh,
	updown_naikpenuh,
	1.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	1
	)
	
	# =========================
	# 3. KE KIRI
	# =========================

	tween.interpolate_property(
	servo,
	"translation",
	servo_naikpenuh,
	servo_kiri,
	1.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	2.5
	)
	
	tween.interpolate_property(
	alas1,
	"translation",
	alas_naikpenuh1,
	alas_kiri1,
	1.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	2.5
	)
	


	# =========================
	# 4. turundikit
	# =========================

	tween.interpolate_property(
	servo,
	"translation",
	servo_kiri,
	servo_turunplate,
	0.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4
	)
	
	tween.interpolate_property(
	alas1,
	"translation",
	alas_kiri1,
	alas_turunplate1,
	0.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4
	)
	
	tween.interpolate_property(
	updown,
	"translation",
	updown_naikpenuh,
	updown_turunplate,
	0.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4
	)

	# =========================
	# 4. ke awal
	# =========================

	tween.interpolate_property(
	servo,
	"translation",
	servo_turunplate,
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
	alas1,
	"translation",
	alas_awal1,
	alas_naik1,
	0.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	1.5
	)

	tween.interpolate_property(
	mobil1,
	"translation",
	mobil_awal1,
	mobil_naik1,
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
	alas1,
	"translation",
	alas_naik1,
	alas_kanan1,
	1.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	2.0
	)

	tween.interpolate_property(
	mobil1,
	"translation",
	mobil_naik1,
	mobil_kanan1,
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
	alas1,
	"translation",
	alas_kanan1,
	alas_turun1,
	0.5,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	3.5
	)

	tween.interpolate_property(
	mobil1,
	"translation",
	mobil_kanan1,
	mobil_turun1,
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

	tween.interpolate_property(
	updown,
	"translation",
	updown_turun,
	updown_turunpenuh,
	2,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4
	)

	tween.interpolate_property(
	alas1,
	"translation",
	alas_turun1,
	alas_turunpenuh1,
	2,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4
	)

	tween.interpolate_property(
	mobil1,
	"translation",
	mobil_turun1,
	mobil_turunpenuh1,
	2,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	4
	)

	tween.interpolate_property(
	alas1,
	"translation",
	alas_turunpenuh1,
	alas_keluar1,
	1,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	6
	)

	tween.interpolate_property(
	mobil1,
	"translation",
	mobil_turunpenuh1,
	mobil_keluar1,
	1,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT,
	6
	)



	tween.start()

	yield(tween, "tween_all_completed")
	tween.queue_free()
	busy = false







