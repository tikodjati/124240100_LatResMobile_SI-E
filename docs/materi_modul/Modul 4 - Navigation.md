# Modul 4: NAVIGATION

## I. Tujuan Praktikum

- Memahami konsep navigation dan stack di Flutter
- Mampu menggunakan berbagai method Navigator
- Mampu melakukan passing data antar halaman
- Mampu mengimplementasikan BottomNavigationBar
## II. Alokasi Waktu : 1 x Pertemuan = 120 menit

## III. Dasar Teori

Aspek yang penting pada aplikasi mobile adalah bagaimana berpindahnya pengguna dari satu halaman ke halaman lain, misalnya dari halaman login menuju home page, atau dari halaman daftar produk menuju halaman detail produk. Mekanisme ini disebut dengan **navigation**. Pada Flutter, navigation bekerja menggunakan prinsip **stack**. Ketika kita membuka halaman baru, halaman tersebut ditumpuk di atas halaman sebelumnya. Ketika kembali, halaman teratas akan dihapus dari tumpukan. Mekanisme ini yang membuat tombol "back" berfungsi dengan baik. Prinsip ini juga disebut dengan **LIFO** (*Last In First Out*).


![Gambar 4.1 Konsep Stack pada Navigasi](images/modul_4/img_p1_1_14.png)
*Gambar 4.1 Konsep Stack pada Navigasi*

Misalnya:

- Buka aplikasi → Halaman Login (stack: Login)
- Tekan tombol login → Halaman Home ditumpuk di atas Login (stack: Login, Home)
- Tekan tombol back → Halaman Home dihapus, kembali ke Login (stack: Login)
### A. Macam Navigation

Navigation di Flutter menggunakan widget bernama **Navigator.** Namun biasanya digunakan langsung bersama methodnya. Berikut adalah beberapa method dari Navigator yang sering digunakan:

```dart
1. Navigator.push()

Secara umum, kita dapat menggunakan method Navigator.push().
```

Method ini akan menambahkan halaman baru ke dalam stack sehingga pengguna masih dapat kembali ke halaman sebelumnya.

##### Contoh Program 4.1 Contoh Navigator Push

```dart
Navigator.push(context, MaterialPageRoute(builder: 
(context) {
   return SecondScreen();
}));
```

Method ini membutuhkan dua parameter: **context** untuk mengetahui posisi widget saat ini dalam widget tree, dan **MaterialPageRoute** yang berisi halaman 
tujuan. 
Setelah 
pindah 
halaman, 
Flutter 
secara otomatis menampilkan tombol back di AppBar. Jika tidak ingin tombol back muncul, tambahkan *property* **automaticallyImplyLeading: false** di dalam AppBar.


![Gambar 4.2 Tombol Kembali](images/modul_4/img_p2_1_23.png)
*Gambar 4.2 Tombol Kembali*

```dart
2. Navigator.pop()
```

Sebaliknya, untuk kembali ke halaman sebelumnya digunakan

```dart
method Navigator.pop(). Ini akan menghapus page aktif dari stack. Method ini
```

hanya membutuhkan satu parameter yaitu context.

##### Contoh Program 4.2 Contoh Navigator Pop

```dart
Navigator.pop(context);
```

Ketika pop() dipanggil, halaman saat ini akan dihancurkan dan halaman sebelumnya akan ditampilkan kembali. Perlu diingat bahwa jika stack hanya berisi satu halaman dan kita memanggil pop(), **aplikasi akan** **tertutup.**

```dart
3. Navigator.pushReplacement()
```

Berbeda dengan push() yang menambah stack, pushReplacement() mengganti halaman aktif dengan halaman baru tanpa menambah stack.

Halaman sebelumnya akan dihapus dan diganti dengan halaman baru, sehingga tidak bisa kembali ke halaman sebelumnya.

##### Contoh Program 4.3 Contoh Navigator Push Replacement

```dart
Navigator.pushReplacement( 
  context, 
  MaterialPageRoute(builder: (context) => HomeScreen()) 
);
```

Method ini sangat berguna untuk halaman login. Setelah login berhasil dan masuk ke home, kita tidak ingin user bisa kembali ke halaman login dengan menekan tombol back. Maka dari itu, gunakan pushReplacement() agar halaman login tergantikan dengan halaman home.

#### 4. Navigator.pushAndRemoveUntil()

Jika ingin menghapus semua stack navigation (reset flow aplikasi), bisa menggunakan method ini. Misalnya, pada button logout di halaman profil, digunakan pushAndRemoveUntil() yang mengarah ke login page. Jadi ketika balik ke login, semua history page di stack terhapus.

##### Contoh Program 4.4 Contoh Navigator Push And Remove Until

```dart
Navigator.pushAndRemoveUntil( 
  context, 
  MaterialPageRoute(builder: (context) => LoginPage()), 
  (route) => false 
);
```

Method ini berpindah ke halaman baru sambil menghapus stack berdasarkan kondisi tertentu. Parameter ketiga `(route) => false` berarti hapus semua halaman sebelumnya. Berguna untuk logout agar user tidak bisa back ke halaman yang butuh autentikasi. Jika ingin tetap menyimpan beberapa halaman, ganti `false` dengan kondisi tertentu seperti (route) => route.isFirst untuk kembali ke halaman pertama saja.

### B. Passing Data

Setelah mengetahui macam-macam method dari Navigator, sekarang kita membahas mengenai bagaimana cara passing data antar page. Seringkali kita perlu mengirim data dari satu halaman ke halaman lain. Misalnya mengirim **username** **dari halaman login ke halaman home**, atau mengirim ID produk dari list ke halaman detail. Di Flutter, kita memanfaatkan **constructor** untuk mengirim data. Langkah-langkahnya adalah seperti berikut:

1. Pertama-tama, di page pengirim harus ada **variabel** yang sudah siap.

2. Data dikirim melalui variabel saat melakukan **navigasi**.

3. Data diterima melalui **constructor** page tujuan

#### 4. Tampilkan data di UI

Contoh implementasinya pada page pengirim (FirstScreen):

##### Contoh Program 4.5 Passing Data (FirstScreen)

```dart
String username = "John Doe"; 
 
Navigator.push( 
  context, 
  MaterialPageRoute( 
    builder: (context) => SecondScreen(username: username) 
  ) 
);
```

Sedangkan pada page penerima adalah sebagai berikut (SecondScreen)

##### Contoh Program 4.6 Passing Data (SecondScreen)

```dart
class SecondScreen extends StatelessWidget { 
  final String username; 
 
  SecondScreen({required this.username}); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: Center( 
        child: Text('Halo, $username!'), 
      ), 
    ); 
  } 
}
```

Data yang dikirim tidak terbatas pada satu data saja. Kita **bisa mengirim** **beberapa data sekaligus** dengan berbagai tipe data seperti String, int, double, bahkan object model seperti Product atau User.

Seperti yang bisa dilihat pada kodingan di SecondScreen, kita memberikan *keyword* **required** pada parameter username, yang artinya ketika melakukan navigasi ke SecondScreen, **harus ada data yang dikirim** untuk mengisi parameter username milik SecondScreen. Artinya data username ini **wajib** dikirim.

Jika sifatnya **opsional**, yang mana artinya kita tidak memberikan keyword **required** pada username, kita harus menambahkan nilai **default** (placeholder) pada parameter tersebut.

##### Contoh Program 4.7 Parameter Optional

```dart
class SecondScreen extends StatelessWidget { 
  final String username; 
  final String greeting; 
 
  SecondScreen({ 
    required this.username, 
    this.greeting = "Selamat Datang" 
  }); 
}
```

Pada contoh di atas, username wajib dikirim, sedangkan greeting tidak wajib. Jika greeting tidak dikirim, akan menggunakan nilai default "Selamat Datang".

### C. Bottom Navigation Bar

Selain 
Navigator, 
Flutter 
juga 
menyediakan 
widget 
bernama BottomNavigationBar. Terletak di bagian bawah layar, widget ini biasa dipakai untuk memudahkan **perpindahan antar page utama aplikasi**. Misalnya pada Instagram. BottomNavigationBar digunakan untuk pindah antar page Home, Reels, Messages, Search, dan Profile.


![Gambar 4.3 BottomNavigationBar pada Instagram](images/modul_4/img_p6_1_34.png)
*Gambar 4.3 BottomNavigationBar pada Instagram*

BottomNavigationBar bekerja dengan prinsip ***indexed navigation***, yaitu mengganti halaman berdasarkan index yang dipilih. Berbeda dengan push() dan pop(), bottom navigation **tidak menggunakan stack**, melainkan menampilkan halaman berdasarkan index yang aktif. Secara garis besar, berikut adalah cara kerja BottomNavigationBar:

1. Siapkan dulu halaman-halaman yang akan ditampilkan

2. Buat variabel **_selectedIndex** untuk menyimpan index halaman yang aktif

3. Tampilkan halaman sesuai index menggunakan **_pages[_selectedIndex]**

4. Update index saat item bottom navigation di-tap menggunakan **setState()**

##### Contoh Program 4.8 Implementasi BottomNavigationBar

```dart
import 'package:flutter/material.dart'; 
import 'home.dart'; 
import 'profile.dart'; 
 
class Root extends StatefulWidget { 
  const Root({super.key}); 
 
  @override 
  State<Root> createState() => _RootState(); 
} 
 
class _RootState extends State<Root> { 
  int _selectedIndex = 0; 
  @override 
  Widget build(BuildContext context) { 
    final List<Widget> _pages = [HomePage(), ProfilePage()]; 
    return Scaffold( 
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar( 
        currentIndex: _selectedIndex, 
        onTap: (index) { 
          setState(() { 
            _selectedIndex = index; 
          }); 
        }, 
        items: [ 
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: 'Beranda'), 
          BottomNavigationBarItem( 
            icon: Icon(Icons.person), 
            label: 'Profil'), 
        ], 
      ), 
    ); 
  } 
}
```

Untuk memahami apa saja yang terjadi pada blok kodingan diatas, berikut poin-poin penjelasannya:

- **●** **_selectedIndex** Variabel untuk menyimpan index halaman yang sedang aktif. Default-nya 0 (halaman pertama)
- **●** **_pages** List berisi widget halaman yang akan ditampilkan. Index 0 adalah HomePage, index 1 adalah ProfilePage
- **●** **body: _pages[_selectedIndex]** Menampilkan halaman sesuai dengan index yang dipilih
- **●** **currentIndex: _selectedIndex** Memberitahu BottomNavigationBar item mana yang sedang aktif
- **●** **onTap: (index)** Callback yang dipanggil ketika item di-tap. Parameter index berisi posisi item yang di-tap (0, 1, dst)
- **●** **setState(() => _selectedIndex = index)** Mengubah _selectedIndex dan rebuild widget agar halaman berubah
- **●** **items** List berisi item-item yang ditampilkan di bottom navigation bar Dengan cara ini, ketika user menekan icon Home, _selectedIndex akan menjadi 0 dan HomePage akan ditampilkan. Ketika menekan icon Profile, _selectedIndex menjadi 1 dan ProfilePage akan ditampilkan.
## IV. Langkah Praktikum

Pada modul ini kita akan membuat sebuah aplikasi e-commerce sederhana dengan konsep **home → detail**, dimana pada home akan ditampilkan list data produk yang berasal dari data dummy. Ketika masing-masing item produk diklik, akan menuju halaman detail yang menunjukkan informasi lengkap dari produk tersebut. Lalu ada bottom navigation bar untuk navigasi antar home dan profil. Alurnya adalah seperti berikut:


![Gambar 4.4 Flow navigasi aplikasi](images/modul_4/img_p8_1_39.png)
*Gambar 4.4 Flow navigasi aplikasi*

Sedangkan, struktur folder dan filenya:


![Gambar 4.5 Struktur Folder dan File](images/modul_4/img_p8_2_40.png)
*Gambar 4.5 Struktur Folder dan File*

Total ada 4 page: **Login, Home, Detail, dan Profile.**

### A. Langkah-langkah

1. Silahkan buka kembali project dari **Modul III - State & Data**, atau menggunakan project dari repository berikut: https://github.com/AndiZirahitaf/modul_3_prak_mobile **Catatan:** Modul ini melanjutkan dari modul sebelumnya, jadi pastikan sudah ada file login.dart dan model User (ada di data.dart).

2. Pertama-tama kita akan membuat **model Product** dan data dummy produk yang akan ditampilkan di aplikasi. Buka file data.dart (atau buat jika belum ada di folder models/), lalu tambahkan kode berikut:

##### Contoh Program 4.9 Data Dummy Products (data.dart)

```dart
class Product { 
  int id; 
  String name; 
  String category; 
  String description; 
  String price; 
  String image; 
 
  Product({ 
    required this.id, 
    required this.name, 
    required this.category, 
    required this.description, 
    required this.price, 
    required this.image, 
  }); 
} 
 
final List<Product> products = [ 
  Product( 
    id: 1, 
    name: "Wireless Headphone", 
    category: "Electronics", 
    price: "750000", 
    image: 
        
"https://cdn.dummyjson.com/product-images/mobile-accessories/apple-a
irpods-max-silver/1.webp", 
    description: 
        "Wireless headphone dengan kualitas suara jernih dan baterai 
tahan lama.", 
  ), 
  Product( 
    id: 2, 
    name: "Smart Watch", 
    category: "Electronics", 
    price: "1200000", 
    image: 
        
"https://cdn.dummyjson.com/product-images/mobile-accessories/apple-w
atch-series-4-gold/1.webp", 
    description: 
        "Smart watch dengan fitur kesehatan, notifikasi, dan desain 
elegan.", 
  ), 
  Product( 
    id: 3, 
    name: "iPhone X", 
    category: "Electronics", 
    price: "3500000", 
    image: 
        
"https://cdn.dummyjson.com/product-images/smartphones/iphone-x/1.web
p", 
    description: "iPhone X dengan layar OLED dan desain minimalis.", 
  ), 
  Product( 
    id: 4, 
    name: "Monopod", 
    category: "Electronics", 
    price: "950000", 
    image: 
        
"https://cdn.dummyjson.com/product-images/mobile-accessories/monopod
/1.webp", 
    description: "Monopod dengan desain ringkas dan bahan 
berkualitas tinggi.", 
  ), 
];
```

final List<Product> **products** adalah list yang berisi 4 produk dummy.

Dan Image yang kita gunakan pada setiap item berbentuk Image.network, jadi nanti akan di load dari internet.

3. Mari kita buat halaman Home untuk menampilkan list produk. Buat file baru bernama home.dart. Jangan lupa import file data dummy (data.dart).

##### Contoh Program 4.10 home.dart

```dart
import 'package:flutter/material.dart'; 
import 'models/data.dart'; 
 
class HomePage extends StatelessWidget { 
  const HomePage({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Home Page', style: TextStyle(color: 
          Colors.white, fontWeight: FontWeight.bold),), 
        backgroundColor: Colors.blue, 
      ), 
      body: ListView.builder( 
        itemCount: products.length, 
        itemBuilder: (context, index) { 
          return GestureDetector( 
            onTap: () {}, 
            child: ListTile( 
              title: Text(products[index].name), 
              subtitle: Text('Rp ${products[index].price}'), 
              leading: Image.network( 
                products[index].image, 
                width: 50, 
                height: 50, 
              ), 
              trailing: Icon(Icons.arrow_forward_ios, color: 
                 Colors.black54), 
            ), 
          ); 
        }, 
      ), 
    ); 
  } 
}
```

Karena saat ini halaman cuma menampilkan list produk dari data yang sudah ada (tidak ada state yang berubah), kita cukup memakai StatelessWidget. Jika nanti ingin menambah fitur seperti search, filter, atau favorite, baru diubah ke StatefulWidget.

Disini, kita menggunakan **ListView.builder** untuk menampilkan data produk. Lalu untuk layout per itemnya kita gunakan **ListTile** agar mudah. Bungkus ListTile dengan widget **GestureDetector** agar nantinya bisa di klik untuk navigasi ke halaman detail. Namun property **onTap** pada GestureDetector kita kosongkan dulu, akan kita isi nanti.

4. Pada modul sebelumnya, untuk indikator login berhasil, kita menggunakan ***conditional rendering*** **(perubahan UI di page yang sama).** Sekarang, kita akan mengubah logicnya agar ketika login berhasil, **user diarahkan ke home** **page**. Maka dari itu kita perlu hapus *conditional renderingnya.* Body dari Scaffold menjadi seperti ini (jangan lupa import home.dart):

##### Contoh Program 4.11 body login.dart setelah conditional rendering dihapus

```dart
body: Center( 
        child: Padding( 
          padding: EdgeInsets.all(16.0), 
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [ 
              Text( 
                'Login', 
                style: TextStyle(fontSize: 24, fontWeight: 
                       FontWeight.bold), 
              ), 
              SizedBox(height: 20), 
              _usernameField(_usernameController, isLoginFailed), 
              _passwordField(_passwordController, isLoginFailed), 
              SizedBox(height: 20), 
              ElevatedButton( 
                onPressed: _login, 
                style: ElevatedButton.styleFrom( 
                  backgroundColor: Colors.blue, 
                  foregroundColor: Colors.white, 
                  minimumSize: Size(200, 45), 
                ), 
                child: Text('Login'), 
              ), 
            ], // ini tutup children 
          ), 
        ), 
      ),
```

5. Lalu kita tambahkan navigasi ke HomePage saat login berhasil. Masih di login.dart, ubah method _login() menjadi seperti ini (import home.dart):

##### Contoh Program 4.12 login method login.dart

```dart
void _login() { 
    String username = _usernameController.text; 
    String password = _passwordController.text; 
 
    if (username == user1.username && password == user1.password) { 
      Navigator.pushReplacement( 
        context, 
        MaterialPageRoute(builder: (context) => HomePage()), 
      ); 
    } else { 
      setState(() { 
        isLoginFailed = true; 
      }); 
      ScaffoldMessenger.of(context).showSnackBar( 
        const SnackBar( 
          content: Text('Login Gagal: Username atau Password salah'), 
          backgroundColor: Colors.red, 
        ), 
      ); 
    } 
  }
```

Karena kita tidak ingin setelah berhasil login user bisa kembali ke halaman login dengan tombol back, kita menggunakan **pushReplacement**.

Untuk variabel isLoggedIn (boolean) sudah tidak dipakai lagi, boleh dihapus.

6. Coba jalankan aplikasi. Login, kemudian pastikan muncul list produk. Coba klik tombol back, pastikan tidak bisa kembali ke login (karena pakai pushReplacement).

7. Selanjutnya kita coba mempraktikkan **passing data**. Agar nama user ditampilkan di Appbar pada home page, jadi kita perlu mengirim **user1.nama** dari login ke home. Pertama tama kita bikin constructor bernama username dulu di home.dart

##### Contoh Program 4.13 Constructor username home.dart

```dart
class HomePage extends StatelessWidget { 
  final String nama; 
  const HomePage({super.key, required this.nama});
```

8. Akan terjadi error di login.dart. Tambahkan data untuk constructor username pada navigator. Ambil nama dari model user untuk diberikan ke home page

##### Contoh Program 4.14 update navigator login.dart

```dart
Navigator.pushReplacement( 
        context, 
        MaterialPageRoute(builder: (context) => HomePage(nama: 
        user1.nama)), 
);
```

9. Tampilkan username di AppBar home.dart. Untuk mencobanya, hot restart.

##### Contoh Program 4.15 Title AppBar home.dart

```dart
title: Text( 
          'Halo, $nama!', 
          style: TextStyle(color: Colors.white, fontWeight: 
          FontWeight.bold), 
),
```

10. Sekarang kita akan membuat halaman detail yang menampilkan informasi lengkap produk saat item diklik. Buat file baru bernama detail.dart, lalu isi dengan kode berikut:

##### Contoh Program 4.16 detail.dart

```dart
import 'package:flutter/material.dart'; 
import 'models/data.dart'; 
 
class DetailPage extends StatelessWidget { 
  final int productIndex; 
  const DetailPage({super.key, required this.productIndex}); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text('Detail Produk')), 
      body: SingleChildScrollView( 
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [ 
            Image.network( 
              products[productIndex].image, 
              width: double.infinity, 
              height: 300, 
            ), 
            Padding( 
              padding: const EdgeInsets.all(16.0), 
              child: Column( 
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [ 
                  Text( 
                    products[productIndex].name, 
                    style: const TextStyle( 
                      fontSize: 24, 
                      fontWeight: FontWeight.bold, 
                    ), 
                  ), 
                  const SizedBox(height: 8), 
                  Text( 
                    'Rp ${products[productIndex].price}', 
                    style: const TextStyle( 
                      fontSize: 20, 
                      color: Colors.blue, 
                      fontWeight: FontWeight.w600, 
                    ), 
                  ), 
                  const SizedBox(height: 16), 
                  Text( 
                    'Kategori: ${products[productIndex].category}', 
                    style: const TextStyle(fontSize: 14, color: 
Colors.grey), 
                  ), 
                  const SizedBox(height: 16), 
                  const Text( 
                    'Deskripsi:', 
                    style: TextStyle(fontSize: 16, fontWeight: 
FontWeight.bold), 
                  ), 
                  const SizedBox(height: 8), 
                  Text( 
                    products[productIndex].description, 
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
}
```

Sama seperti home page, detail page juga tidak punya state yang berubah. Halaman ini cuma menampilkan detail produk yang datanya sudah fix dari awal. Maka dari itu kita menggunakan Stateless Widget.

Di detail page, kita menambahkan parameter productIndex, yang valuenya diambil dari item produk di home page yang di klik. Index ini yang nanti akan menentukan produk dari list **products** mana yang akan dimunculkan. Jadi kita tidak perlu kirim seluruh object Product, cukup kirim index-nya saja.

11. Agar saat item produk di klik aplikasi dapat pindah ke detail page, buka kembali home.dart, **import detail.dart**, lalu isi propertiy on tap di GestureDetector.

##### Contoh Program 4.17 Navigasi ke detail (home.dart)

```dart
onTap: () { 
   Navigator.push( 
     context, 
     MaterialPageRoute( 
        builder: (context) => DetailPage(productIndex: index), 
     ), 
   ); 
},
```

Kali ini kita ingin user bisa kembali ke home page setelah melihat detail. Maka dari itu kita menggunakan method push, agar pada detail page muncul tombol back untuk user kembali.

Coba jalankan aplikasi, pastikan bisa masuk ke halaman detail dari home. Lalu klik tombol back, pastikan kembali ke home. **Bottom Navigation Bar** Sekarang kita akan membuat Bottom Navigation Bar agar user bisa pindah antara halaman Home dan Profile dengan mudah.

12. Buat file profile.dart untuk halaman profil user.

##### Contoh Program 4.18 profile.dart

```dart
import 'package:flutter/material.dart'; 
import 'login.dart'; 
 
class ProfilePage extends StatelessWidget { 
  final String nama; 
  const ProfilePage({super.key, required this.nama}); 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text('Profil')), 
      body: Center( 
        child: Padding( 
          padding: EdgeInsets.all(24.0), 
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [ 
              Icon(Icons.account_circle, size: 100, color: 
Colors.blue), 
              SizedBox(height: 20), 
              Text( 
                nama, 
                style: TextStyle(fontSize: 24, fontWeight: 
FontWeight.bold), 
              ), 
              SizedBox(height: 40), 
              ElevatedButton( 
                onPressed: () { 
                  Navigator.pushAndRemoveUntil( 
                    context, 
                    MaterialPageRoute(builder: (context) => 
LoginPage()), 
                    (route) => false, 
                  ); 
                }, 
                style: ElevatedButton.styleFrom( 
                  backgroundColor: Colors.deepOrangeAccent, 
                  foregroundColor: Colors.white, 
                  minimumSize: Size(200, 45), 
                ), 
                child: Text('Logout'), 
              ), 
            ], 
          ), 
        ), 
      ), 
    ); 
  } 
}
```

Pada button logout, kita menggunakan pushAndRemoveUntil() untuk menghapus stack navigation ketika kembali ke login page.

13. Buat file root.dart untuk menampung BottomNavigationBar. Karena ada perubahan state, kita menggunakan StatefulWidget.

##### Contoh Program 4.13 root.dart

```dart
import 'package:flutter/material.dart'; 
import 'home.dart'; 
import 'profile.dart'; 
 
class Root extends StatefulWidget { 
  final String nama; 
  const Root({super.key, required this.nama}); 
  @override 
  State<Root> createState() => _RootState(); 
} 
 
class _RootState extends State<Root> { 
  int _selectedIndex = 0; 
  @override 
  Widget build(BuildContext context) { 
    final List<Widget> pages = [ 
      HomePage(nama: widget.nama), 
      ProfilePage(nama: widget.nama), 
    ]; 
    return Scaffold( 
      body: pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar( 
        currentIndex: _selectedIndex, 
        onTap: (index) { 
          setState(() { 
            _selectedIndex = index; 
          }); 
        }, 
        items: [ 
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 
'Beranda'), 
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 
'Profil'), 
        ], 
      ), 
    ); 
  } 
}
```

14. Edit login.dart**, ganti navigasi ke HomePage menjadi Root. Jangan lupa import root.dart

##### Contoh Program 4.13 Ganti navigasi login ke root

```dart
Navigator.pushReplacement( 
        context, 
        MaterialPageRoute(builder: (context) => Root(nama: 
        user1.nama)), 
);
```

Jadi setelah login, user langsung masuk ke Root yang punya Bottom Navigation Bar, dan default-nya menampilkan HomePage (index 0). Gas hot reload aplikasi dan test semua fitur!

Atau untuk melihat hasil dari langkah praktikum ini, bisa dilihat di link repository berikut: https://github.com/AndiZirahitaf/modul_4_prak_mobile


![Ilustrasi](images/modul_4/img_p18_1_63.png)


![Gambar 4.6 Login Page  Gambar 4.7 Home Page](images/modul_4/img_p18_2_64.png)
*Gambar 4.6 Login Page  Gambar 4.7 Home Page*


![Ilustrasi](images/modul_4/img_p18_3_65.png)


![Gambar 4.8 Detail Page  Gambar 4.9 Profile Page](images/modul_4/img_p18_4_66.png)
*Gambar 4.8 Detail Page  Gambar 4.9 Profile Page*

## V. Tugas Praktikum

Buatlah sebuah aplikasi bebas yang memiliki minimal 3 halaman dan minimal menerapkan fitur:

```dart
● Navigator.push() 
● Navigator.pushReplacement() 
● Navigator.pop()
```

- Passing data antar halaman
Gunakan data dummy.
