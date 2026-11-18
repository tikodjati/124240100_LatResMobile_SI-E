# Modul 1: PENGENALAN & SETUP FLUTTER

## I. Tujuan Praktikum

- Memahami peran dari Flutter.
- Mampu menginstall Flutter pada perangkat masing-masing
- Mampu menjalankan projek Flutter pertama
## II. Alokasi Waktu : 1 x Pertemuan = 120 menit

## III. Dasar Teori

Mungkin tidak bisa dipungkiri, bahwa pada aplikasi mobile, sistem operasi yang mendominasi pasar adalah **Android dan iOS**. Masing-masing memiliki ekosistem *developing* yang berbeda. Android menggunakan Java/Kotlin, sedangkan iOS menggunakan Swift. Memang, pendekatan ini menghasilkan aplikasi yang optimal di setiap platform. Namun jika ingin mengembangkan **aplikasi mobile yang dapat berjalan di kedua OS** tersebut, developer harus membuatnya secara terpisah, sehingga biaya dan kompleksitas meningkat karena pemeliharaan kode yang menjadi dobel. Berdasarkan ini, pendekatan ***multiplatform*** atau ***cross-platform*** muncul sebagai solusi bagi developer yang ingin membangun aplikasi di berbagai platform sekaligus. Ini memungkinkan developer untuk hanya menulis **satu basis kode, namun dapat dijalankan** **di berbagai platform**, termasuk mobile. Dengan begitu, aplikasi dapat berjalan di Android dan iOS tanpa perlu menulis kode dari awal di masing-masing platform, sehingga proses menjadi lebih efisien.

### A. Flutter sebagai Framework Cross-Platform

Salah satu framework *cross-platform* yang populer adalah **Flutter** yang dikembangkan oleh Google. Berbeda dengan framework *cross-platform* lain, Flutter tidak mengandalkan komponen UI bawaan sistem operasi, tetapi memakai *rendering* *engine* dan kumpulan widget sendiri. Hal ini membuat tampilan aplikasi lebih konsisten di berbagai platform serta kinerja yang stabil. Flutter juga dilengkapi fitur hot reload, yang memungkinkan perubahan kode langsung terlihat, sehingga mempercepat proses pengembangan.

### B. Bahasa Pemrograman Dart

Flutter menggunakan bahasa pemrograman Dart, yang juga dikembangkan oleh Google. Dart mengadopsi paradigma *object-oriented programming* (OOP), dimana kode disusun dalam bentuk **objek yang memiliki atribut dan fungsi**. Dalam Flutter, semua elemen UI adalah widget yang merupakan objek, sehingga developer dapat membuat satu widget dan menggunakannya kembali di berbagai bagian aplikasi. Sebagai contoh, kamu punya UI *button* di aplikasi, kamu cukup mendefinisikan tampilan dan perilakunya sekali, lalu memakainya berkali-kali tanpa menulis ulang dari nol.


![Ilustrasi](images/modul_1/img_p2_1_96.png)

**Ilustrasi Flutter yang bersifat** ***cross-platform***

## IV. Langkah Praktikum

### A. Instalasi dan Konfigurasi Flutter

1. Untuk dapat menginstall Flutter, pertama-tama buka browser dan pergi ke https://flutter.dev/. Setelah itu akan muncul tampilan seperti gambar dibawah.


![Ilustrasi](images/modul_1/img_p3_1_101.png)

2. Pilih "Get Started". Kemudian scroll kebawah hingga sampai di tampilan seperti berikut.


![Ilustrasi](images/modul_1/img_p3_2_104.png)

3. Jika ingin menginstall flutter dengan cepat, bisa mengikuti step disini. Namun, untuk memastikan proses instalasi berjalan lancar, untuk sekarang kita menggunakan metode manual terlebih dahulu. Klik "**Install Flutter manually**" atau kunjungi halaman berikut di browser docs.flutter.dev/install/manual.

4. Scroll kebawah lalu pilih sistem operasi yang kalian gunakan. Akan tertera langkah-langkah instalasinya.


![Ilustrasi](images/modul_1/img_p4_1_109.png)

5. Disini kita akan mendownload **Flutter SDK** (*Software Development Kit*), yaitu berkas paket yang berisi file-file yang dibutuhkan untuk menjalankan Flutter. Klik tombol biru yang tersedia untuk mendownload file zip nya. Saat modul ini dibuat, versi terbarunya adalah 3.38.7.


![Ilustrasi](images/modul_1/img_p4_2_112.png)

6. Setelah proses download selesai, pastikan untuk mengekstrak file instalasinya ke direktori **C:\src\flutter**. Jika belum memiliki folder tersebut, lebih baik buat terlebih dahulu foldernya. Jangan lakukan instalasi flutter kedalam C:\Program Files\.


![Ilustrasi](images/modul_1/img_p5_1_116.png)

7. Setelah proses ekstrak selesai, selanjutnya kita perlu **update path** pada environment PC yang digunakan agar dapat menjalankan perintah Flutter di konsol. Dengan menggunakan search bar, masukkan kata kunci 'env' dan pilih '**Edit environment variable for your account**'.


![Ilustrasi](images/modul_1/img_p5_2_118.png)

8. Pergi ke file explore dan copy path C:\src\flutter\bin seperti pada gambar dibawah.


![Ilustrasi](images/modul_1/img_p6_1_122.png)

9. Kembali ke environment variables, di bagian **User Variables**, pilih **'Path'** kemudian pilih **'New'.** Tambahkan path baru "C:\src\flutter\bin" dengan mem-paste path yang baru saja di copy dari file explorer. Setelah itu klik OK. Kemudian OK kembali.


![Ilustrasi](images/modul_1/img_p6_2_124.png)

10. Dengan ini, path sudah terupdate. Jalankan konsol dan masukkan 'flutter'. Maka akan muncul tampilan seperti pada gambar dibawah. Itu artinya perangkat kita sudah mengenali sistem flutter yang kita install.


![Ilustrasi](images/modul_1/img_p7_1_128.png)

11. Lalu pada menu konsol, masukkan '**flutter doctor**'. Command ini akan menunjukkan mengenai dependencies flutter mana yang sudah siap atau belum, agar dapat menjalankan program flutter dengan baik. Tampilannya seperti pada gambar dibawah.


![Ilustrasi](images/modul_1/img_p7_2_131.png)

Masing-masing dependencies yang belum terpenuhi memiliki **cara atau 'hint'** yang bisa digunakan untuk membantu menyelesaikan dependencies terkait.

12. Karena Flutter dirancang untuk berjalan di berbagai platform, maka setiap platform memiliki kebutuhan (*dependency*) tersendiri agar aplikasi Flutter bisa dijalankan di sana. Itu sebabnya selain menginstal Flutter SDK, kita juga perlu **menginstal** ***dependencies*** **sesuai target platform.** Untuk menjalankan aplikasi Flutter di Android, kita membutuhkan beberapa dependency khusus, seperti **Android SDK (toolchain)**. Seluruh dependency tersebut dapat dengan mudah ditemukan dan diinstal melalui **Android Studio.** Selain itu, Android Studio juga menyediakan **Android Emulator**, perangkat virtual yang digunakan untuk running aplikasi tanpa harus menggunakan perangkat fisik.

13. Jika belum memiliki Android Studio, dapat melakukan instalasi terlebih dahulu melalui link developer.android.com/studio.


![Ilustrasi](images/modul_1/img_p8_1_134.png)

14. Setelah download selesai, buka file instalasinya dan ikuti langkah-langkah instalasinya. Jangan lupa untuk menginstall SDK dan dependencies yang dibutuhkan.

15. Jika instalasi sudah selesai. Silahkan mengecek flutter doctor lagi di konsol.

16. Jika masih ada terdeteksi dependency yang belum terinstal, periksa SDK Manager pada Android Studio. Bisa dibuka melalui **Settings > Languages &** **Frameworks > Android SDK**. Di sana tertera semua rincian mengenai dependency android. akan terlihat mana yang sudah kita miliki dan belum. untuk menginstal, tinggal ceklis dependency yang ingin diinstal dan klik Apply.


![Ilustrasi](images/modul_1/img_p9_2_142.png)

17. Jika terdapat masalah berupa 'Android license not accepted', coba jalankan 'flutter doctor –android-licenses' pada konsol Windows.

18. Setelah semua dependencies yang dibutuhkan untuk menjalankan flutter terpenuhi, seharusnya semuanya akan berwarna hijau. Kira kira seperti ini.


![Ilustrasi](images/modul_1/img_p9_1_139.png)

19. Sampai disini kita sudah berhasil melakukan instalasi dan konfigurasi flutter. Setelah itu, kita tinggal menyiapkan **IDE / Code Editor** untuk flutter nya. Bagi yang ingin menjalankan flutter dengan menggunakan VSCode dapat mengikuti langkah berikut.

20. Download 
dan 
install 
Visual 
Studio 
Code 
melalui 
link https://code.visualstudio.com/


![Ilustrasi](images/modul_1/img_p10_2_148.png)

21. Buka VSCode yang sudah di install. Kemudian pilih menu 'Extensions' yang ada di panel kiri atau bisa juga dengan menekan 'Ctrl + Shift + X'.

22. Cari plugin dengan nama 'Flutter' dan 'Dart' kemudian install kedua plugin tersebut.


![Ilustrasi](images/modul_1/img_p10_1_146.png)

23. Untuk memastikan bahwa flutter sudah terinstall dengan baik, tekan 'Ctrl + Shift + P' dan cari keyword 'Flutter'. Jika muncul hasil seperti gambar di bawah berarti flutter sudah terinstall ke dalam VSCode.


![Ilustrasi](images/modul_1/img_p11_1_153.png)

24. Sampai disini kita sudah berhasil melakukan konfigurasi flutter di Visual Studio Code.

### B. Memulai Project Baru dengan Flutter

1. Pada modul ini akan diberitahu cara membuat projek flutter melalui VSCode. Buka VSCode yang sebelumnya sudah di install. Tekan '**Ctrl + Shift + P**' kemudian cari keyword '**Flutter**' pilih '**Flutter: New Project'**. Setelah itu pilih **'Application (Generate a Flutter application)'.**


![Ilustrasi](images/modul_1/img_p12_1_157.png)

2. Pilih lokasi penyimpanan projek. Usahakan untuk memberi nama folder dengan nama yang jelas dan mudah dimengerti.

3. Tentukan nama aplikasi untuk projek. Nama aplikasi harus diketik dengan huruf kecil semua dan tanpa spasi. Penggunaan spasi diganti dengan garis bawah/*underscore* (_). Contoh: fluter_app.

4. Jika sudah, tunggu sebentar hingga VSCode selesai men-generate projek flutter baru yang baru saja dibuat. Jika projek baru sudah selesai di generate, maka tampilan awal yang muncul adalah file '**main.dart**'. Ini adalah file utama dari sebuah project flutter.


![Ilustrasi](images/modul_1/img_p13_1_161.png)

5. Sampai disini kita sudah berhasil membuat projek flutter baru dengan menggunakan VSCode.

6. Kita juga bisa membuat project flutter langsung melalui konsol. Pada konsol, masuk ke folder tempat kalian ingin membuat projectnya, lalu masukkan command **flutter create [nama projek].**


![Ilustrasi](images/modul_1/img_p13_2_164.png)

### C. Menjalankan projek flutter pada Visual Studio Code

1. Karena flutter adalah framework *cross-platform*, Kita tak hanya dapat menjalankannya dalam mobile device, tapi juga web browser. Disini sebelum run, kita perlu memilih Devicenya terlebih dahulu. Pada VS Code bagian pojok bawah, klik pada "No Device".


![Ilustrasi](images/modul_1/img_p14_1_168.png)

2. Lalu akan muncul device yang dapat dipilih untuk di run


![Ilustrasi](images/modul_1/img_p14_2_171.png)

3. Disini sudah ada device mobile emulator karena sudah ditambahkan. Jika masih awal, seharusnya belum ada. Untuk sementara ini, kita pilih Chrome.

4. Indikator device to run pun berganti.


![Ilustrasi](images/modul_1/img_p14_3_174.png)

5. Selanjutnya, pada menu diatas, klik Run. Jika ingin run dengan men-scanning error, pilih "**Scan With Debugging**", jika tidak, bisa memilih "**Scan Without** **Debugging**" (bisa lebih cepat dan meminimalisir error muncul ketika run).


![Ilustrasi](images/modul_1/img_p15_1_178.png)

6. Kita juga dapat menjalankannya melalui konsol menggunakan command '**flutter** **run**'.

7. Sampai sini, kita telah mengetahui cara menjalankan projek flutter. Untuk dapat memilih device mobile, kita perlu melakukan konfigurasi terlebih dahulu. Untuk menjalankannya pada perangkat mobile, ada dua pilihan: run di real device atau emulator.

#### 8. Run di Real Device (Android)

- **a)** Pada smartphone yang dimiliki, pilih menu 'Settings'.
- **b)** Selanjutnya  pilih  menu 'About Phone', kemudian pilih 'Software
**Information**'. Setelah itu cari '**Build Number**' dan klik sebanyak 7 kali pada 'Build Number' untuk mengaktifkan '**Developer Mode**'.

- **c)** Jika sudah pilih 'Additional Settings', kemudian pilih 'Developer Options'.

![Ilustrasi](images/modul_1/img_p16_1_182.png)

- **d)** Aktifkan 'USB debugging' dan 'Install via USB'.

![Ilustrasi](images/modul_1/img_p16_2_185.png)

- **e)** Setelah mode Developer aktif, sambungkan smartphone dengan perangkat
PC atau laptop yang digunakan dengan menggunakan kabel USB atau sejenisnya.

- **f)** Pada tab device akan terlihat 'Running device' baru dengan nama seri dari
smartphone yang dimiliki masing-masing. Pilih device tersebut.

- **g)** Selanjutnya tinggal di run seperti biasa.
#### 9. Run di Emulator Device (Android)

- **a)** Untuk menjalankan flutter di perangkat virtual emulator device, kita perlu
menginstal emulator devicenya dahulu. Kita dapat menggunakan **Android** **Studio** untuk menginstal emulator yang ingin dipakai.

- **b)** Buka Android Studio. Pada Welcome page, klik click More Actions > Virtual
**Device Manager.**

- **c)** Jika sedang membuka project pergi ke Tools > Device Manager.

![Ilustrasi](images/modul_1/img_p17_1_188.png)

- **d)** Klik icon +, lalu pilih Create Virtual Device.
- **e)** Akan muncul list device emulator yang dapat diinstal. Pilih device yang ingin
diinstal. Lalu klik Next.


![Ilustrasi](images/modul_1/img_p17_2_190.png)

- **f)** Akan muncul rincian mengenai emulatornya. Kita dapat memberikan nama
pada device emulatornya jika diinginkan. Jika sudah yakin, klik '**Finish**'


![Ilustrasi](images/modul_1/img_p18_1_193.png)

- **g)** Emulator akan ditambahkan pada list di Device Manager.
- **h)** Jika sudah, kembali pada VS Code, lalu device yang baru kita tambahkan
harusnya sudah muncul.


![Ilustrasi](images/modul_1/img_p18_2_196.png)

10. Sampai ini, kita sudah mempelajari mengenai cara menjalankan project flutter di **emulator** dan **real device**.

## V. Tugas Praktikum

### A. Lakukan instalasi Flutter di perangkat kalian masing-masing.

### B. Buat projek Flutter pertama kalian dan coba jalankan.
