# Modul 8: FLUTTER LANJUTAN : GETX

## I. Tujuan Praktikum

- Mampu memahami konsep *state management* pada aplikasi Flutter
- Mampu memahami peran GetX sebagai library yang menunjang *state* *management,* *route management* dan *dependency management*
- Mampu menerapkan GetX pada studi kasus sederhana
## II. Alokasi Waktu : 1 x Pertemuan = 120 menit

## III. Dasar Teori

### A. Urgensi State Management: setState() Gak Cukup!

Pada modul-modul sebelumnya kita sudah banyak bermain dengan UI, baik menggunakan data statis maupun dinamis. Ketika suatu data berubah dan mempengaruhi UI, kita menggunakan **setState()** untuk memperbaruinya.

Cara ini memang tidak salah, dan cocok untuk *case* sederhana. Namun, ketika aplikasi mulai berkembang, kita akan mulai merasakan **keterbatasan** dari setState() ini.

Coba deh bayangin, kalian punya sebuah halaman *CounterPage*. Untuk mengubah nilai counter dan langsung update UI-nya, kita bisa memakai setState(). Tapi, bagaimana jika ada **halaman kedua** yang juga menampilkan nilai counter yang **sama**, yang keduanya harus selalu **sinkron**, meskipun perubahan dilakukan dari satu halaman?

setState() tidak bisa meng-*handle* problem ini. Karena ia hanya bisa mengubah UI di dalam widget yang sama, dan widget di page lain **tidak akan tahu** bahwa data tersebut telah berubah.

Sebelum masuk ke solusinya, berikut contoh lain yang lebih realistis: aplikasi **e-commerce**:

- Ada halaman **ProductPage** buat nampilin daftar produk
- Di **AppBar** ada badge yang menunjukkan jumlah item di keranjang
- Halaman **CartPage** untuk nampilin keranjang belanja Ketika user menambahkan produk ke keranjang dari **ProductPage**, data di keranjang, **CartPage**, serta badge di **AppBar** juga harus diperbarui. Masalahnya, ***setState()*** hanya memperbarui UI secara lokal di dalam satu widget. Ia tidak bisa otomatis **"memberi tahu"** widget lain yang ada di halaman berbeda.
Solusi manual yang mungkin terpikir adalah dengan *passing* data antar halaman melalui **constructor,** atau **callback**. Namun cara ini akan cepat menjadi rumit seiring bertambahnya fitur. Data harus dikirim melalui banyak widget **perantara** yang mungkin sebenarnya tidak membutuhkan data tersebut. Ini yang sering disebut dengan masalah ***prop drilling****,* yaitu kondisi di mana data harus diteruskan dari satu widget ke widget lain secara **berantai**.


![Gambar 8.1 Perbandingan jika menggunakan state management atau tidak](images/modul_8/img_p2_2_19.png)
*Gambar 8.1 Perbandingan jika menggunakan state management atau tidak*

Nah, berangkat dari permasalahan inilah konsep **state management** muncul. State management adalah pendekatan untuk mengelola data (state) aplikasi secara terpusat (**sentral**), sehingga perubahan data bisa diakses dan **didengarkan** (*listenable*) oleh widget mana pun yang membutuhkan, dan secara otomatis mengupdate UI jika terjadi perubahan, tanpa harus *passing* data secara manual dari satu widget ke widget lainnya. Widget-widget ini nanti dihubungkan oleh Controller, yang akan kita bahas kemudian.

Dengan kata lain, state management membantu kita membangun **aplikasi** **yang lebih terstruktur, mudah dirawat, dan** ***scalable*****.**


![Gambar 8.2 Alur detail implementasi State Management pada kasus E-Commerce](images/modul_8/img_p3_2_24.png)
*Gambar 8.2 Alur detail implementasi State Management pada kasus E-Commerce*

### B. Apa itu Reaktivitas?

Jika membahas state management, kita tidak bisa lepas dari konsep **reaktivitas**. Reaktivitas adalah kemampuan UI untuk **memperbarui dirinya secara** **otomatis** ketika data yang digunakannya berubah, tanpa perlu dipanggil ulang secara manual seperti setState().

Sebenarnya, Flutter sudah punya mekanisme bawaan untuk mendukung konsep ini, namanya **ValueNotifier** dan **ValueListenableBuilder**. Dua-duanya tidak butuh package tambahan, dan bisa langsung dipakai. Kalau masih ingat, kita sudah pernah menggunakannya di **Modul VI - Local Storage.**

##### Contoh Program 8.1 Penggunaan ValueNotifier dan ValueListenableBuilder

```dart
// masukkan sebelum return didalam Widget build() 
    final ValueNotifier<int> counter = ValueNotifier<int>(0); 
    
       // masukkan didalam Column 
            ValueListenableBuilder<int>( 
              valueListenable: counter, 
              builder: (context, value, _) { 
                return Text('$value'); 
              }, 
            ), 
            ElevatedButton( 
              onPressed: () => counter.value++, 
              child: Text("Increment"), 
            ),
```

Pada contoh di atas, ValueListenableBuilder akan **mendengarkan** perubahan nilai dari ValueNotifier. Ketika value **counter** berubah, hanya widget yang menggunakan value tersebut yang akan diperbarui. Artinya, yang di-render ulang hanya sebagian dari UI, **bukan seluruh halaman**. Ini sudah membuat mekanisme ini lebih efisien dari **setState()**.

Tapi, **ValueNotifier** punya keterbatasan. Ia cocok untuk satu variabel sederhana (misalnya int atau bool), tapi kurang praktis dalam **mengelola banyak** **state** sekaligus. Ia juga tidak menyediakan cara mudah untuk **mengakses data** **yang sama** dari page yang berbeda.

Maka dari itu, karena berbagai keterbatasan yang Flutter miliki mengenai state management, para developer pun mengembangkan berbagai *package* **state** **management.** Diantaranya ada Provider, Riverpod, Bloc, dan lain-lain. Namun pada

modul ini, kita akan fokus membahas sebuah state manager yang cukup populer sebab kemudahan dan fitur yang dimilikinya, yaitu **GetX.** Kenapa GetX? *Check it out!*

### C. Package GetX


![Gambar 8.3 Logo GetX](images/modul_8/img_p4_2_28.png)
*Gambar 8.3 Logo GetX*

GetX adalah sebuah *package* Flutter yang menawarkan tiga pilar solusi utama: ***state management***, ***routing*** (navigasi), dan ***dependency injection*** dalam satu framework yang ringan dan efisien. GetX dirancang untuk mengurangi *boilerplate code* serta memudahkan pengembang dalam mengelola state secara **reaktif**, melakukan navigasi **tanpa** ***context*****,** dan mengatur **dependensi secara** **terpusat**. Dengan performa yang baik dan konsep yang sederhana, GetX sangat cocok untuk skala aplikasi kecil hingga menengah, sekaligus sangat sesuai untuk kebutuhan pembelajaran dalam modul praktikum. Sebagai pembanding, disediakan tabel perbandingan GetX dengan *package* lain yang memiliki fungsi serupa:

**Tabel 8.1** Perbandingan GetX dengan state manager populer lainnya **Aspek** 
**GetX** 
**Provider** 
**BLoC** Konsep Utama 
State management 
reaktif, routing, dan 
dependency 
injection dalam satu 
package State management 
berbasis Inherited 
Widget State management 
berbasis event dan 
stream Tingkat 
Kompleksitas Rendah 
Rendah–Menengah 
Tinggi *Boilerplate* Code 
Sangat sedikit 
Sedikit 
Banyak Cara Mengelola 
State Controller & variabel 
reaktif (Rx) ChangeNotifier / 
Consumer Event → State 
(Stream) Cocok untuk Skala 
Aplikasi Kecil hingga 
menengah Kecil hingga 
menengah Menengah hingga 
besar Kebutuhan 
Context Tidak selalu 
diperlukan Diperlukan 
Diperlukan **Kesesuaian** 
**untuk Praktikum** **Sangat cocok** 
**Cocok** 
**Kurang cocok** 
**(terlalu kompleks)** Berikut ini uraian dan contoh penggunaan sederhana untuk masing-masing fitur utama GetX:

#### 1. State Management

GetX mendukung state management reaktif yang memungkinkan perubahan data (state) secara otomatis memperbarui tampilan (UI) tanpa perlu memanggil ulang `setState()`. Kuncinya ada pada dua hal: **variabel** **reaktif** dan widget **Obx()**.

Variabel reaktif dibuat dengan menambahkan **.obs** di akhir nilai awal variabel. Dengan .obs, GetX tahu bahwa variabel ini **perlu "diawasi"**. Setiap kali nilainya berubah, UI yang menggunakannya akan otomatis **diperbarui**.

##### Contoh Program 8.2 Membuat Variabel Reaktif

```dart
RxInt _counter = 0.obs;     // integer reaktif 
RxString _name = ''.obs;    // string reaktif 
RxBool _isLoading = false.obs; // boolean reaktif 
RxList<Product> _products = <Product>[].obs; // list reaktif
```

Agar UI yang kita bangun dapat "*mendengarkan*" perubahan yang

```dart
terjadi terhadap variabel reaktif tersebut kalian bisa gunakan widget Obx()
```

dari *package* GetX. Namun, untuk memanggil isi dari variabel yang kita buat reaktif yaitu dengan mengambil properti "value" nya seperti pada contoh di bawah.

##### Contoh Program 8.3 Penggunaan Widget Obx()

```dart
// Masukkan di dalam build(), misalnya di dalam Column 
            Obx(() => Text( 
              '${_counter.value}', 
              style: Theme.of(context).textTheme.headlineMedium, 
            )),
```

Yang perlu diperhatikan adalah, **Obx()** hanya **membungkus** widget yang benar-benar menggunakan variabel reaktif tersebut, bukan seluruh halaman. Ini membuat rendering menjadi lebih efisien karena **hanya bagian** **kecil UI yang dirender ulang,** bukan semua widget sekaligus.

Dengan kombinasi **variabel reaktif** dan **Obx(),** kita bahkan bisa memakai StatelessWidget untuk halaman yang sebelumnya membutuhkan StatefulWidget loh! Ini karena manajemen state sudah ditangani oleh GetX, bukan oleh widget itu sendiri.

##### Contoh Program 8.4 Source Code Full pada Stateless Widget

```dart
class MyHomePage extends StatelessWidget { 
  MyHomePage({super.key, required this.title}); 
  final String title; 
  final RxInt _counter = 0.obs; 
  void _incrementCounter() { 
    _counter.value++; 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        backgroundColor: 
Theme.of(context).colorScheme.inversePrimary, 
        title: Text(title), 
      ), 
      body: Center( 
        child: Column( 
          mainAxisAlignment: .center, 
          children: [ 
            const Text('You have pushed the button this many 
times:'), 
            Obx(() => Text( 
              '${_counter.value}', 
              style: Theme.of(context).textTheme.headlineMedium, 
            )), 
          ], 
        ), 
      ), 
      floatingActionButton: FloatingActionButton( 
        onPressed: _incrementCounter, 
        tooltip: 'Increment', 
        child: const Icon(Icons.add), 
      ), 
    ); 
  } 
}
```


![Gambar 8.4 setState() vs Obx()](images/modul_8/img_p7_2_37.png)
*Gambar 8.4 setState() vs Obx()*

#### 2. Pemisahan Logika dengan UI (Controller)

Salah satu kelebihan GetX yang paling terasa adalah kemudahan dalam memisahkan logika aplikasi dari UI. Pada contoh sebelumnya, **logika** **dan tampilan** (build()) berada di dalam satu class yang sama. Namun semakin kompleks aplikasi, akan semakin "berantakan" class tersebut.

Dengan menggunakan GetX, logika aplikasi ditempatkan ke dalam kelas khusus bernama **Controller**, yang menyimpan variabel reaktif dan semua 
method 
yang 
memanipulasinya. 
Sedangkan 
widget 
hanya bertanggung jawab menampilkan data, tidak lagi mengurus logika.

Pendekatan ini sejalan dengan prinsip arsitektur modern seperti **MVC** (Model-View-Controller) dan **MVVM** (Model-View-ViewModel).

##### Contoh Program 8.5 Controller GetX

```dart
import 'package:get/get.dart'; 
 
class CounterController extends GetxController { 
  final RxInt _counter = 0.obs; 
  int get counter => _counter.value; 
 
  void incrementCounter() { 
    _counter.value++; 
  } 
}
```

Perhatikan bahwa CounterController mewarisi GetxController. Ini memberikan controller akses ke berbagai fitur lifecycle. Lifecycle method memudahkan kita mengatur apa yang terjadi saat controller pertama kali dibuat hingga dihapus dari memori. Berikut adalah contoh lifecycle method:

**Tabel 8.2** Lifecycle Method pada GetX **Lifecycle Method** 
**Keterangan Singkat** `onInit()` 
Dipanggil saat controller pertama kali dibuat. 
Biasanya digunakan untuk inisialisasi data, 
pemanggilan API, atau pengaturan state awal.

`onReady()` 
Dipanggil setelah UI selesai dirender. Cocok 
digunakan untuk proses yang membutuhkan tampilan 
sudah siap, seperti menampilkan dialog atau 
snackbar.

`onClose()` 
Dipanggil saat controller dihapus dari memori. 
Digunakan untuk membersihkan resource seperti 
listener, stream, atau timer.

Misalnya, jika ingin langsung mengambil data dari API begitu controller dibuat, kita cukup memanggil function fetch tersebut di dalam **onInit().** Ini setara dengan initState() pada StatefulWidget, namun kini logikanya sudah terpisah rapi di dalam controller.

##### Contoh Program 8.6 Menggunakan onInit() pada Controller

```dart
class ProductController extends GetxController { 
  final RxList<Product> _products = <Product>[].obs; 
  final RxBool _isLoading = false.obs; 
  List<Product> get products => _products; 
  bool get isLoading => _isLoading.value; 
 
  @override 
  void onInit() { 
    fetchProducts(); // Langsung ambil data saat controller dibuat 
    super.onInit(); 
  } 
  Future<void> fetchProducts() async { 
    _isLoading.value = true; 
    // ... proses pengambilan data 
    _isLoading.value = false; 
  } 
}
```

#### 3. Dependency Injection

Setelah membuat Controller, kita perlu cara untuk menggunakannya di widget. Di sinilah fitur **dependency injection** (DI) GetX berperan.

Analoginya, DI itu seperti **gudang**. Kita menitipkan objek controller ke

```dart
GetX (Get.put()), dan kapanpun kita butuh controller tersebut dari mana saja
```

dalam aplikasi, tinggal mengambilnya (**Get.find()**). Tidak perlu membuat ulang objek yang sama berkali-kali, dan tidak perlu melempar controller dari satu widget ke widget lain melalui constructor. Tabel di bawah ini menjelaskan bagaimana controller didaftarkan.

```dart
Tabel 8.3 Get.put() dan Get.find()
```

**Dependency Injection** 
**Fungsi**

```dart
Get.put() 
Membuat dan menyimpan instance controller.
```

Biasanya ini dilakukan sekali setiap satu *controller.* `Get.find()` 
Mengambil *instance controller* yang sudah terdaftar.

```dart
Get.put() biasanya dipanggil di dalam widget yang pertama kali
```

**membutuhkan controller tersebut**, misalnya saat halaman pertama kali dibuka. Setelah controller terdaftar, widget lain di mana pun bisa mengaksesnya melalui Get.find() tanpa perlu tahu controller itu dibuat di mana.

Ini adalah contoh penggunan method DI, dari Controller yang telah kita buat di Contoh Program 8.5:

```dart
Contoh Program 8.7 Penggunaan Get.put() dan Get.find() 
// Di halaman utama mendaftarkan controller 
class ProductPage extends StatelessWidget { 
  ProductPage({super.key}); 
 
  // Get.put() membuat dan mendaftarkan controller 
  final ProductController controller = Get.put(ProductController()); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: Obx(() => controller.isLoading 
        ? const CircularProgressIndicator() 
        : ListView.builder(...) 
      ), 
    ); 
  } 
} 
// Di widget lain — mengambil controller yang sudah terdaftar 
final controller = Get.find<ProductController>();
```


![Gambar 8.4 Mekanisme DI](images/modul_8/img_p10_2_46.png)
*Gambar 8.4 Mekanisme DI*

Ini sangat berguna ketika satu controller perlu diakses dari banyak tempat berbeda, misalnya e-commerce tadi. Controller keranjang belanja dibutuhkan oleh page produk, page list keranjang, sekaligus AppBar. Cukup

```dart
satu Get.put(), sisanya tinggal Get.find().
```

#### 4. Routing/Navigation

Selain state management dan dependency injection, GetX juga menyediakan sistem navigasi yang **tidak bergantung pada context**, sehingga mempermudah perpindahan antar halaman. Di bawah ini penggunaan navigasi GetX dan perbandingannya dengan *Navigator*.

**Tabel 8.4** Navigasi GetX **Kebutuhan Navigasi** 
**GetX** 
**Navigator (Tanpa GetX)**

```dart
Get.to(Page()) 
Navigator.push(context,
```

Pindah ke halaman baru

```dart
MaterialPageRoute(builder: (_) 
=> Page())) 
Get.back() 
Navigator.pop(context)
```

Kembali ke halaman sebelumnya

```dart
Get.off(Page()) 
Navigator.pushReplacement(conte
```

Pindah dan hapus halaman sebelumnya

```dart
xt, MaterialPageRoute(builder: 
(_) => Page())) 
Get.offAll(Page()) 
Navigator.pushAndRemoveUntil(co
```

Pindah dan hapus semua halaman

```dart
ntext,
```

sebelumnya

```dart
MaterialPageRoute(builder: (_) 
=> Page()), (route) => false) 
Get.to(Page(), 
Navigator.push(context,
```

Mengirim data ke halaman tujuan

```dart
arguments: data) 
MaterialPageRoute(builder: (_) 
=> Page(data: data))) 
Get.back(result: data) 
Navigator.pop(context, data)
```

Menerima data dari halaman sebelumnya Navigasi tanpa context 
Bisa 
Tidak bisa Terlihat jelas bahwa sintaks GetX jauh lebih ringkas dibandingkan navigasi bawaan dari Flutter.

Namun yang patut diperhatikan agar GetX bisa mengambil alih sistem navigasi, yakni kita harus mengganti **MaterialApp** menjadi **GetMaterialApp** di **main.dart**. Cukup dengan perubahan kecil ini, seluruh fitur navigasi GetX sudah bisa digunakan.

##### Contoh Program 8.8 Menggunakan GetMaterialApp di main.dart

```dart
Widget build(BuildContext context) { 
    return GetMaterialApp( // Ganti MaterialApp menjadi 
GetMaterialApp 
      title: 'My App', 
      home: ProductPage(), 
    ); 
  } 
Selain navigasi langsung dengan Get.to(), GetX juga mendukung
```

***named routes***, yaitu sistem navigasi berbasis **nama string** yang terdaftar secara terpusat. Pendekatan ini lebih *scalable* karena seluruh daftar halaman dan hubungannya **dikelola di satu tempat,** bukan tersebar di seluruh kode.

Named routes di GetX didefinisikan menggunakan **GetPage** dan didaftarkan melalui parameter **getPages di GetMaterialApp**. Navigasinya dilakukan dengan **Get.toNamed()** yang cukup menerima nama route sebagai **argumen**.

##### Contoh Program 8.9 Mendefinisikan Named Routes

```dart
// Di GetMaterialApp 
return GetMaterialApp( 
  title: 'My App', 
  initialRoute: '/products', 
  getPages: [ 
    GetPage(name: '/products', page: () => ProductPage()), 
    GetPage(name: '/detail',   page: () => ProductDetailPage()), 
  ], 
); 
 
// Navigasi ke halaman menggunakan nama route 
Get.toNamed('/detail');
```

Jadi *advantage* utama named routes adalah konsistensi. Nama route cukup didefinisikan sekali dan bisa dipakai dimana saja. Biasanya nama-nama route ini **dikumpulkan dalam satu file** agar mudah dikelolanya.

Jika 
ingin 
passing 
data 
dengan 
Get.toNamed(), 
kita dapat menggunakan arguments. Namun **Get.toNamed()** hanya dapat menerima **satu** parameter arguments, sehingga jika ingin mengirim banyak data, harus **dibungkus** dalam satu object seperti **Map atau class.**

##### Contoh Program 8.10 Mengirim satu data  sebagai arguments

##### Contoh Program 8.11 Mengirim lebih dari satu  data menggunakan Map

```dart
Get.toNamed('/detail', arguments: 
product); 
Get.toNamed('/detail', arguments: { 
  'product': product, 
  'fromCart': true, 
});
```

Data yang dipassing dari Get.toNamed() dapat **diambil** di page tujuan menggunakan **Get.arguments,** bukan lewat constructor seperti biasa. Jika multi-parameter dan berbentuk Map, data diakses menggunakan key.

##### Contoh Program 8.12 Menerima 1 parameter  Contoh Program 8.13 Menerima multi-parameter

```dart
class ProductDetailPage extends 
StatelessWidget { 
  ProductDetailPage({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    final product = Get.arguments as 
Product; 
 
    return Scaffold( 
      appBar: AppBar(title: Text('Detail 
Product')), 
      body: Column( 
        children: [ 
          Text(product.name), 
          Text('Harga: 
${product.price}'), 
        ], 
      ), 
    ); 
  } 
} 
class ProductDetailPage extends 
StatelessWidget { 
  ProductDetailPage({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    final args = Get.arguments as 
Map<String, dynamic>; 
 
    final product = args['product'] as 
Product; 
    final bool fromCart = args['fromCart']; 
 
    return Scaffold( 
      appBar: AppBar(title: Text('Detail 
Product')), 
      body: Column( 
        children: [ 
          Text(product.name), 
          Text('Harga: ${product.price}'), 
          Text(fromCart ? 'Dari Cart' : 
'Bukan dari Cart'), 
        ], 
      ), 
    ); 
  } 
}
```

#### 5. Binding

Oke, kita sudah tahu mengenai tiga pilar GetX, juga paham konsep penggunaan Controller. Namun masih terdapat materi tambahan yang bagus nih untuk diketahui! Sejauh ini kan kita mendaftarkan controller menggunakan

```dart
Get.put() langsung di dalam widget. Cara ini memang bisa, namun ada
```

pendekatan yang lebih terstruktur dan idiomatis dalam GetX, yaitu melakukan **pendaftaran** controller tersebut melalui **Binding**.

Binding adalah class khusus yang bertanggung jawab untuk mendaftarkan **(*****inject*****) controller** yang dibutuhkan suatu page, **sebelum** halaman tersebut ditampilkan. Dengan kata lain, Binding **memastikan** semua dependensi yang dibutuhkan sebuah page **sudah siap ketika halaman itu** **dibuka.** Kebetulannya, binding sangat bersinergi dengan **named routes**.

Ketika kita mendefinisikan **GetPage**, kita bisa menambahkan **parameter** **binding** yang secara otomatis dijalankan sebelum page tersebut dirender.

Berikut adalah contoh binding:

##### Contoh Program 8.14 Membuat Binding

```dart
import 'package:get/get.dart'; 
import 'product_controller.dart'; 
 
class ProductBinding extends Bindings { 
  @override 
  void dependencies() { 
    // Get.lazyPut hanya membuat instance saat pertama kali 
dibutuhkan 
    Get.lazyPut<ProductController>(() => ProductController()); 
  } 
} 
Biasanya, 
ketimbang 
Get.put(), 
pada 
binding 
penggunaan 
Get.lazyPut() lebih direkomendasikan. Karena berbeda dengan Get.put()
```

yang langsung membuat instance, Get.lazyPut() bersifat *lazy* (malas/tidak langsung bertindak), sehingga instance baru dibuat hanya ketika **pertama** **kali** controller tersebut **diakses**. Ini lebih efisien untuk memori.

Setelah Binding dibuat, barulah kita daftarkan ke GetPage yang sesuai:

##### Contoh Program 8.15 Menghubungkan Binding ke Named Route

```dart
getPages: [ 
  GetPage( 
    name: '/products', 
    page: () => ProductPage(), 
    binding: ProductBinding(), // Binding otomatis dijalankan 
sebelum halaman dibuka 
  ), 
  GetPage( 
    name: '/detail', 
    page: () => ProductDetailPage(), 
    // Tidak perlu Binding tersendiri jika controller sudah 
terdaftar sebelumnya 
  ), 
],
```

Dengan Binding, widget/halaman tidak perlu lagi **memanggil**

```dart
Get.put() sendiri. Cukup gunakan Get.find() di dalam widget untuk
```

mengakses controller yang sudah didaftarkan oleh Binding-nya. Mudah kan?

Untuk dokumentasi lengkap tentang semua fitur GetX, kalian dapat mengaksesnya di *https://pub.dev/packages/get*.

## IV. Langkah Praktikum

Pada langkah praktikum kali ini, kita akan membangun sebuah aplikasi sederhana yang **menampilkan daftar produk dari API**, beserta halaman detail produknya. Melalui proses pembangunan aplikasi ini, kita akan mempraktekkan ketiga pilar GetX secara langsung: ***state management***, ***dependency injection***, dan ***routing***.

### A. Persiapan Project

1. Buat *project* flutter baru pada PC/Laptop masing-masing.

2. Buka *project* folder yang sudah dibuat pada VSCode, lalu install dependency (package) **get** untuk GetX dan **http** untuk pemakaian API. Masukkan ini di terminal.

```bash
flutter pub add get 
flutter pub add http
```

Atau bisa ditambahkan melalui file *pubspec.yaml.*


![Gambar 8.5 Dependency pada pubspec.yaml](images/modul_8/img_p16_2_60.png)
*Gambar 8.5 Dependency pada pubspec.yaml*

3. Agar rapi, buat struktur folder dan file seperti berikut ini. Atau bisa disesuaikan namanya sesuai dengan preferensi masing-masing.


![Gambar 8.6 Struktur Folder](images/modul_8/img_p16_3_61.png)
*Gambar 8.6 Struktur Folder*

4. Jika menggunakan kodingan template, hapus MyHomePage di main.dart. Ganti MaterialApp menjadi **GetMaterialApp**. Ini adalah langkah wajib agar seluruh fitur GetX, terutama navigasi, bisa berjalan dengan baik (import getx).

##### Contoh Program 8.16 main.dart

```dart
// di main.dart 
  Widget build(BuildContext context) { 
    return GetMaterialApp(  // ← Ganti dari MaterialApp 
      title: 'GetX App', 
      debugShowCheckedModeBanner: false, 
      home: ProductPage(), 
    ); 
  }
```

Lalu untuk sekarang kita sekalian tambahkan ProductPage sebagai home. Jika error tidak apa-apa.

### B. Membuat Model Produk

Kita akan membuat model produk untuk mempermudah pengelolaan data yang di*retrieve* dari API. Untuk endpoint API nya menggunakan link berikut: https://dummyjson.com/products. Namun, kita hanya ambil beberapa properti saja, tidak semuanya.

1. Pada file **model/product.dart**, buat class Product dengan factory constructor fromJson() untuk mengonversi data JSON menjadi objek Dart:

##### Contoh Program 8.17 model/product.dart

```dart
class Product { 
  final int id; 
  final String title; 
  final String description; 
  final double price; 
  final double rating; 
  final int stock; 
  final String brand; 
  final List<dynamic> tags; 
  final List<dynamic> images; 
  final List<dynamic> reviews; 
   
  Product({ 
    required this.id, 
    required this.title, 
    required this.description, 
    required this.price, 
    required this.rating, 
    required this.stock, 
    required this.brand, 
    required this.tags, 
    required this.images, 
    required this.reviews, 
  }); 
  factory Product.fromJson(Map<String, dynamic> jsonData){ 
    return Product( 
      id: jsonData['id'],  
      title: jsonData['title'] ?? '',  
      description: jsonData['description'] ?? '',  
      price: jsonData['price'] ?? '',  
      rating: jsonData['rating'] ?? '',  
      stock: jsonData['stock'] ?? '',  
      brand: jsonData['brand'] ?? '',  
      tags: jsonData['tags'] ?? [],  
      images: jsonData['images'] ?? [],  
      reviews: jsonData['reviews'] ?? [] 
    ); 
  } 
}
```

### C. Membuat Service

Service tugasnya hanya satu, komunikasi dengan API. Ia tidak tahu apa-apa mengenai state ataupun tampilan. Tanggung jawabnya hanya ***fetch*** dan ***parse***.

1. Pada **service/product_service.dart**, buat class ProductService dengan satu method untuk mengambil data produk dari API:

##### Contoh Program 8.18 service/product_service.dart

```dart
import 'dart:convert'; 
import '../model/product.dart'; 
import 'package:http/http.dart' as http; 
 
class ProductService { 
  final Uri _url = Uri.parse("https://dummyjson.com/products"); 
 
  Future<List<Product>> fetchProducts() async { 
    final response = await http.get(_url); 
    final result = jsonDecode(response.body); 
 
    final List<dynamic> products = result['products']; 
 
    return products.map((product) => 
Product.fromJson(product)).toList(); 
  } 
}
```

### D. Membuat Controller

Controller menyimpan state (data yang perlu **diawasi** **akan perubahannya**) dan logika (cara memanipulasi data tersebut). Widget tidak perlu tahu bagaimana data didapat, cukup dengan mengambil datanya dari controller dan menampilkannya.

1. Buka **controller/product_controller.dart**, lalu buat ProductController yang mewarisi GetxController dan mengambil data dari **service**:

##### Contoh Program 8.19 Product Controller

```dart
import 'package:get/get.dart'; 
import '../model/product.dart'; 
import '../service/product_service.dart'; 
 
class ProductController extends GetxController {

  // Dependency 
  final ProductService _productService = ProductService();

  // State (variabel reaktif) 
  final RxList<Product> _products = <Product>[].obs; 
  final RxBool _isLoading = false.obs;

  // Getter (akses dari luar pakai dot notation) 
  List<Product> get products => _products; 
  bool get isLoading => _isLoading.value; 
   
  // Lifecycle 
  @override 
  void onInit(){ 
    _retrieveData(); 
    super.onInit(); 
  }

  // Logika (mengambil data dari API untuk ditampilkan di UI) 
  Future<void> _retrieveData() async { 
    try { 
      _isLoading.value = true; 
       
      final data = await _productService.fetchProducts(); 
      _products.assignAll(data); 
 
      _isLoading.value = false; 
    } catch (e){ 
      throw Exception(e.toString()); 
    } 
  } 
}
```

**Penjelasan Properti** Properti 
Fungsi

```dart
_RxList _products = [].obs
```

Untuk menyimpan data produk-produk 
yang di*retrieve* dari API `RxBool _isLoading = false.obs` 
Properti untuk digunakan untuk proses 
*loading*.

```dart
final ProductService 
_productService = 
ProductService();
```

Instance dari class ProductService()

### E. Membuat Tampilan

Setelah model, service, dan controller siap, sekarang saatnya membuat antarmukanya (UI). Yang perlu diingat adalah, widget hanya bertugas menampilkan data dari controller, tidak boleh ada logika di sini.

1. Pertama-tama, buka **view/widgets/product_card.dart**. Untuk produk kita buat terlebih dahulu cardnya sebagai widget tersendiri agar *modular* & ***reusable***. Tampilkan gambar produk, nama produk, dan harga.

##### Contoh Program 8.20 view/widgets/product_card.dart

```dart
import 'package:flutter/material.dart'; 
import '../../model/product.dart'; 
 
class ProductCard extends StatelessWidget { 
  const ProductCard({ 
    super.key, 
    required this.product, 
    required this.onTap, 
  }); 
 
  final Product  product; 
  final VoidCallback onTap; 
 
  @override 
  Widget build(BuildContext context) { 
    return GestureDetector( 
      onTap: onTap, 
      child: Card( 
        color: Colors.blueGrey, 
        elevation: 3, 
        shape: RoundedRectangleBorder( 
          borderRadius: BorderRadius.circular(10), 
        ), 
        child: Column( 
          children: [ 
            Flexible( 
              flex: 2, 
              child: Image.network( 
                product.images[0], 
                fit: BoxFit.contain, 
                loadingBuilder: (context, child, loadingProgress) { 
                  if (loadingProgress == null) return child; 
                  return const Center( 
                    child: CircularProgressIndicator(color: 
Colors.white), 
                  ); 
                }, 
              ), 
            ), 
            Flexible( 
              child: Container( 
                width: double.infinity, 
                decoration: const BoxDecoration( 
                  color: Colors.white, 
                  borderRadius: BorderRadius.only( 
                    bottomLeft:  Radius.circular(10), 
                    bottomRight: Radius.circular(10), 
                  ), 
                ), 
                padding: const EdgeInsets.all(8), 
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  crossAxisAlignment: CrossAxisAlignment.stretch, 
                  children: [ 
                    Text( 
                      product.title, 
                      overflow: TextOverflow.ellipsis, 
                      style: const TextStyle( 
                        fontWeight: FontWeight.bold, 
                        fontSize: 14, 
                      ), 
                    ), 
                    Text('${product.price}'), 
                  ], 
                ), 
              ), 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
}
```

2. Lalu, buat halaman untuk **list** produknya di **view/pages/product_page.dart**. Gunakan widget ProductCard tadi. Panggil *controller* dengan menggunakan

```dart
Get.put() pada halaman produk seperti contoh di bawah.
```

##### Contoh Program 8.21 Product Page

```dart
import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
import '../../controller/product_controller.dart'; 
import '../../view/widgets/product_card.dart'; 
 
class ProductPage extends StatelessWidget { 
  ProductPage({super.key}); 
 
  // Get.put() → mendaftarkan controller ke GetX 
  // Cukup sekali di sini; halaman lain tinggal Get.find() 
  final ProductController controller = Get.put(ProductController()); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: const Text('Product Home Page')), 
      body: Padding( 
        padding: const EdgeInsets.all(12), 
        // Obx() mendengarkan semua variabel reaktif di dalamnya. 
        // Hanya bagian ini yang dirender ulang saat state berubah. 
        child: Obx(() { 
          if (controller.isLoading) { 
            return const Center( 
              child: CircularProgressIndicator(color: 
Colors.blueGrey), 
            ); 
          } 
          return GridView.builder( 
            itemCount: controller.products.length, 
            gridDelegate: 
                const SliverGridDelegateWithFixedCrossAxisCount( 
              crossAxisCount:   2, 
              crossAxisSpacing: 8, 
              mainAxisSpacing:  8, 
            ), 
            itemBuilder: (context, index) { 
              return ProductCard( 
                product: controller.products[index], 
                onTap: () { 
                  // Masih kosong 
                }, 
              ); 
            }, 
          ); 
        }), 
      ), 
    ); 
  } 
}
```

Setelah itu, jika belum, **import** *Product Page* ke main.dart.


![Gambar 8.7 Hasil Tampilan Product Page](images/modul_8/img_p23_2_78.png)
*Gambar 8.7 Hasil Tampilan Product Page*

3. Setelah selesai membuat *Product Page*, selanjutnya membuat ***Product*** ***Detail Page***. Ketika di *Product Page* melakukan *tap* pada salah satu produk maka akan berpindah ke halaman detail yang menampilkan keseluruhan properti detail atau data dari produk tersebut, yang telah kita susun di model Product. Untuk perbedaannya pada kali ini akan menggunakan fitur navigasi dari GetX. Buat dahulu halaman untuk detail produknya.

##### Contoh Program 8.22 view/pages/product_detail_page.dart

```dart
import 'package:flutter/material.dart'; 
import '../../model/product.dart'; 
class ProductDetailPage extends StatelessWidget { 
  const ProductDetailPage({super.key, required this.product}); 
  final Product product; 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      backgroundColor: Colors.white, 
      appBar: AppBar( 
        backgroundColor: Colors.white, 
        title: Text("Detail"), 
      ), 
      body: SingleChildScrollView( 
        child: Padding( 
          padding: EdgeInsets.all(12), 
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [ 
              SizedBox( 
                height: MediaQuery.of(context).size.height * 0.25, 
                width: double.infinity, 
                child: Center( 
                  child: product.images.length > 1 ? 
ListView.separated( 
                    itemCount: product.images.length, 
                    scrollDirection: Axis.horizontal, 
                    itemBuilder: (context, index){ 
                      return Card( 
                        elevation: 3, 
                        color: Colors.white, 
                        child: Image.network(product.images[index]) 
                      ); 
                    }, 
                    separatorBuilder: (context, index) => 
SizedBox(width: 10,), 
                  ) :  
                  Card( 
                    elevation: 3, 
                    color: Colors.white, 
                    child: Image.network(product.images[0], width: 
double.infinity,) 
                  ), 
                ), 
              ), 
              SizedBox(height: 20,), 
              Text( 
                product.title, 
                style: TextStyle( 
                  fontWeight: FontWeight.bold, 
                  fontSize: 20 
                ), 
              ), 
              Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [ 
                  Text( 
                    "\$${product.price}", 
                    style: TextStyle( 
                      fontSize: 16 
                    ), 
                  ), 
                  Text("⭐️ ${product.rating}") 
                ], 
              ), 
              Text("Stock: ${product.stock}"), 
              SizedBox(height: 10,), 
              Text(product.description, textAlign: 
TextAlign.justify,), 
              SizedBox(height: 10,), 
              SingleChildScrollView( 
                scrollDirection: Axis.horizontal, 
                child: Row( 
                  spacing: 8, 
                  children: product.tags.map((tag) => Chip(label: 
Text(tag))).toList(), 
                ), 
              ), 
              SizedBox(height: 20,), 
              Text( 
                "Reviews", 
                style: TextStyle( 
                  fontWeight: FontWeight.bold, 
                  fontSize: 19 
                ), 
              ), 
              Column( 
                children: product.reviews.map((review){ 
                  return ListTile( 
                    leading: CircleAvatar(child: 
Text(review['reviewerName'].toString().substring(0,1)),), 
                    trailing: Text( 
                      "${review['rating']}⭐️", 
                      style: TextStyle( 
                        fontSize: 18, 
                        fontWeight: FontWeight.w500 
                      ), 
                    ), 
                    title: Text(review['reviewerName']), 
                    subtitle: Text(review['comment']), 
                  ); 
                }).toList(), 
              ) 
            ], 
          ), 
        ), 
      ), 
    ); 
  } 
}
```

Lalu, modifikasi function ***onTap*** pada *Product Page*. Tambahkan syntax navigasi GetX seperti di bawah ini (import product_detail_page.dart).

##### Contoh Program 8.23 Product Card (product_page.dart)

```dart
onTap: () { 
                  Get.to( 
                    () => 
                        ProductDetailPage(product: 
controller.products[index]), 
                  ); 
                },
```

Berikut hasil dari tampilan *Product Detail Page*:


![Gambar 8.8 Hasil Tampilan Product Detail Page](images/modul_8/img_p26_2_88.png)
*Gambar 8.8 Hasil Tampilan Product Detail Page*

### F. Named Routes dan Binding (Best practice)

```dart
Sejauh ini navigasi kita masih menggunakan Get.to() dan data dikirim melalui
```

constructor. Sekarang kita akan melakukan refactor untuk menerapkan **named** **routes dan Binding**, sehingga struktur aplikasi menjadi lebih terorganisir.

1. Buka file **routes/app_routes.dart** untuk menyimpan semua nama route, sebagai **wadah konstanta global**. Nama ruote jadi terdefinisi di satu tempat dan tidak perlu ditulis **ulang** sebagai string di mana-mana. Keyword **abstract** adalah supaya class ini tidak dimaksudkan untuk dibuat **objek (instance)**, tapi hanya untuk akses static.

##### Contoh Program 8.24 routes/app_routes.dart

```dart
abstract class AppRoutes { 
  static const String products = '/products'; 
  static const String detail   = '/detail'; 
}
```

2. Di routes/app_pages.dart, **daftarkan** semua halaman beserta **Binding-nya**. Di file ini, setiap route dihubungkan ke widget halaman dan Binding yang bersesuaian.

##### Contoh Program 8.25 routes/app_pages.dart

```dart
import 'package:get/get.dart'; 
import '../controller/product_controller.dart'; 
import '../view/pages/product_detail_page.dart'; 
import '../view/pages/product_page.dart'; 
import 'app_routes.dart'; 
 
// Binding untuk ProductPage 
class ProductBinding extends Bindings { 
  @override 
  void dependencies() { 
    Get.lazyPut<ProductController>(() => ProductController()); 
  } 
} 
// Daftar semua halaman/route dalam aplikasi 
class AppPages { 
  static final routes = [ 
    GetPage( 
      name: AppRoutes.products, 
      page: () => ProductPage(), 
      binding: ProductBinding(), 
    ), 
    GetPage( 
      name: AppRoutes.detail, 
      page: () => ProductDetailPage(), 
    ), 
  ]; 
}
```

Disini, akan **terjadi error** karena ProductDetailPage() memiliki parameter **required**. Tidak apa, dibiarkan dahulu.

3. Update 
main.dart 
untuk 
menggunakan 
getPages 
dan 
initialRoute, menggantikan **home** yang sebelumnya (import AppRoutes & AppPages).

##### Contoh Program 8.26 main.dart (setelah refactor)

```dart
return GetMaterialApp( 
      title: 'GetX App', 
      debugShowCheckedModeBanner: false, 
      initialRoute: AppRoutes.products, // route awal aplikasi 
      getPages: AppPages.routes,         // daftar semua route 
);
```

4. Karena controller sekarang sudah didaftarkan oleh ProductBinding, **ganti**

```dart
Get.put() di product_page.dart menjadi Get.find(). Widget cukup mengambil
```

controller yang sudah siap menggunakan Get.find().

```dart
Contoh Program 8.27 Ubah Get.put() menjadi Get.find() di product_page.dart 
class ProductPage extends StatelessWidget { 
  ProductPage({super.key}); 
    final ProductController controller = 
Get.find<ProductController>();
```

5. Update bagian navigasi di **product_page.dart**. Sekarang data produk tidak lagi dikirim melalui constructor, melainkan menggunakan **Get.arguments.** Ganti **onTap** pada ProductCard menjadi seperti dibawah (import AppRoutes).

##### Contoh Program 8.28 Navigasi dengan Named Routes dan Get.arguments

```dart
onTap: () { 
  Get.toNamed( 
    AppRoutes.detail, 
    arguments: controller.products[index], 
  ); 
},
```

6. Terakhir, update product_detail_page.dart agar **menerima data** melalui **Get.arguments** alih-alih constructor. Dengan cara ini, halaman detail tidak lagi bergantung pada bagaimana data dikirimkan. Cukup ambil dari GetX.

##### Contoh Program 8.29 product_detail_page.dart (setelah refactor)

```dart
class ProductDetailPage extends StatelessWidget { 
  ProductDetailPage({super.key}); 
 
  // Ambil data dari Get.arguments yang dikirim saat navigasi 
  final Product product = Get.arguments as Product; 
 
  @override 
  Widget build(BuildContext context){//kode sama dengan sebelumnya} 
}
```

Hapus juga parameter required-nya, serta keyword const (import getx).

Memang kesannya menggunakan named routes dan binding bikin kode lebih banyak dan terasa lebih kompleks di awal. Tapi itu **trade-off** buat mengatasi masalah

```dart
yang baru terasa saat aplikasi mulai besar. Analoginya, Get.to() biasa kayak jalan
```

pintas, dan named routes + binding kayak bikin **jalan tol**. Jalan pintas enak sekarang, tapi lama-lama macet dan semrawut. Sementara jalan tol butuh effort di awal, tapi lancar buat jangka panjang. Oke! sekarang struktur project sudah lebih optimal! Jalankan project kembali! Untuk mengakses kodingan lengkap dari project ini, silahkan kunjungi repositori berikut: https://github.com/AndiZirahitaf/modul_8_prak_mobile.

## V. Tugas Praktikum

Tambahkan fitur **keranjang belanja** pada aplikasi yang telah dibuat. Fitur ini harus memanfaatkan state management, dependency injection, dan routing dari GetX yang sudah dipelajari. Kriterianya terdapat:

- CartController yang menyimpan daftar produk di keranjang menggunakan RxList.
Controller ini harus punya method untuk menambah produk, menghapus produk, dan menghitung total harga.

- Button "Tambahkan ke Keranjang" yang memanggil method dari CartController.
- Badge jumlah item keranjang di AppBar ProductPage menggunakan Obx(). Badge harus otomatis terupdate saat item ditambahkan.
- CartPage yang menampilkan daftar produk dalam keranjang beserta total harganya.
User juga dapat menghapus item dari keranjang dari page ini.

- Route untuk CartPage di AppPages, lengkap dengan Binding-nya.