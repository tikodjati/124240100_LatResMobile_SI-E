# Modul 5: HTTP REQUEST

## I. Tujuan Praktikum

- Memahami konsep penggunaan data dinamis.
- Mengetahui cara mengambil dari data API.
- Mengaplikasikan data yang diambil ke dalam aplikasi.
## II. Alokasi Waktu : 1 x Pertemuan = 120 menit

## III. Dasar Teori

### A. Data Dinamis dan API

Pada modul sebelumnya, kita telah belajar menampilkan list data ke UI. Namun, data tersebut masih statis. Sedangkan pada aplikasi nyata, data pada umumnya berasal dari server yang dapat **berubah** seiring waktu, dan tidak selalu sama setiap kali aplikasi dibuka. Sebagai contoh, pada aplikasi film, daftar film akan terus bertambah seiring rilisnya film-film baru, kan? Maka dari itu, aplikasi perlu untuk mampu mengambil data secara **dinamis** dari internet.

Untuk melakukannya, aplikasi sebagai ***client*** perlu berkomunikasi dengan **API (Application Programming Interface),** yang berperan sebagai penghubung antara aplikasi dan server. Singkatnya, aplikasi akan:

1. Meminta data ke API.

2. Menerima data dari server API.

3. Mengolah data tersebut untuk ditampilkan ke UI. Ketika aplikasi meminta data, aplikasi melakukan yang disebut dengan **HTTP** **Request** (mengirim permintaan data), server API memberikan **response** yaitu data yang aplikasi minta, yang mana dinamakan **HTTP Response** (memberikan data).


![Gambar 5.1 Client & Server](images/modul_5/img_p2_1_19.png)
*Gambar 5.1 Client & Server*

HTTP Request sendiri memiliki beberapa jenis metode yang menentukan apa yang ingin dilakukan terhadap data. Pada REST API, metode yang umum digunakan adalah:

**Tabel 5.1** Method HTTP Request **Method** 
**Fungsi** 
**Contoh penggunaan** GET 
Mengambil data dari server 
Menampilkan daftar produk POST 
Mengirim data baru ke server 
Buat akun, kirim komentar PUT 
Mengganti seluruh data yang ada 
Update profil user seluruhnya PATCH 
Memperbarui sebagian data 
Ubah hanya foto profil DELETE 
Menghapus data 
Hapus postingan Di modul ini, kita hanya menggunakan metode GET karena kita hanya perlu mengambil data. Metode lainnya dapat digunakan saat kalian memulai membuat fitur seperti form pendaftaran, edit profil, atau hapus data di aplikasi.

Perlu diketahui juga bahwa sebuah API biasanya memiliki banyak fungsi. Ada yang untuk mengambil daftar produk, ada yang untuk mengambil satu produk tertentu, ada yang untuk login, dan sebagainya. Setiap fungsi itu memiliki **alamat** **URL sendiri** yang disebut **endpoint**. Contohnya:

- https://dummyjson.com/products → endpoint untuk mengambil semua produk
- https://dummyjson.com/products/1 → endpoint untuk mengambil produk dengan id = 1
- https://dummyjson.com/auth/login → endpoint untuk login Jadi, endpoint adalah alamat spesifik yang mengarah ke satu fungsi tertentu dari sebuah API.
### B. Struktur JSON

Data atau response API paling umum diberikan dalam bentuk **JSON** **(JavaScript Object Notation).** Mari kita lihat contohnya:

##### Contoh Program 5.1 Contoh response JSON

```dart
{ 
  "products": [ 
    { 
      "id": 1, 
      "title": "iPhone 12 Pro" 
    }, 
    { 
      "id": 2, 
      "title": "Macbook Air M2" 
    } 
  ] 
}
```

Seperti yang kita lihat, JSON menggunakan kurung siku **[]** dan kurung kurawal **{}**. Ini karena JSON tersusun atas konsep **index** dan **key-value.** Dalam Dart, dua tipe untuk mewakilinya ialah **List** dan **Map**. **Contoh Sintaks** 
**Cara akses data** 
**Output**

```dart
List 
List<int> numbers = [1, 2, 
3]; 
numbers[0] 
1 
Map 
Map<String, dynamic> student 
= { 
  "id": 1, 
  "name": "William", 
  "major": "Computer Science" 
}; 
student["name"] 
William
```

*Gambar 5.2 List & Map*

Namun, bagaimana untuk mengakses data response API seperti diatas? Response API biasanya berbentuk **kombinasi** antara List dan Map. Ketika kita melakukan HTTP Request, response API akan melalui **jsonDecode()** terlebih dahulu untuk mengubah data string JSON mentah menjadi objek Dart (seperti Map atau List) sebelum akhirnya datanya bisa diakses. Jika response pada contoh program 5.1 demikian, maka jika di-**jsonDecode():**

##### Contoh Program 5.2 jsonDecode()

```dart
final data = jsonDecode(response.body);
```

Struktur datanya akan menjadi:


![Gambar 5.2 Struktur data dari API](images/modul_5/img_p4_1_28.png)
*Gambar 5.2 Struktur data dari API*

Sehingga, **data** itu sendiri adalah Map, **data['products']** adalah List, dan setiap **item** di dalam List adalah Map. Jadi, semisal ingin mengambil **title** dari produk pertama 
yaitu 
**iPhone**, 
kodenya 
adalah 
**data['products'][0]['title']**. 
Jika **data['products']** kita simpan terlebih dahulu di sebuah variabel, misalnya **products,** maka untuk pemanggilan tadi bisa disingkat menjadi **products[0]['title'].** Agar lebih jelas, berikut rangkuman alur datanya:

**Tabel 5.2** Alur penggunaan data dinamis **Tahapan** 
**Kodingan** 
**Data yang dimiliki / Output**

```dart
- 
{ 
  "products": [ 
    { 
      "id": 1, 
      "title": "iPhone 12 Pro", 
    } 
    { 
      "id": 2, 
      "title": "Macbook Air M2", 
    }
```

Bentuk awal 
response API

```dart
] 
} 
 
final data = 
jsonDecode(response.bo
dy);
```

jsonDecode()
(mengubah JSON 
jadi List & Map) data adalah Map 
data['products'] adalah List 
Setiap item adalah Map

```dart
final products = 
data["products"] 
[ 
    { 
      "id": 1, 
      "title": "iPhone 12 Pro", 
    } 
    { 
      "id": 2, 
      "title": "Macbook Air M2", 
    } 
]
```

*Assign* 
data["products"] ke 
dalam variabel 
**products**

```dart
products[0]['title']; 
iPhone 12 Pro
```

Jika ingin 
mengakses **title** 
dari produk 
pertama

```dart
products[1]['id']; 
2
```

Jika ingin 
mengakses **id** dari 
produk kedua Satu hal lagi, di Dart, tipe data *collection* **bisa di tentukan** tipe data isi nya apa. Jika ingin membuat List yang hanya berisikan tipe data integer, kita menggunakan **List<int>**. Jika ingin membuat Map dengan key bertipe String dan value bertipe integer, gunakan **Map<String, int>**. Ada juga tipe **dynamic** yang artinya fleksibel, bisa berisi tipe data apa saja. Karena data JSON dari API masih bersifat dinamis, kedepannya kita akan banyak menggunakan **List<dynamic>** dan **Map<String, dynamic>**.

### C. Asynchronous Programming

Tadi kita telah membahas konsep dasar API dan HTTP Request, serta bentuk data yang ingin kita ambil. Selanjutnya perlu diketahui juga bahwa pengambilan data dari API tidak bisa dilakukan secara instan, karena aplikasi perlu menunggu respon dari server, apalagi jika data yang diambil banyak. Jika proses ini dijalankan secara sinkron, aplikasi akan berhenti sementara (mandek/freeze) dan UI akan tidak responsif. Sementara UI **tidak boleh berhenti** saat menunggu data. Oleh karena itu, Flutter menggunakan konsep ***asynchronous programming***.

*Asynchronous programming* memungkinkan suatu proses dapat berjalan **tanpa menghentikan proses lain**. Ini dapat kita temukan di banyak aplikasi. Ketika aplikasi dibuka, data tidak langsung muncul, melainkan ditampilkan **indikator** **loading** terlebih dahulu. Contohnya, ketika membuka aplikasi seperti YouTube, daftar video tidak langsung ditampilkan, kan? Melainkan muncul *skeleton loading* terlebih dahulu selama data sedang diambil dari server. Di Flutter, pada operasi *asynchronous,* kita menggunakan **tiga** konsep utama:

#### 1. Future

Yaitu nilai yang akan tersedia di masa depan. Analoginya seperti saat kita memesan makanan di restoran, sebelum makanannya datang, kita dapat notanya dulu, kan? Nota bukan makanannya, tapi **janji bahwa makanan** **akan datang**.

##### Contoh Program 5.3 Future function

```dart
Future<String> fetchUserName() { 
  // Kode untuk ambil data dari API 
  // Return-nya bukan String langsung, tapi Future<String> 
}
```

#### 2. async

Adalah sebuah keyword yang menandai bahwa sebuah function akan melakukan operasi asynchronous.

##### Contoh Program 5.4 async

```dart
Future<String> fetchUserName() async { 
  // "async" bilang ke Dart: function ini butuh waktu 
}
```

#### 3. await

Juga sebuah keyword. Dengan await, Flutter tahu bahwa baris kode tersebut harus menunggu hasil Future sebelum melanjutkan eksekusi berikutnya, tanpa menghentikan UI.

##### Contoh Program 5.5 await

```dart
Future<void> getUserData() async { 
  String name = await fetchUserName(); // Tunggu sampai 
dapat nama 
  print(name); // Baru print setelah data tersedia 
}
```

Perlu dicatat, await **hanya bisa digunakan** di dalam function yang ditandai async.

Dengan mekanisme ini, aplikasi dapat tetap menampilkan UI (misalnya loading indicator) sambil menunggu data dari server di background.

### D. HTTP Package

Sekarang kita akan melihat bagaimana cara mendapatkan data dari API. Untuk melakukan komunikasi HTTP dengan API, Flutter menyediakan package bernama **http**. Kita bisa menggunakannya untuk mengirim request, menerima response, dan mengolah data JSON yang diterima. Caranya, dapat dengan menambahkan dependency berikut melalui terminal:

##### Contoh Program 5.6 Menambahkan http package

```bash
flutter pub add http
```

Misalnya, 
disini 
terdapat 
endpoint 
API 
berikut: https://jsonplaceholder.typicode.com/albums/1. Untuk melakukan request, kita perlu menggabungkan **package http** dengan mekanisme **Future** dan **asynchronous**. Kodingannya seperti ini:

##### Contoh Program 5.7 Function future dengan async-await

```dart
import 'package:http/http.dart' as http; 
Future<http.Response> fetchAlbum() async { 
  final response = await http.get( 
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1') 
  ); 
  return response; 
}
```

Apa yang terjadi pada kodingan ini? Mari kita breakdown.

- API URL API di parse terlebih dahulu yang awalnya string menjadi format **URI** (*Uniform Resource Identifier*), untuk mempermudah manipulasi dan ekstraksi informasi.
- Menggunakan method http.get() karena kita ingin mengambil data.
- Data yang diambil akan disimpan di variabel **response**, yang akan di return oleh function.
- Future<http.Response> menandakan function ini akan mengembalikan object Response di masa depan. Nantinya kita akan mengubahnya menjadi tipe data 
lain 
seperti 
**Future<List<Product>>** 
atau 
**Future<Map<String,** **dynamic>>** sesuai kebutuhan.
*In the end*, secara garis besar, alur penggunaan data dinamis dari melakukan HTTP Request hingga data ditampilkan di UI, terdiri dari tiga fase: ***Fetch, Parse*****,** dan ***Render.*** *Fetching* adalah ketika aplikasi sebagai client melakukan request ke server API, dan mendapatkan response berupa JSON mentah. Dilanjutkan dengan *parsing*, yakni menguraikan dan mengolah data yang didapatkan menjadi siap pakai. Terakhir, *rendering* dilakukan dengan mengaplikasikan state pada widget, sehingga data dapat tampil di UI. Agar lebih mudah membayangkan, berikut gambar visualisasinya:


![Gambar 5.3 Alur keseluruhan penggunaan data dinamis](images/modul_5/img_p8_1_39.png)
*Gambar 5.3 Alur keseluruhan penggunaan data dinamis*

Sebagai catatan, beberapa API membutuhkan **API key untuk autentikasi**, yakni sebuah token khusus yang membuktikan bahwa penggunanya terdaftar dan berhak mengakses data. API key biasanya dikirim melalui **header request**. API yang kita gunakan di modul ini adalah API publik yang tidak memerlukan API key. Sekarang, mari kita langsung mencoba menggunakan data dinamis di Flutter!

## IV. Langkah Praktikum

Target kita pada modul kali ini adalah **mengganti sumber data** yang awalnya statis menjadi **dinamis** menggunakan API. Silahkan clone terlebih dahulu repository project modul sebelumnya melalui https://github.com/AndiZirahitaf/modul_4_prak_mobile.

### A. Membuat api_service.dart dan Function get Pertama

1. Kita akan menggunakan api dari https://dummyjson.com/products yang menyediakan data berbagai macam produk. Jika kalian buka di browser ataupun menggunakan Postman, struktur JSON-nya  akan terlihat seperti ini:

##### Contoh Program 5.8 Isi JSON dari API yang akan digunakan

```dart
{ 
  "products": [ 
    { 
      "id": 1, 
      "title": "Mascara", 
      // lainnya 
    }, 
    { 
      "id": 2, 
      "title": "Lipstick", 
      // lainnya 
    } 
  ] 
}
```

2. Pertama-tama, kita perlu menambahkan **dependency http**. Bisa langsung dimasukkan pada file *pubspec.yaml,* atau dengan menjalankan command **flutter pub add http** di terminal.

##### Contoh Program 5.9 Menambahkan dependency (package) http

```yaml
dependencies: 
  http: ^1.6.0
```

Jangan lupa jalankan **flutter pub get** untuk menyimpan perubahan.

3. Pada folder lib, buat folder baru bernama **api**. Lalu didalamnya, buat file baru bernama **api_service.dart.** File ini yang akan kita gunakan untuk mensetting endpoint dan pusat function untuk mengambil data dari API.

4. Di api_service.dart, simpan url endpoint tersebut ke dalam sebuah variabel string.

##### Contoh Program 5.10 Endpoint

```dart
String apiUrl = 'https://dummyjson.com/products';
```

5. Kemudian, kita akan membuat function pertama kita untuk mendapatkan data produk tersebut. Jangan lupa import package http dan dart:convert (untuk kebutuhan fungsi), sehingga kodingannya seperti berikut:

##### Contoh Program 5.11 getProducts()

```dart
import 'dart:convert'; 
import 'package:http/http.dart' as http;

String apiUrl = 'https://dummyjson.com/products';
 
Future<List<dynamic>> getProducts() async { 
  final response = await http.get(Uri.parse(apiUrl)); 
  if (response.statusCode == 200) { 
    final data = jsonDecode(response.body); 
    return data['products']; 
  } else { 
    throw Exception('Failed to load products'); 
  } 
}
```

Disini, kita membuat function bernama getProducts(), bersifat Future, dan me-return List<dynamic>. Hasil dari proses http.get disimpan didalam variabel **response** menggunakan async-await. Jika sukses, response yang masih *raw* di-decode menggunakan **jsonDecode()** agar bisa diakses. Kita langsung **return data['products']** agar list produknya yang didapat, bukan **keseluruhan** response.

### B. Mengambil data Products

1. Sekarang buka kembali home.dart, import api_service.dart. Karena nanti akan ada perubahan state, kita perlu menjadikan page ini **StatefulWidget** terlebih dulu. Silahkan **refactor**.

2. Lalu di dalam class _HomeScreenState, tambah dua variabel: **products** untuk menyimpan data produk yang telah diambil dari API, dan **isLoading** untuk menandai apakah data sedang dimuat.

3. Selanjutnya, buat fungsi **fetchProducts()** yang bertugas **memanggil API** **dan memperbarui UI**, sehingga kodingan menjadi seperti ini (import api/api_service.dart):

##### Contoh Program 5.12 fetchProducts()

```dart
class _HomePageState extends State<HomePage> { 
  List<dynamic> products = []; 
  bool isLoading = true; 
 
  Future<void> fetchProducts() async { 
    final productData = await getProducts(); 
    setState(() { 
      products = productData; 
      isLoading = false; 
    }); 
  }
  // kodingan lain
}
```

Disini, **fetchProducts()** yang juga bersifat future, berjalan di belakang.

Ketika data berhasil diambil, ia menghubungkannya dengan meng-*apply* data dari **getProducts()** ke UI menggunakan **setState()**. Variabel **isLoading** juga diubah ke false sebagai tanda bahwa loading selesai.

Nah untuk mendapatkan data dari API di page home ini, **fetchProducts()** tinggal kita panggil. Tetapi jika data ingin langsung diambil **begitu page dibuka**, kita perlu memanggilnya di dalam **initState().** **initState()** adalah *lifecycle method* bawaan StatefulWidget yang dipanggil tepat **satu kali** saat widget pertama kali dimasukkan ke dalam widget tree. Ini adalah tempat yang paling tepat untuk melakukan inisialisasi, seperti mengambil data pertama kali.

Masukkan dibawah fetchProducts():

##### Contoh Program 5.13 initState()

```dart
@override 
void initState() { 
   super.initState(); 
   fetchProducts(); 
}
```

4. Perlu diketahui selanjutnya, bahwa operasi yang menyangkut jaringan bisa gagal kapan saja. Misalnya koneksi internet putus, server down, atau URL salah. Tanpa *error handling*, aplikasi bisa tiba-tiba *crash*. Disini kita berkenalan dengan **try-catch**, yang memungkinkan kita menjalankan kode yang berisiko di dalam blok **try**, dan menangani error yang terjadi di blok **catch**. Disini jika error, akan di print pesan errornya. Update fungsi **fetchProducts()** menjadi seperti ini:

##### Contoh Program 5.14 try-catch

```dart
Future<void> fetchProducts() async { 
  try { 
    // Kode yang bisa jadi gagal 
    final productData = await getProducts(); 
    setState(() { 
      products = productData; 
      isLoading = false; 
    }); 
  } catch (e) {
    // Dijalankan jika ada error di blok try 
        setState(() { 
      isLoading = false; 
    }); 
    print('Error: $e'); 
  } 
}
```

### C. Menampilkan data API di UI

Kita akan menggunakan variabel **products** yang telah dibuat untuk menampilkan data. Variabel ini bersifat **List<dynamic>**, yang sudah berisi value dari key **products** pada response tadi. Ketika ingin memanggil value di dalamnya, kita dapat tinggal memanggil key nya. Kita nantinya juga akan menggunakan index.

1. Pada home.dart, di bagian body, masukkan ini:

##### Contoh Program 5.15 Pemanggilan data dinamis di build()

```dart
body: ListView.builder( 
        itemCount: products.length, 
        itemBuilder: (context, index) { 
          final product = products[index]; 
          return ListTile( 
            title: Text(product['title']), 
            subtitle: Text('Rp ${product['price']}'), 
            leading: Image.network( 
              product['images'][0], 
              width: 50, 
              height: 50, 
              fit: BoxFit.cover, 
            ), 
            trailing: Icon(Icons.arrow_forward_ios, color: 
Colors.black54), 
          ); 
        }, 
      ),
```

2. Coba jalankan aplikasi, pastikan list produk tampil.

3. Jika diperhatikan, akan terjadi *delay* ketika aplikasi dijalankan hingga product muncul. Inilah maksudnya dari konsep *asynchronous*. *Delay* ini adalah waktu yang dibutuhkan aplikasi untuk dapat me-*retrieve* data dari API. Ketika *delay*, biasanya tidak ditampilkan apa-apa pada UI. Maka dari itu, developer meletakkan **indikator loading** disaat-saat ini.

4. Pada body, alih-alih langsung memasukkan ListView, kita ganti dengan menggunakan ternary operator terlebih dahulu, memeriksa status dari **isLoading** yang telah kita buat diatas. Jika **false**, munculkan ListView. Namun jika **true**, kita munculkan **CircularProgressIndicator()**.

##### Contoh Program 5.16 Mekanisme isLoading

```dart
body: isLoading
        // Jika data belum dapat, tampilkan loading. 
        ? const Center(child: CircularProgressIndicator()) 
        // Jika data sudah ada, tampilkan list 
        : ListView.builder(
             // kodingan lainnya
          )
```

### D. Data untuk Detail Page

Kita sudah dapat menampilkan data dinamis API ke home yang berbentuk list. Namun, bagaimana jika di detail? Terdapat dua cara. Pertama, kita dapat ***passing*** **semua data** yang dibutuhkan langsung dari home ke detail melalui constructor. Tapi hal tersebut mungkin dapat kurang sesuai mengingat bisa saja kita menampilkan sangat banyak data di detail. Cara kedua adalah cukup mem-*passing* **id product ke detail**, dan di detail kita melakukan HTTP Request lagi khusus untuk data produk tersebut berdasarkan id produk yang dipilih.

Jika kita menggunakan cara kedua, berarti kita perlu menggunakan ***endpoint*** yang berbeda. Kalau untuk mengambil list produk secara keseluruhan kita memakai **/products,** kali ini untuk mendapatkan **hanya** satu produk, kita memakai **/products/{id}.**

1. Kembali 
ke 
api_service.dart, 
kita 
tambahkan 
function 
baru, **getSingleProduct()**.

##### Contoh Program 5.17 getSingleProduct()

```dart
Future<Map<String, dynamic>> getSingleProduct(int 
productId) async { 
  final response = await 
http.get(Uri.parse('$apiUrl/$productId')); 
  if (response.statusCode == 200) { 
    final data = jsonDecode(response.body); 
    return data; 
  } else { 
    throw Exception('Failed to load product details'); 
  } 
}
```

Karena kali ini kita ingin mengambil langsung ke satuan data nya, artinya tipe data yang kita ambil akan berbentuk Map. Maka dari itu disini kita menggunakan **Map<String, dynamic>**. Data yang akan di-***return*** adalah seperti berikut:

##### Contoh Program 5.18 Output data satu produk

```dart
{ 
  "id": 1, 
  "title": "iPhone 12 Pro", 
  // lainnya 
}
```

2. Lanjut pada detail.dart, lakukan perubahan menjadi **StatefulWidget.** Lalu ubah parameter menjadi **productId,** untuk nantinya kita *passing* dari home. Nanti akan terjadi error karena sebelumnya parameternya productIndex.

##### Contoh Program 5.19 Parameter Detail

```dart
class DetailPage extends StatefulWidget { 
  final int productId; 
  const DetailPage({super.key, required this.productId}); 
 
  @override 
  State<DetailPage> createState() => _DetailPageState(); 
}
```

3. Di home.dart, tambahkan properti **onTap** pada **ListTile**, lalu kirim product id ke detail melalui navigation.

##### Contoh Program 5.20 Passing id ke detail

```dart
onTap: () { 
    Navigator.push( 
        context, 
            MaterialPageRoute( 
                builder: (context) => DetailPage( 
                  productId: product['id'] 
            ), 
        ), 
    ); 
},
```

4. Sama seperti di home, di detail kita lakukan hal yang sama. Buat variabel, buat fungsi fetch, dan panggil di **initState()**. Letakkan di dalam _DetailPageState ya, di atas build(). Jangan lupa import api/api_service.dart.

##### Contoh Program 5.21 Pemanggilan API (detail.dart)

```dart
Map<String, dynamic> product = {}; 
  bool isLoading = true; 
 
  Future<void> fetchSingleProduct() async { 
    final productData = await 
getSingleProduct(widget.productId); 
 
    setState(() { 
      product = productData; 
      isLoading = false; 
    }); 
  } 
 
  @override 
  void initState() { 
    super.initState(); 
    fetchSingleProduct(); 
  }
```

Lalu langsung panggil di UI dengan **product['key']**.

5. Coba lakukan hot restart dan jalankan. Harusnya ketika melakukan navigasi dari home ke detail, akan muncul red screen dengan error lalu baru muncul page 
detailnya. 
Untuk 
memperbaiki 
ini, 
tambahkan **CircularProgressIndicator()** 
pada 
body. 
Sehingga 
kodingan 
build() detail.dart menjadi seperti ini:

##### Contoh Program 5.22 build detail.dart

```dart
@override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text('Detail Produk')), 
      body:  
      isLoading 
          ? Center(child: CircularProgressIndicator()) 
          : 
      SingleChildScrollView( 
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [ 
            Image.network( 
              product['images'][0], 
              width: double.infinity, 
              height: 300, 
            ), 
            Padding( 
              padding: const EdgeInsets.all(16.0), 
              child: Column( 
                crossAxisAlignment: 
CrossAxisAlignment.start, 
                children: [ 
                  Text( 
                    product['title'], 
                    style: const TextStyle( 
                      fontSize: 24, 
                      fontWeight: FontWeight.bold, 
                    ), 
                  ), 
                  const SizedBox(height: 8), 
                  Text( 
                    'Rp ${product['price']}', 
                    style: const TextStyle( 
                      fontSize: 20, 
                      color: Colors.blue, 
                      fontWeight: FontWeight.w600, 
                    ), 
                  ), 
                  const SizedBox(height: 16), 
                  Text( 
                    'Kategori: ${product['category']}', 
                    style: const TextStyle(fontSize: 14, 
color: Colors.grey), 
                  ), 
                  const SizedBox(height: 16), 
                  const Text( 
                    'Deskripsi:', 
                    style: TextStyle(fontSize: 16, 
fontWeight: FontWeight.bold), 
                  ), 
                  const SizedBox(height: 8), 
                  Text( 
                    product['description'], 
                    style: const TextStyle(fontSize: 16), 
                  ), 
                ], 
              ), 
            ), 
          ], 
        ), 
      ), 
    ); 
  }
```

6. Jalankan kembali. Jika data sudah muncul dengan baik, kita telah berhasil menampilkan data item-list.

### E. Class dengan Static Method

Silahkan kembali ke api_service.dart. Sejauh ini, function-function API kita berdiri sendiri (top-level). Namun project yang lebih besar dengan banyak *endpoint*, fungsi-fungsi yang terpisah-pisah akan sulit dikenali dan dikelola. Maka dari itu, sekarang kita berkenalan dengan **static method**. Dengan static, deretan function bisa terorganisir dalam satu class, sehingga kode lebih rapi dan mudah dicari. Selain itu, kita bisa memanggil method langsung via nama class-nya (contoh: **ApiService.getProducts()**) tanpa perlu membuat instance object terlebih dahulu.

#### 1. Update seluruh isi api_service.dart menjadi:

##### Contoh Program 5.23 Static method ApiService

```dart
import 'dart:convert'; 
import 'package:http/http.dart' as http; 
 
class ApiService { 
 
  static const String apiUrl = 
'https://dummyjson.com/products'; 
 
  static Future<List<dynamic>> getProducts() async { 
    final response = await http.get(Uri.parse(apiUrl)); 
    if (response.statusCode == 200) { 
      final data = jsonDecode(response.body); 
      return data['products']; 
    } else { 
      throw Exception('Failed to load products'); 
    } 
  } 
 
  static Future<Map<String, dynamic>> getSingleProduct(int 
productId) async { 
    final response = await 
http.get(Uri.parse('$apiUrl/$productId')); 
    if (response.statusCode == 200) { 
      final data = jsonDecode(response.body); 
      return data; 
    } else { 
      throw Exception('Failed to load product details'); 
    } 
  } 
}
```

2. Lalu ubah pemanggilan function di home dan detail menjadi seperti berikut:

##### Contoh Program 5.24 Contoh pemanggilan static method

```dart
// Di home.dart
final productData = await ApiService.getProducts();
// Di detail.dart
final productData = await 
ApiService.getSingleProduct(widget.productId);
```

### F. Menggunakan Model pada Data Dinamis

Sejauh 
ini 
kita 
mengakses 
data 
dengan 
notasi **['key']**, misalnya **product['title']**. Cara ini memang berhasil, tapi punya beberapa kelemahan. Jika penulisan pada key ada **typo**, data tidak bisa muncul. Tidak ada ***autocomplete*** juga dari IDE karena penulisan key menggunakan tanda petik. Dart tidak bisa memeriksa tipe data dari data tersebut, apakah int, double atau String. Serta jika kedepannya pada API terdapat perubahan key, **semua** pemanggilan terkait harus diganti. Di bagian ini kita akan mengupas secara bertahap, mengapa kita butuh model untuk **menampung** data dari API sebelum ditampilkan di UI.

1. Buka kembali models/data.dart. Buat class yang merepresentasikan struktur data dari API. Disini kita buat class **Product** baru saja (boleh hapus class **Product** dan dummy data yang dibuat di modul sebelumnya):

##### Contoh Program 5.25 Model class Product

```dart
class Product { 
  final int id; 
  final String title; 
  final String description; 
  final String category; 
  final double price; 
  final String image; 
 
  Product({ 
    required this.id, 
    required this.title, 
    required this.description, 
    required this.category, 
    required this.price, 
    required this.image, 
  }); 
}
```

2. Di ApiService, kita konversi data Map secara manual menjadi objek Product. Karena kita akan membuat list berisi object Product, maka functionnya akan me-*return* **List<Product>**. Update getProducts() dan jangan lupa import ../models/data.dart:

##### Contoh Program 5.26 getProducts() dengan konversi manual

```dart
static Future<List<Product>> getProducts() async { 
    final response = await http.get(Uri.parse(apiUrl)); 
    if (response.statusCode == 200) { 
      final data = jsonDecode(response.body); 
      List rawList = data['products']; 
 
      List<Product> productList = []; 
      for (var item in rawList) { 
        productList.add( 
          Product( 
            id: item['id'], 
            title: item['title'], 
            description: item['description'], 
            category: item['category'], 
            price: (item['price'] as num).toDouble(), 
            image: item['images'][0], 
          ), 
        ); 
      } 
      return productList; 
    } else { 
      throw Exception('Failed to load products'); 
    } 
  }
```

3. Kembali ke home.dart, ganti inisialisasi **List** menjadi bertipe data **Product**.

##### Contoh Program 5.27 Mengganti tipe data products (home.dart)

```dart
class _HomePageState extends State<HomePage> { 
  List<Product> products = [];
```

4. Kemudian 
ganti 
semua 
penggunaan 
products 
dari 
yang 
awalnya menggunakan notasi key, menjadi notasi dot yang lebih aman. Sehingga ListView home.dart seperti ini:

##### Contoh Program 5.28 ListView Home

```dart
ListView.builder( 
        itemCount: products.length, 
        itemBuilder: (context, index) { 
          final product = products[index]; 
          return ListTile( 
            onTap: () { 
                    Navigator.push( 
                      context, 
                      MaterialPageRoute( 
                        builder: (context) => 
                            DetailPage(productId: 
product.id), 
                      ), 
                    ); 
                  }, 
 
            title: Text(product.title), 
            subtitle: Text('Rp ${product.price}'), 
            leading: Image.network( 
              product.image, 
              width: 50, 
              height: 50, 
              fit: BoxFit.cover, 
            ), 
            trailing: Icon(Icons.arrow_forward_ios, color: 
Colors.black54), 
          ); 
        }, 
      ),
```

### G. Factory Constructor

Tadi kita sudah mengonversi data Map ke Product menggunakan **loop** di ApiService, namun untuk perihal efisiensi kode, itu nanti bisa menjadi panjang dan berantakan. **ApiService** seharusnya cukup tahu cara ambil data, bukan tahu cara membuat objek Product. Logika konversi itu seharusnya urusan **class Product** **sendiri**. Karena nanti logika ini juga akan dibutuhkan untuk **getSingleProducts()**.

Solusinya adalah menggunakan **factory constructor**.

**factory** adalah keyword untuk constructor yang memiliki fleksibilitas lebih, boleh menjalankan kode apa pun sebelum mengembalikan instance. Di sini kita gunakan untuk membuat constructor bernama **Product.fromJson()** yang menerima sebuah Map (hasil jsonDecode) dan mengonversinya menjadi objek Product.

1. Di data.dart, ubah class Product menjadi seperti ini:

##### Contoh Program 5.29 Product dengan factory fromJson()

```dart
class Product { 
  final int id; 
  final String title; 
  final String description; 
  final String category; 
  final double price; 
  final String image; 
 
  Product({ 
    required this.id, 
    required this.title, 
    required this.description, 
    required this.category, 
    required this.price, 
    required this.image, 
  }); 
 
  // factory constructor untuk pembuatan instance Product 
dari JSON 
  factory Product.fromJson(Map<String, dynamic> json) { 
    return Product( 
      id: json['id'], 
      title: json['title'], 
      description: json['description'], 
      category: json['category'], 
      price: (json['price'] as num).toDouble(), 
      image: json['images'][0], 
    ); 
  } 
}
```

2. Dengan fromJson() di dalam model, ApiService sekarang jauh lebih ringkas. Loop for yang panjang tadi cukup diganti satu baris:

##### Contoh Program 5.30 getProducts() dengan fromJson()

```dart
static Future<List<Product>> getProducts() async { 
  final response = await http.get(Uri.parse(apiUrl)); 
  if (response.statusCode == 200) { 
    final data = jsonDecode(response.body); 
    List products = data['products']; 
 
    // Cukup satu baris 
    return products.map((e) => 
Product.fromJson(e)).toList(); 
  } else { 
    throw Exception('Failed to load products'); 
  } 
}
```

3. Update juga **getSingleProduct()** agar mengembalikan objek Product:

##### Contoh Program 5.31 getSingleProduct() dengan fromJson()

```dart
static Future<Product> getSingleProduct(int productId) 
async { 
    final response = await 
http.get(Uri.parse('$apiUrl/$productId')); 
    if (response.statusCode == 200) { 
      final data = jsonDecode(response.body); 
      return Product.fromJson(data); 
    } else { 
      throw Exception('Failed to load product details'); 
    } 
  }
```

4. Jangan lupa sesuaikan tipe variabel di detail.dart. Dari Map<String,dynamic> menjadi **Product?**, artinya dapat bersifat nullable (karena data belum langsung ada ketika page pertama kali dibuka):

##### Contoh Program 5.32 Update tipe variabel di detail.dart

```dart
// Di detail.dart ganti Map<String,dynamic> menjadi 
Product?; 
 
class _DetailPageState extends State<DetailPage> { 
  Product? product;
```

5. Update pemanggilan data di page detail menjadi **dot notation**. Namun kali ini karena variabelnya nullable, pemanggilannya jadi menggunakan tanda seru (!), seperti ini:

##### Contoh Program 5.33 Contoh pemanggilan data di detail.dart

```dart
product!.title
```

Ini adalah ***null-assertion operator*** yang memberitahu compiler untuk memaksa mengambil nilai, atau akan menyebabkan error jika ternyata null.

Ketika page pertama kali dimuat, pasti nilainya null, tapi tenang saja karena kita sudah handle itu dengan memasang CircularProgressIndicator().

#### 6. Sudah, gas jalankan aplikasi!


![Ilustrasi](images/modul_5/img_p22_1_73.png)


![Gambar 5.4 Home Page   Gambar 5.5 Detail Page](images/modul_5/img_p22_2_74.png)
*Gambar 5.4 Home Page   Gambar 5.5 Detail Page*

7. Untuk hasil langkah praktikum di modul ini, dapat diakses di repository berikut: https://github.com/AndiZirahitaf/modul_5_prak_mobile.

## V. Tugas Praktikum

1. Ambil data dari API berikut: https://dattebayo-api.onrender.com/characters.

2. Tampilkan daftar nama karakter pada halaman utama menggunakan ListView.

a. Pada setiap item karakter, tampilkan:

b. Nama karakter

c. Gambar karakter (gunakan gambar pertama pada field images).

3. Ketika 
salah satu karakter dipilih, tampilkan halaman detail yang menampilkan:

a. Gambar & Nama karakter

b. Tanggal lahir (personal.birthdate)

c. Clan karakter (personal.clan)

d. Beberapa jutsu karakter (minimal 3 jutsu dari field jutsu)
