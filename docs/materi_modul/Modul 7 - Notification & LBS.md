# Modul 7: NOTIFICATION & LBS

## I. Tujuan Praktikum

- Mampu mengimplementasikan immediate notification pada aplikasi Flutter.
- Mampu mengimplementasikan scheduled notification yang tetap aktif saat aplikasi ditutup.
- Mampu mengakses lokasi pengguna menggunakan Location-Based Services (LBS).
- Mampu mengintegrasikan notifikasi dan LBS dalam satu aplikasi yang saling mendukung.
## II. Alokasi Waktu : 1 x pertemuan = 120 menit

## III. Dasar Teori

### A. Notification

Kalian pasti sudah tidak asing lagi dengan *notification,* pesan yang ditampilkan oleh sistem operasi untuk memberikan informasi atau menarik perhatian pengguna terhadap suatu peristiwa yang terjadi di aplikasi. Contoh paling mudah adalah pemberitahuan yang muncul ketika **masuknya email atau chat dari teman**. Notifikasi biasanya muncul dalam bentuk banner, pop-up, badge, atau bar status, dan dapat berisi elemen seperti judul, pesan, ikon, serta tindakan (action) yang dapat ditekan.

Secara umum, notification terbagi menjadi 2 jenis, Local Notification dan Push Notification.

#### 1. Local Notification

Local Notification adalah notifikasi yang dipicu langsung oleh aplikasi dari dalam perangkat. Local Notification tidak membutuhkan internet, karena seluruh proses 
pemicu 
dan penjadwalannya dilakukan oleh device, misalnya berdasarkan timer, alarm, atau event tertentu dalam aplikasi.

Contoh penggunaan Local Notification:

- **a)** Alarm pengingat
- **b)** Timer selesai
- **c)** Pencatatan kegiatan harian
- **d)** Reminder to-do list
#### 2. Push Notification

Push Notification adalah notifikasi yang dikirim dari server ke perangkat melalui internet. Jenis notifikasi ini membutuhkan layanan backend atau layanan pihak ketiga seperti **Firebase Cloud Messaging**, karena data yang dikirim berasal dari sumber eksternal dan biasanya bersifat dinamis.

Contoh penggunaan Push Notification:

a. Chat atau pesan real-time

b. Update promo dan penawaran

c. Berita terbaru

d. Status pengiriman atau logistik Agar lebih jelas, berikut tabel perbandingannya:

**Tabel 7.1** Perbandingan Local Notification dan Push Notification **Aspek** 
**Local Notification** 
**Push Notification** Sumber Pemicu 
Aplikasi di perangkat 
Server melalui internet Kebutuhan Internet 
Tidak perlu 
Perlu Ketergantungan Server 
Tidak ada 
Ada Data Informasi 
Statis / internal aplikasi 
Dinamis / eksternal Contoh Penggunaan 
Alarm, To-do, Timer 
Chat, Promo, Tracking Pada modul ini, kita akan fokus membahas **Local Notification**, dengan jenisnya adalah **Immediate Notification**, yang muncul langsung ketika di-trigger, dan **Scheduled Notification** yang dijadwalkan untuk muncul di waktu tertentu, serta tetap aktif meski aplikasi ditutup.

### B. LBS (Location-Based Services)

Sebagai perangkat yang di desain "serba guna", smartphone tidak hanya untuk komunikasi, tetapi juga untuk kebutuhan seperti navigasi, pencarian lokasi terdekat, pelacakan keberadaan objek, hingga rekomendasi tempat. Fitur-fitur ini secara tidak langsung membuat aplikasi terasa lebih "pintar" karena dapat menyesuaikan informasi berdasarkan lokasi pengguna.

Kemampuan aplikasi untuk menyediakan layanan atau informasi yang dipengaruhi oleh lokasi pengguna inilah yang disebut sebagai Location-Based Services (LBS). Secara sederhana, LBS adalah layanan pada aplikasi yang memanfaatkan data lokasi pengguna untuk memberikan pengalaman yang lebih kontekstual, relevan, dan sesuai keadaan di lapangan. Contoh penerapan LBS dalam aplikasi sehari-hari:

- Gojek / Grab (transportasi & tracking)
- Google Maps (navigasi)
- Marketplace (melihat toko terdekat)
- Aplikasi cuaca (menampilkan cuaca di lokasi pengguna)
- Logistik (melacak paket) Pada modul ini, kita akan mempelajari bagaimana:
- Mengakses lokasi pengguna melalui permission
- Mendapatkan koordinat lokasi (latitude & longitude) menggunakan package geolocator
- Mengintegrasikan hasil LBS ke dalam tampilan UI
## IV. Langkah Praktikum

### A. Overview

Pada praktikum ini kita akan membuat aplikasi bernama **Nearby Reminder**, sebuah aplikasi pengingat berbasis lokasi. Berbeda dengan reminder biasa, aplikasi ini menggabungkan dua fitur: notifikasi dan LBS, sehingga keduanya saling mendukung. Fitur-fitur dari aplikasi ini adalah:

#### 1. Notifikasi Langsung

Ada tombol yang ketika diklik, langsung mengirim notifikasi ke pengguna.

#### 2. Lokasi Terdekat

Ada tombol untuk mengambil lokasi GPS user saat ini (*current* *location*). Setelah lokasi didapat, aplikasi menghitung jarak pengguna ke semua lokasi dummy yang sudah disediakan, lalu menampilkannya dari yang terdekat. Lokasi yang jaraknya kurang dari 150 meter ditandai hijau sebagai tanda "kamu dekat sini".

#### 3. Set Reminder ke Lokasi

User memilih salah satu lokasi tujuan dari list, lalu memilih tanggal dan waktu reminder. Saat waktu tiba, scheduled notification muncul yang isinya ada nama lokasi yang dipilih, sebagai pengingat untuk membuka app dan mengecek seberapa jauh posisi pengguna dari lokasi tersebut.

Ketiga fitur ini langsung berbarengan dapat diakses dari page home.

Alur dari aplikasi secara lengkapnya seperti ini:


![Gambar 7.1 Alur aplikasi yang akan dibuat pada Langkah Praktikum](images/modul_7/img_p4_1_22.png)
*Gambar 7.1 Alur aplikasi yang akan dibuat pada Langkah Praktikum*

Sedangkan struktur filenya adalah sebagai berikut:


![Gambar 7.2 Struktur file aplikasi](images/modul_7/img_p4_2_23.png)
*Gambar 7.2 Struktur file aplikasi*

Langkah praktikum dibagi menjadi dua tahap. Tahap pertama fokus membangun fitur notifikasi dulu, immediate dan scheduled. Setelah notifikasi jalan, baru kita tambahkan fitur LBS di tahap kedua.

Oiya, perlu diperhatikan juga, karena mulai kedepannya kita akan mulai bermain dengan fitur-fitur yang hanya dimiliki oleh aplikasi mobile (menampilkan notifikasi, menggunakan GPS), maka sangat dianjurkan untuk menjalankan project **menggunakan HP fisik ataupun emulator.**

### B. Notification

#### 1. Buat project Flutter baru

#### 2. Tambahkan dependency berikut ke pubspec.yaml:

##### Contoh Program 7.1 pubspec.yaml

```yaml
dependencies: 
  flutter: 
    sdk: flutter 
  flutter_local_notifications: ^19.0.0 
  timezone: ^0.10.0
```

3. Buka file **android/app/build.gradle.kts** (atau build.gradle), tambahkan konfigurasi **desugaring** berikut. Ini diperlukan agar scheduled notification bisa berjalan di Android versi lama.

##### Contoh Program 7.2 build.gradle.kts

```dart
android { 
    compileOptions { 
        isCoreLibraryDesugaringEnabled = true //tambah 
    } 
} 
 
// di luar, di bawah android 
dependencies { 
    
coreLibraryDesugaring("com.android.tools:desugar_jdk_libs
:2.1.4")  
}  //tambah
```

Package flutter_local_notifications yang kita pakai, menggunakan sebuah class untuk menjadwalkan notifikasi yang hanya tersedia di Android

8. 0 (API 26) ke atas. Desugaring memungkinkan class tersebut berjalan di Android versi yang lebih lama dengan cara menyertakan implementasinya langsung ke dalam APK.

4. Tambahkan 
permission 
dan 
receiver 
berikut 
di **android/app/src/main/AndroidManifest.xml**, di dalam tag **<manifest>** tapi di luar **<application>** untuk bagian uses-permission, dan di dalam **<application>** untuk bagian receiver:

##### Contoh Program 7.3 AndroidManifest.xml

```dart
<!-- Di dalam <manifest>, di luar <application> --> 
<uses-permission 
android:name="android.permission.RECEIVE_BOOT_COMPLETED"/
> 
<uses-permission 
android:name="android.permission.SCHEDULE_EXACT_ALARM"/> 
<uses-permission 
android:name="android.permission.USE_EXACT_ALARM"/> 
<uses-permission 
android:name="android.permission.POST_NOTIFICATIONS"/> 
 
<!-- Di dalam <application>, dibawah <activity> --> 
<receiver 
            android:exported="false" 
            
android:name="com.dexterous.flutterlocalnotifications.Sch
eduledNotificationReceiver" /> 
        <receiver 
            android:exported="false" 
            
android:name="com.dexterous.flutterlocalnotifications.Sch
eduledNotificationBootReceiver"> 
            <intent-filter> 
                <action 
android:name="android.intent.action.BOOT_COMPLETED"/> 
                <action 
android:name="android.intent.action.MY_PACKAGE_REPLACED"/
> 
                <action 
android:name="android.intent.action.QUICKBOOT_POWERON" /> 
            </intent-filter> 
        </receiver> 
        <receiver 
            android:exported="false" 
            
android:name="com.dexterous.flutterlocalnotifications.Flu
tterLocalNotificationsReceiver"/>
```

Tag-tag uses-permission bertujuan dalam **perizinan aplikasi untuk** **menampilkan notifikasi**, sedangkan reciever berperan **menerima alarm** **dari sistem Android saat waktu notif tiba dan menampilkannya.** Tanpa ini scheduled notification tidak akan pernah muncul.

5. Dalam 
folder 
lib, 
buat 
folder 
baru 
**services**, 
lalu 
buat 
file **notification_service.dart** di dalamnya. File ini akan mengelola semua fungsi notifikasi menggunakan ***Singleton Pattern***, memastikan hanya ada satu instance NotificationService di seluruh aplikasi. Masukkan kodingan ini.

##### Contoh Program 7.4 notificatino_service.dart

```dart
import 
'package:flutter_local_notifications/flutter_local_notifi
cations.dart'; 
import 'package:timezone/timezone.dart' as tz; 
import 'package:timezone/data/latest.dart' as tz; 
 
class NotificationService { 
  // Singleton pattern 
  static final NotificationService _instance = 
      NotificationService._internal(); 
  factory NotificationService() => _instance; 
  NotificationService._internal(); 
 
  final FlutterLocalNotificationsPlugin 
notificationPlugin = 
      FlutterLocalNotificationsPlugin(); 
 
  Future<void> init() async { 
    // 1. Inisialisasi timezone 
    tz.initializeTimeZones(); 
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta')); 
 
    // 2. Konfigurasi Android 
    const AndroidInitializationSettings androidSettings = 
        
AndroidInitializationSettings('@mipmap/ic_launcher'); 
    const InitializationSettings initSettings = 
        InitializationSettings(android: androidSettings); 
    await notificationPlugin.initialize(initSettings); 
 
    // 3. Request permission dan buat channel 
    final androidPlatform = notificationPlugin 
        .resolvePlatformSpecificImplementation< 
            AndroidFlutterLocalNotificationsPlugin>(); 
    await 
androidPlatform?.requestNotificationsPermission(); 
 
    const AndroidNotificationChannel channel = 
AndroidNotificationChannel( 
      'reminder_channel', 
      'Reminder Notifications', 
      description: 'Channel untuk reminder notifikasi', 
      importance: Importance.high, 
    ); 
    await 
androidPlatform?.createNotificationChannel(channel); 
  } 
 
  // Immediate notification: muncul langsung saat 
dipanggil 
  Future<void> showInstantNotification({ 
    required String title, 
    required String body, 
  }) async { 
    const AndroidNotificationDetails androidDetails = 
        AndroidNotificationDetails( 
      'reminder_channel', 
      'Reminder Notifications', 
      importance: Importance.high, 
      priority: Priority.high, 
    ); 
    const NotificationDetails notifDetails = 
        NotificationDetails(android: androidDetails); 
 
    await notificationPlugin.show(0, title, body, 
notifDetails); 
  } 
 
  // Scheduled notification: muncul di waktu yang 
ditentukan 
  Future<void> scheduleNotification({ 
    required int id, 
    required String title, 
    required String body, 
    required DateTime scheduledTime, 
  }) async { 
    const AndroidNotificationDetails androidDetails = 
        AndroidNotificationDetails( 
      'reminder_channel', 
      'Reminder Notifications', 
      importance: Importance.high, 
      priority: Priority.high, 
    ); 
    const NotificationDetails notifDetails = 
        NotificationDetails(android: androidDetails); 
 
    await notificationPlugin.zonedSchedule( 
      id, 
      title, 
      body, 
      // Buat TZDateTime langsung dari komponen waktu 
agar tidak ada 
      // kesalahan konversi timezone 
      tz.TZDateTime( 
        tz.local, 
        scheduledTime.year, 
        scheduledTime.month, 
        scheduledTime.day, 
        scheduledTime.hour, 
        scheduledTime.minute, 
      ), 
      notifDetails, 
      androidScheduleMode: 
AndroidScheduleMode.exactAllowWhileIdle, 
    ); 
  } 
}
```

Coba kita perhatikan kodingan ini, didalam class NotificationService, terdapat tiga function utama:

-
init(), yang akan dipanggil di main.dart, berperan untuk konfigurasi awal notifikasi sehingga bisa dijalankan.

-
showInstantNotification(), 
fungsi 
untuk 
menampilkan **Immediate Notification.** -
scheduleNotification(), 
untuk 
menampilkan 
**Scheduled** **Notification.** Ketiganya 
menggunakan 
**asynchronous**, 
karena menampilkan notifikasi melibatkan komunikasi dengan sistem Android di luar app, bukan sekadar operasi di memori. Butuh waktu untuk Flutter harus bicara ke Android lewat platform channel, android harus memproses permintaan tersebut, dan baru menampilkan atau menjadwalkan notifikasi.

Kita 
membuat 
instance 
**FlutterLocalNotificationsPlugin** 
dan menyimpannya di dalam variabel **notificationPlugin.** Untuk immediate, kita menggunakan 
.show(), 
sedangkan 
scheduled 
menggunakan .zonedSchedule(). Dua-duanya memiliki parameter yang harus kita isi, diantaranya title, dan body. Inilah komponen penyusun dari sebuah notifikasi, sehingga notif bisa terlihat memiliki judul dan deskripsi dibawahnya.

Disini kita juga menggunakan package **timezone** untuk keperluan Scheduled Notification, untuk mengetahui zona waktu pengguna.

6. Pada **main.dart**, kita perlu memanggil **NotificationService().init()**, sehingga ketika aplikasi dibuka, konfigurasi untuk notifikasi langsung dijalankan. **Update** kodingannya menjadi seperti dibawah, lalu coba jalankan:

##### Contoh Program 7.5 main.dart

```dart
import 'package:flutter/material.dart'; 
import 'screens/home_screen.dart'; 
import 'services/notification_service.dart'; 
 
void main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
  await NotificationService().init(); 
  runApp(const MainApp()); 
} 
 
class MainApp extends StatelessWidget { 
  const MainApp({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      debugShowCheckedModeBanner: false, 
      home: const HomeScreen(), 
    ); 
  } 
}
```

7. Sekarang, baru kita buat tampilannya, untuk menjalankan notifikasi immadiate dan scheduled. Pada lib, buat folder **screens**. Didalamnya buat file **home_screen.dart.**

##### Contoh Program 7.6 home.screen.dart

```dart
import 'package:flutter/material.dart'; 
import '../services/notification_service.dart'; 
 
 
class HomeScreen extends StatefulWidget { 
  const HomeScreen({super.key}); 
 
 
  @override 
  State<HomeScreen> createState() => _HomeScreenState(); 
} 
 
class _HomeScreenState extends State<HomeScreen> { 
  DateTime? _scheduledTime; 
 
 
  String _formatDateTime(DateTime dt) { 
    final now = DateTime.now(); 
    final today = DateTime(now.year, now.month, now.day); 
    final tomorrow = today.add(const Duration(days: 1)); 
    final date = DateTime(dt.year, dt.month, dt.day); 
 
 
    String dateLabel; 
    if (date == today) { 
      dateLabel = 'Hari ini'; 
    } else if (date == tomorrow) { 
      dateLabel = 'Besok'; 
    } else { 
      dateLabel = '${dt.day}/${dt.month}/${dt.year}'; 
    } 
    final hour = dt.hour.toString().padLeft(2, '0'); 
    final minute = dt.minute.toString().padLeft(2, '0'); 
    return '$dateLabel, $hour:$minute'; 
  } 
 
 
  Future<void> _pickDateTime() async { 
    final pickedDate = await showDatePicker( 
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(const Duration(days: 365)), 
    ); 
    if (pickedDate == null) return; 
    if (!mounted) return; 
 
 
    final pickedTime = await showTimePicker( 
      context: context, 
      initialTime: TimeOfDay.now(), 
    ); 
    if (pickedTime == null) return; 
 
 
    setState(() { 
      _scheduledTime = DateTime( 
        pickedDate.year, pickedDate.month, pickedDate.day, 
        pickedTime.hour, pickedTime.minute, 
      ); 
    }); 
  } 
 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: const Text('Nearby Reminder', 
            style: TextStyle(fontWeight: FontWeight.bold)), 
        centerTitle: true, 
        backgroundColor: Colors.deepPurple, 
        foregroundColor: Colors.white, 
      ), 
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(24), 
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [ 
 
 
            // --- Bagian 1: Immediate Notification --- 
            const Text('Notifikasi Langsung', 
                style: TextStyle(fontSize: 16, fontWeight: 
FontWeight.bold)), 
            const SizedBox(height: 8), 
            ElevatedButton.icon( 
              icon: const Icon(Icons.notifications_active), 
              label: const Text('Kirim Notifikasi Sekarang'), 
              style: ElevatedButton.styleFrom( 
                backgroundColor: Colors.deepPurple, 
                foregroundColor: Colors.white, 
                padding: const EdgeInsets.all(14), 
              ), 
              onPressed: () async { 
                await 
NotificationService().showInstantNotification( 
                  title: 'Halo! 👋', 
                  body: 'Ini adalah contoh immediate 
notification.', 
                ); 
                if (mounted) { 
                  ScaffoldMessenger.of(context).showSnackBar( 
                    const SnackBar(content: Text('Notifikasi 
dikirim!')), 
                  ); 
                } 
              }, 
            ), 
 
 
            const SizedBox(height: 32), 
 
 
            // --- Bagian 2: Scheduled Notification --- 
            const Text('Notifikasi Terjadwal', 
                style: TextStyle(fontSize: 16, fontWeight: 
FontWeight.bold)), 
            const SizedBox(height: 8), 
            GestureDetector( 
              onTap: _pickDateTime, 
              child: Container( 
                padding: const EdgeInsets.symmetric( 
                    horizontal: 12, vertical: 16), 
                decoration: BoxDecoration( 
                  border: Border.all(color: Colors.grey), 
                  borderRadius: BorderRadius.circular(8), 
                ), 
                child: Row( 
                  children: [ 
                    const Icon(Icons.calendar_today, color: 
Colors.grey), 
                    const SizedBox(width: 8), 
                    Expanded( 
                      child: Text( 
                        _scheduledTime == null 
                            ? 'Pilih tanggal & waktu 
reminder...' 
                            : _formatDateTime(_scheduledTime!), 
                        style: TextStyle( 
                          color: _scheduledTime == null 
                              ? Colors.grey : Colors.black, 
                        ), 
                      ), 
                    ), 
                    if (_scheduledTime != null) 
                      GestureDetector( 
                        onTap: () => setState(() => 
_scheduledTime = null), 
                        child: const Icon(Icons.close, 
                            color: Colors.grey, size: 18), 
                      ), 
                  ], 
                ), 
              ), 
            ), 
            const SizedBox(height: 8), 
            ElevatedButton.icon( 
              icon: const Icon(Icons.alarm), 
              label: const Text('Set Reminder'), 
              style: ElevatedButton.styleFrom( 
                backgroundColor: Colors.orange, 
                foregroundColor: Colors.white, 
                padding: const EdgeInsets.all(14), 
              ), 
              onPressed: _scheduledTime == null ? null : () 
async { 
                await 
NotificationService().scheduleNotification( 
                  id: 1, 
                  title: 'Reminder! ⏰', 
                  body: 'Kamu punya reminder yang sudah 
waktunya.', 
                  scheduledTime: _scheduledTime!, 
                ); 
                if (mounted) { 
                  ScaffoldMessenger.of(context).showSnackBar( 
                    SnackBar(content: Text( 
                      'Reminder di-set untuk 
${_formatDateTime(_scheduledTime!)}', 
                    )), 
                  ); 
                  setState(() => _scheduledTime = null); 
                } 
              }, 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
}
```

Fiuhh. Memang kelihatannya agak banyak ya? Namun kodingan ini sebagian besar berperan untuk UI. Untuk bisa melihatnya, silahkan jalankan terlebih dahulu. Jika muncul popup perizinan seperti "*allow to show* *notification?*", pilih **allow**.


![Gambar 7.3 Home Page awal](images/modul_7/img_p14_1_49.png)
*Gambar 7.3 Home Page awal*

Di sebelah atas, terdapat button untuk menampilkan **Immediate** **Notification.** 
Function 
**NotificationService().showInstantNotification()** dipanggil didalam properti **onPressed.** Lalu dibawahnya, ada DateTime picker untuk menginput kapan dan jam berapa kita menginginkan ditampilkannya **Scheduled Notification**.

Setelah menginput DateTime, kita bisa tekan button 'Set Reminder' untuk menyetel notifikasi tersebut dan tinggal menunggu hingga waktunya untuk muncul.

Coba untuk tekan button 'Kirim Notifikasi Sekarang'. Notifikasi harusnya langsung muncul di status bar.

Klik input field DateTime (tanggal & waktu), pilih tanggal hari ini dengan waktu 1-2 menit ke depan, lalu tap '**Set Reminder**'. Pastikan muncul snackbar konfirmasi. Minimize atau tutup aplikasi. Tunggu hingga waktu yang ditentukan, notifikasi harusnya muncul meski aplikasi tidak terbuka.


![Ilustrasi](images/modul_7/img_p15_1_52.png)


![Gambar 7.4 Immediate Notification  Gambar 7.5 Scheduled Notification](images/modul_7/img_p15_2_53.png)
*Gambar 7.4 Immediate Notification  Gambar 7.5 Scheduled Notification*

Jika Scheduled Notification **tidak muncul:** -
Pastikan 
semua 
permission 
dan 
receiver 
di AndroidManifest.xml sudah ditambahkan dengan benar.

-
Pastikan konfigurasi desugaring di build.gradle.kts sudah ada.

-
Di device, buka Settings → Apps → [nama app] → Alarms & Reminders → pastikan diizinkan.

-
Coba jalankan di HP fisik jika menggunakan emulator, karena beberapa emulator memiliki keterbatasan dalam menjalankan scheduled notification.

### C. Integrasi dengan Location-Based Services

#### 1. Tambah dependency geolocator:

##### Contoh Program 7.7 Tambahan dependency geolocator

```yaml
dependencies: 
  flutter: 
    sdk: flutter 
  flutter_local_notifications: ^19.0.0 
  timezone: ^0.10.0 
  geolocator: ^13.0.0  #tambahan
```

2. Tambahkan permission lokasi di AndroidManifest.xml, di dalam tag <manifest> bersama permission lainnya:

##### Contoh Program 7.8 Tambahan permission lokasi

```dart
<uses-permission 
android:name="android.permission.ACCESS_FINE_LOCATION" /> 
<uses-permission 
android:name="android.permission.ACCESS_COARSE_LOCATION" 
/>
```

#### 3. Membuat Data Dummy Lokasi

Nah, sekarang kita akan menggunakan membuat data dummy dari beberapa 
tempat, 
yang 
masing-masing 
memiliki 
koordinat. 
Setelah mendapatkan koordinat user, kita bandingkan agar bisa mengetahui **jarak** **user dan tempat-tempat tersebut**.

**Tabel 7.2** Data dummy tempat **Nama Titik Lokasi** 
**Koordinat (latitude, longitude)** Kampus 
-7.7823, 110.4157 Minimarket 
-7.7831, 110.4147 Kantin 
-7.7824, 110.4163 Masjid 
-7.7815, 110.4152 Kos 
-7.7808, 110.4172 Pada peta, posisi lokasi-lokasi ini adalah seperti berikut:


![Gambar 7.6 Peta lokasi data dummy yang akan digunakan untuk fitur LBS](images/modul_7/img_p17_1_58.png)
*Gambar 7.6 Peta lokasi data dummy yang akan digunakan untuk fitur LBS*

4. Sekarang buat folder **data** di dalam lib, lalu buat file **locations.dart**. Kita bikin dulu modelnya dan data dummy nya.

##### Contoh Program 7.9 locations.dart

```dart
class LocationData { 
  final String name; 
  final double lat; 
  final double lng; 
 
  const LocationData({ 
    required this.name, 
    required this.lat, 
    required this.lng, 
  }); 
} 
 
const List<LocationData> dummyLocations = [ 
  LocationData(name: 'Kampus', 
      lat: -7.782383704688537, lng: 110.41586606343337), 
  LocationData(name: 'Minimarket', 
      lat: -7.783139925317062, lng: 110.41454302410676), 
  LocationData(name: 'Kantin', 
      lat: -7.782466604443315, lng: 110.41618756029608), 
  LocationData(name: 'Masjid', 
      lat: -7.781581023250215, lng: 110.41502197824055), 
  LocationData(name: 'Kos', 
      lat: -7.780829957491809, lng: 110.41722718735446), 
];
```

5. Selanjutnya, kita update **home_screen.dart.** Kita tambahkan fitur **Cek** **Lokasi**, lalu fitur **set reminder** tadi kita perbarui dengan memasukkan informasi lokasi, menjadi fitur **Set Reminder ke Lokasi.** Lumayan banyak hehe, kita pecah agar mudah memahaminya.

6. Pertama, kita perlu mendeklarasikan variabel-variabel untuk keperluan state. Tambahkan variabel baru di dalam **_HomeScreenState,** di bawah variabel **_scheduledTime** yang sudah ada. Jangan lupa import location.dart dan package geolocator:

##### Contoh Program 7.10 Deklarasi variabel state (home_screen.dart)

```dart
// Tambahan 
LocationData? _selectedLocation; 
 
// State LBS 
Position? _currentPosition; 
bool _isLoadingLocation = false; 
List<Map<String, dynamic>> _locationsWithDistance = [];
```

7. Dibawah _formatDateTime(), tambahkan method helper **_formatDistance()** untuk mengubah angka jarak dalam meter menjadi teks yang lebih mudah dibaca.

##### Contoh Program 7.11 Method _formatDistance()

```dart
String _formatDistance(double meters) { 
  if (meters < 1000) return '${meters.toStringAsFixed(0)} 
m'; 
  return '${(meters / 1000).toStringAsFixed(1)} km'; 
}
```

8. Tambahkan fungsi **_getCurrentLocation()** di bawah _pickDateTime(). Inilah inti dari implementasi LBS.

##### Contoh Program 7.12 Method _getCurrentLocation()

```dart
Future<void> _getCurrentLocation() async { 
  setState(() { 
    _isLoadingLocation = true; 
    _locationsWithDistance = []; 
  }); 
 
  // 1. Cek apakah GPS aktif 
  bool serviceEnabled = await 
Geolocator.isLocationServiceEnabled(); 
  if (!serviceEnabled) { 
    if (mounted) 
ScaffoldMessenger.of(context).showSnackBar( 
      const SnackBar(content: Text('GPS tidak aktif.'))); 
    setState(() => _isLoadingLocation = false); 
    return; 
  } 
 
  // 2. Cek dan minta permission 
  LocationPermission permission = await 
Geolocator.checkPermission(); 
  if (permission == LocationPermission.denied) { 
    permission = await Geolocator.requestPermission(); 
    if (permission == LocationPermission.denied) { 
      if (mounted) 
ScaffoldMessenger.of(context).showSnackBar( 
        const SnackBar(content: Text('Permission lokasi 
ditolak.'))); 
      setState(() => _isLoadingLocation = false); 
      return; 
    } 
  } 
  if (permission == LocationPermission.deniedForever) { 
    if (mounted) 
ScaffoldMessenger.of(context).showSnackBar( 
      const SnackBar(content: Text('Permission lokasi 
diblokir.'))); 
    setState(() => _isLoadingLocation = false); 
    return; 
  } 
 
  // 3. Ambil posisi 
  final position = await Geolocator.getCurrentPosition( 
    locationSettings: 
        const LocationSettings(accuracy: 
LocationAccuracy.high), 
  ); 
 
  // 4. Hitung jarak ke semua lokasi dummy 
  final result = dummyLocations.map((loc) { 
    final distance = Geolocator.distanceBetween( 
      position.latitude, position.longitude, 
      loc.lat, loc.lng, 
    ); 
    return {'location': loc, 'distance': distance}; 
  }).toList(); 
 
  // 5. Urutkan dari terdekat 
  result.sort((a, b) => 
      (a['distance'] as double).compareTo(b['distance'] 
as double)); 
 
  setState(() { 
    _currentPosition = position; 
    _locationsWithDistance = result; 
    _isLoadingLocation = false; 
  }); 
}
```

Pertama-tama, GPS akan dicek apakah aktif atau tidak, lalu permintaan 
permission 
dilakukan. 
Menggunakan **Geolocator.getCurrentPosition(),** koordinat user akan diambil, lalu di hitung jaraknya dari semua lokasi dummy. Terakhir, diurutkan dari yang terdekat dengan user.

9. Ganti UI **'Notifikasi Terjadwal'** sebelumnya menjadi berikut, **'Lokasi** **Terdekat'.**

##### Contoh Program 7.13 UI Bagian 2: Lokasi Terdekat

```dart
const SizedBox(height: 32), 
 
// Bagian 2: LBS 
const Text('Lokasi Terdekat', 
    style: TextStyle(fontSize: 16, fontWeight: 
FontWeight.bold)), 
const SizedBox(height: 8), 
ElevatedButton.icon( 
  icon: const Icon(Icons.my_location), 
  label: const Text('Cek Lokasi Saya'), 
  style: ElevatedButton.styleFrom( 
    backgroundColor: Colors.teal, 
    foregroundColor: Colors.white, 
    padding: const EdgeInsets.all(14), 
  ), 
  onPressed: _isLoadingLocation ? null : _getCurrentLocation, 
), 
if (_isLoadingLocation) ...[ 
  const SizedBox(height: 16), 
  const Center(child: CircularProgressIndicator()), 
], 
if (_currentPosition != null) ...[ 
  const SizedBox(height: 12), 
  Text( 
    'Posisi kamu: 
${_currentPosition!.latitude.toStringAsFixed(5)}, ' 
    '${_currentPosition!.longitude.toStringAsFixed(5)}', 
    style: const TextStyle(fontSize: 12, color: Colors.grey), 
  ), 
  const SizedBox(height: 12), 
  ..._locationsWithDistance.map((item) { 
    final loc = item['location'] as LocationData; 
    final distance = item['distance'] as double; 
    final isNear = distance < 150; 
    return Container( 
      margin: const EdgeInsets.only(bottom: 8), 
      padding: const EdgeInsets.all(12), 
      decoration: BoxDecoration( 
        color: isNear ? Colors.green.shade50 : 
Colors.grey.shade50, 
        borderRadius: BorderRadius.circular(8), 
        border: Border.all( 
          color: isNear ? Colors.green : Colors.grey.shade300, 
        ), 
      ), 
      child: Row(children: [ 
        Icon(Icons.location_on, 
            color: isNear ? Colors.green : Colors.grey, 
            size: 20), 
        const SizedBox(width: 8), 
        Expanded(child: Text(loc.name, 
            style: TextStyle( 
              fontWeight: FontWeight.bold, 
              color: isNear ? Colors.green.shade700 : 
Colors.black, 
            ))), 
        Text(_formatDistance(distance), 
            style: TextStyle( 
              color: isNear ? Colors.green.shade700 : 
Colors.grey, 
              fontWeight: isNear ? FontWeight.bold : 
FontWeight.normal, 
            )), 
        if (isNear) ...[ 
          const SizedBox(width: 6), 
          const Text('✅', style: TextStyle(fontSize: 14)), 
        ], 
      ]), 
    ); 
  }), 
],
```

Ini akan membuat sebuah button yang jika di tekat, akan menampilkan list lokasi yang ada dan jaraknya dengan user saat ini.

10. Terakhir, tambahkan kode berikut di bawah Bagian 2, yakni **Bagian 3: Set** **Reminder ke Lokasi.**

##### Contoh Program 7.14 UI Bagian 3: Set Reminder ke Lokasi

```dart
const SizedBox(height: 32), 
 
// ── Bagian 3: Set Reminder ke Lokasi ── 
const Text('Set Reminder ke Lokasi', 
    style: TextStyle(fontSize: 16, fontWeight: 
FontWeight.bold)), 
const SizedBox(height: 4), 
const Text( 
  'Pilih lokasi tujuan dan waktu. Notifikasi akan 
mengingatkanmu ' 
  'untuk cek jarak ke lokasi tersebut.', 
  style: TextStyle(fontSize: 12, color: Colors.grey), 
), 
const SizedBox(height: 12), 
DropdownButtonFormField<LocationData?>( 
  value: _selectedLocation, 
  decoration: const InputDecoration( 
    labelText: 'Pilih lokasi tujuan', 
    border: OutlineInputBorder(), 
  ), 
  items: [ 
    const DropdownMenuItem( 
        value: null, child: Text('Pilih lokasi...')), 
    ...dummyLocations.map((loc) => DropdownMenuItem( 
        value: loc, child: Text(loc.name))), 
  ], 
  onChanged: (val) => setState(() => _selectedLocation = 
val), 
), 
const SizedBox(height: 12), 
GestureDetector( 
  onTap: _pickDateTime, 
  child: Container( 
    padding: const EdgeInsets.symmetric(horizontal: 12, 
vertical: 16), 
    decoration: BoxDecoration( 
      border: Border.all(color: Colors.grey), 
      borderRadius: BorderRadius.circular(8), 
    ), 
    child: Row(children: [ 
      const Icon(Icons.calendar_today, color: 
Colors.grey), 
      const SizedBox(width: 8), 
      Expanded(child: Text( 
        _scheduledTime == null 
            ? 'Pilih tanggal & waktu reminder...' 
            : _formatDateTime(_scheduledTime!), 
        style: TextStyle( 
          color: _scheduledTime == null ? Colors.grey : 
Colors.black, 
        ), 
      )), 
      if (_scheduledTime != null) 
        GestureDetector( 
          onTap: () => setState(() => _scheduledTime = 
null), 
          child: const Icon(Icons.close, color: 
Colors.grey, size: 18), 
        ), 
    ]), 
  ), 
), 
const SizedBox(height: 12), 
ElevatedButton.icon( 
  icon: const Icon(Icons.alarm), 
  label: const Text('Set Reminder'), 
  style: ElevatedButton.styleFrom( 
    backgroundColor: Colors.orange, 
    foregroundColor: Colors.white, 
    padding: const EdgeInsets.all(14), 
  ), 
  onPressed: _selectedLocation == null || _scheduledTime 
== null 
      ? null 
      : () async { 
          await 
NotificationService().scheduleNotification( 
            id: 1, 
            title: 'Reminder: ${_selectedLocation!.name} 
📍', 
            body: 'Buka app untuk cek seberapa jauh kamu 
' 
                'dari ${_selectedLocation!.name}', 
            scheduledTime: _scheduledTime!, 
          ); 
          if (mounted) { 
            ScaffoldMessenger.of(context).showSnackBar( 
              SnackBar(content: Text( 
                'Reminder ke ${_selectedLocation!.name} ' 
                'di-set untuk 
${_formatDateTime(_scheduledTime!)}', 
              )), 
            ); 
            setState(() { 
              _scheduledTime = null; 
              _selectedLocation = null; 
            }); 
          } 
        }, 
),
```

Kalau tadi kita set scheduled notification (reminder) hanya dengan tanggal & waktu, kali ini dengan lokasi juga. Jadi remindernya berperan untuk **mengingatkan user pergi ke tempat tersebut pada tanggal dan jam yang** **telah ditentukan.** Sementara itu, user dapat memeriksa apakah sudah dekat apa belum dengan tujuannya dengan fitur di Bagian 2: Lokasi Terdekat.

### D. Waktunya Demo!

Setelah semua kodingan ditambahkan, hentikan running (stop), lalu run kembali. Tujuannya agar instance aplikasi mulai kembali dari awal, dan permission berkaitan LBS dapat di-execute.

Jika kamu menggunakan HP fisik, GPS otomatis sudah ter-set dengan lokasi kamu sekarang. Namun jika kamu menggunakan emulator, biasanya *user location* dengan default berada di Googleplex, markas Google. Maka dari itu, harus kita setting dulu dengan mengklik icon titik tiga di emulator, pilih menu **Location**, cari titik yang kamu inginkan untuk dijadikan lokasi saat ini lalu klik **Set Location**.

Coba masing-masing fitur pada aplikasi. Jika menekan button '**Cek Lokasi** **Saya**', akan muncul popup permission akses lokasi. Terima, lalu akan ditampilkan lokasi user saat ini dan list lokasi, serta mana yang paling dekat dengan icon checklist hijau.

Pada fitur '**Set Reminder ke Lokasi**', pilih lokasi tujuan, tanggal & waktu, lalu set. Ketika muncul, notifnya akan muncul beserta Lokasinya.


![Ilustrasi](images/modul_7/img_p24_1_74.png)


![Gambar 7.7 Cek Lokasi Saya  Gambar 7.8 Set Reminder ke Lokasi](images/modul_7/img_p24_2_75.png)
*Gambar 7.7 Cek Lokasi Saya  Gambar 7.8 Set Reminder ke Lokasi*

Untuk melihat full project dari langkah praktikum modul 7 ini, dapat diakses di repository berikut: https://github.com/AndiZirahitaf/modul_7_prak_mobile.

## V. Tugas

Buat aplikasi to-do yang menerapkan notification & LBS!
