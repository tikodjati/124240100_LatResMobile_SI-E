# Modul 3: STATE & DATA

## I. Tujuan Praktikum

- Memahami konsep state pada Flutter
- Memperkenalkan cara mengolah data pada widget.
## II. Alokasi Waktu : 1 x Pertemuan = 120 menit

## III. Dasar Teori

Pada modul sebelumnya, kita telah mempelajari tentang widget dan *layout*, yaitu bagaimana kita membuat tampilan yang menarik. Tetapi, tampilannya masih statis (tidak berubah-ubah). Di modul ini, kita akan belajar membuat tampilan yang dinamis dan bisa merespon interaksi pengguna menggunakan konsep **State.**

### A. Mengenal State

**State** adalah kondisi pada sebuah widget, yang nilainya bisa berubah dan mempengaruhi tampilan widget tersebut. Sehingga, state seringkali disebut juga dengan **"*****The Memory of a Widget*****"** karena menyimpan informasi yang diingat oleh widget. Contoh state dapat berupa angka di counter, status checkbox, atau pesan error di form login. Cara kerja state bisa kita analogikan seperti ini. Bayangkan dalam sebuah pertandingan sepak bola, terdapat **papan skor yang menunjukkan hasil pertandingan**. Pada awal permainan, skor masih 0-0. Skor ini merupakan **state**. Ketika terjadi gol, skor berubah menjadi 1–0, yang berarti **state juga berubah**. Agar perubahan ini terlihat, wasit perlu memberitahu petugas papan skor untuk **memperbarui tampilan skor**. Di Flutter, mekanismenya kurang lebih sama. Ketika pengguna melakukan interaksi, misalnya menekan tombol, nilai state akan berubah. Agar Flutter mengetahui bahwa ada perubahan tersebut dan perlu memperbarui tampilan, kita harus memanggil fungsi bernama **setState()**. Pemanggilan setState() memberi tahu Flutter bahwa ada perubahan state, sehingga fungsi **build()** akan dijalankan ulang untuk membangun kembali widget dengan state yang terbaru. Hasilnya, pengguna akan melihat tampilan UI yang telah diperbarui sesuai dengan perubahan state. Sehingga, apabila kita telaah, sebenarnya perubahan pada tampilan UI di Flutter tidak sekedar mengganti saja, itu merupakan widget baru yang dibangun ulang **(rebuild)** dengan informasi **(state)** yang disimpan sebelumnya.


![Gambar 3.1 Cara kerja state](images/modul_3/img_p2_1_18.png)
*Gambar 3.1 Cara kerja state*

### B. StatelessWidget vs StatefulWidget

Setelah memahami konsep state, sekarang kita perlu tahu bagaimana menerapkannya di Flutter. Ketika membuat halaman UI, kita harus memutuskan, **"apakah halaman ini perlu berubah atau tidak?"**. Caranya dengan mendefinisikan tipe widget yang kita gunakan: **StatelessWidget** atau **StatefulWidget**.

#### 1. StatelessWidget

Sederhananya, StatelessWidget adalah widget yang tidak dapat berubah setelah aplikasi dijalankan. Widget ini cocok untuk **menampilkan** **halaman yang statis yang tidak perlu interaksi**. Jika di halaman tersebut kita cuma nampilin teks yang tidak berubah, gambar atau icon statis, layout yang fix, kita bisa menggunakan **StatelessWidget**. Misalnya, untuk halaman *About Us* atau *Terms of Condition*.

##### Contoh Program 3.1 Contoh StatelessWidget

```dart
class AboutPage extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: Text('Tentang Aplikasi Kami'), // Teks ini tidak 
akan berubah 
    ); 
  } 
}
```

#### 2. StatefulWidget

Sedangkan, **StatefulWidget** merupakan widget yang dinamis dan dapat berubah. Widget ini dapat melakukan update tampilan, mengubah warna, teks, dan lain-lain sesuai interaksi user. Sehingga, jika suatu tampilan memiliki kriteria terdapatnya interaksi user, bisa berubah sesuai kondisi, maka kita perlu menggunakan StatefulWidget. Masih ingat tampilan default ketika membuat project flutter baru? Counter tombol? Itu menggunakan StatefulWidget karena angka yang ditampilkan akan terus bertambah seiring kita menekan tombolnya. Contoh lainnya adalah form, chat room, dan halaman keranjang belanja.

##### Contoh Program 3.2 Contoh StatefulWidget

```dart
class CounterScreen extends StatefulWidget { 
  @override 
  _CounterScreenState createState() => _CounterScreenState(); 
} 
 
class _CounterScreenState extends State<CounterScreen> { 
  int counter = 0; // Ini adalah state 
   
  @override 
  Widget build(BuildContext context) { 
    return Column( 
      children: [ 
        Text('Counter: $counter'), 
        ElevatedButton( 
          onPressed: () { 
            setState(() { 
              counter++; // State berubah 
            }); 
          }, 
          child: Text('Tambah'), 
        ), 
      ], 
    ); 
  } 
}
```

Namun, StatefulWidget memiliki kekurangan, dimana proses yang dijalankan akan **lebih berat** dibandingkan dengan Stateless karena widget ini bersifat dinamis dan perlu manage state.

Jadi, agar lebih efisien dan aplikasi kita ga terlalu berat, gunakan StatelessWidget sebisa mungkin, lalu gunakan StatefulWidget jika memang ada state yang harus berubah.

### C. Model dan Object

Sebelum memulai langkah praktikum, mari berkenalan dengan konsep model di Flutter. Model adalah suatu **struktur data** berbentuk object, yang artinya memiliki atribut. Biasa digunakan agar data yang digunakan lebih terstruktur, model bisa kita deklarasikan menggunakan class.

##### Contoh Program 3.3 Contoh Model

```dart
class Kucing { 
  String nama; 
  String jenis; 
  int umur; 
  Kucing({required this.nama, required this.jenis, required 
this.umur}); 
}
```

Ini adalah **model** dari Kucing, atau bisa kita sebut **cetak biru** dari Kucing. Model ini bisa gunakan ketika kita ingin **membuat object** kucing. Contohnya, disini kita akan membuat 2 object kucing dengan membuat variabel dari model ini.

##### Contoh Program 3.4 Membuat Object

```dart
Kucing kucing1 = Kucing(nama: 'Mimi', jenis: 'Anggora', umur: 
2); 
Kucing kucing2 = Kucing(nama: 'Tom', jenis: 'Siamese', umur: 
3);
```

Nah, dengan begini, ketika kita ingin mengetahui atribut dari seekor kucing, kita tinggal memanggil nama variabelnya lalu atributnya:

- **kucing1.nama** → "Mimi"
- **kucing2.jenis** → "Siamese"
- **kucing1.umur** → 2

![Gambar 3.2 Model](images/modul_3/img_p5_1_26.png)
*Gambar 3.2 Model*

Keuntungan menggunakan model antara lain adalah data yang lebih terstruktur, menghindari typo, lebih *readable*, sintaks yang lebih singkat, dan lebih mudah untuk di edit jika ada perubahan pada data.

Jika tanpa menggunakan model, mungkin bentuknya akan seperti ini.

##### Contoh Program 3.5 Contoh tanpa object

```dart
String namakucing1 = "Mimi"; 
String jeniskucing1 = "Anggora"; 
String umurkucing1 = 2; 
 
String namakucing2 = "Tom"; 
String jeniskucing2 = "Siamese"; 
String umurkucing2 = 3;
```

Nanti pada langkah praktikum, kita akan membuat model **User** untuk data login.

## IV. Langkah Praktikum

Pada modul kali ini, kita akan membuat sebuah form login yang interaktif. Kita akan mulai dengan StatelessWidget dulu untuk membuat UI nya, baru nanti diubah ke StatefulWidget ketika perlu handle state. Form kita nantinya terdiri dari kolom username, password, dan button. Mari kita mulai!

### A. Membuat UI Form Login

Ikuti langkah-langkah berikut:

1. Buatlah projek flutter, kemudian kosongkan halaman main.dart dan ganti home menjadi **LoginPage()** menjadi seperti berikut

##### Contoh Program 3.6 Setup Awal Project (main.dart)

```dart
import 'package:flutter/material.dart'; 
 
void main() { 
  runApp(const MainApp()); 
} 
 
class MainApp extends StatelessWidget { 
  const MainApp({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    return const MaterialApp( 
      debugShowCheckedModeBanner: false, 
      home: LoginPage(), 
    ); 
  } 
}
```

2. Tambahkan file class baru bernama login.dart, saat ini kita jadikan StatelessWidget dahulu, kemudian tambahkan widget **Scaffold** pada class tersebut menjadi seperti ini (import login.dart di main.dart).

##### Contoh Program 3.7 Scaffold (login.dart)

```dart
import 'package:flutter/material.dart'; 
 
class LoginPage extends StatelessWidget { 
  const LoginPage({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: const Text( 
          'Login Page', 
          style: TextStyle(color: Colors.white, fontWeight: 
FontWeight.bold), 
        ), 
        backgroundColor: Colors.blue, 
      ), 
    ); 
  } 
}
```

3. Kemudian jalankan program. Harusnya muncul sebuah page kosong dengan AppBar bertuliskan "LoginPage".

4. Tambahkan body pada Scaffold, berikan Column untuk menyusun widget secara vertikal. Disini, kita pisahkan **input field di widget sendiri.**

##### Contoh Program 3.8 Column (login.dart)

```dart
body: Center( 
        child: Padding( 
          padding: EdgeInsets.all(16.0), 
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [ 
              Text('this is login page'), 
              SizedBox(height: 20), 
              _usernameField(), 
              _passwordField(), 
              SizedBox(height: 20), 
            ], 
          ), 
        ), 
      ),
```

Kode 
di 
atas 
**akan** 
**error** 
karena 
_usernameField() 
dan 
_passwordField() belum dibuat. Kita akan buat di langkah selanjutnya.

5. Setelah body, di bawah class LoginPage (masih di dalam file login.dart), buatlah widget form _usernameField seperti berikut:

##### Contoh Program 3.9 Widget _usernameField (login.dart)

```dart
Widget _usernameField() { 
  return Container( 
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 
10), 
    child: TextField( 
      enabled: true, 
      decoration: InputDecoration( 
        hintText: 'Username', 
        contentPadding: EdgeInsets.all(8.0), 
        border: OutlineInputBorder( 
          borderRadius: 
BorderRadius.all(Radius.circular(8.0)), 
          borderSide: BorderSide(color: Colors.blue), 
        ), 
      ), 
    ), 
  ); 
}
```

Disini, **Container** digunakan untuk membungkus TextField sehingga dapat diberikan **padding**. Atribut **enabled: true** pada TextField digunakan untuk menandakan bahwa form tersebut dapat diisi dan atribut **hintText** digunakan untuk memberikan hint pada form.

6. Buat juga widget **_passwordField** dengan tambahan **obscureText** untuk mengamankan teks seperti berikut,

##### Contoh Program 3.10 Widget _passwordField

```dart
Widget _passwordField() { 
  return Container( 
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 
10), 
    child: TextField( 
      obscureText: true, 
      enabled: true, 
      decoration: InputDecoration( 
        hintText: 'Password', 
        contentPadding: EdgeInsets.all(8.0), 
        border: OutlineInputBorder( 
          borderRadius: 
BorderRadius.all(Radius.circular(8.0)), 
          borderSide: BorderSide(color: Colors.blue), 
        ), 
      ), 
    ), 
  ); 
}
```

7. Jalankan kode program. Pastikan kita dapat mengisi form username dan password.

8. Selanjutnya, di dalam properti children pada Column, kita tambahkan button untuk submit login. sehingga kodingnanya jadi seperti ini:

##### Contoh Program 3.11 Menambahkan Button (login.dart)

```dart
children: [ 
         Text('this is login page'), 
         SizedBox(height: 20), 
         _usernameField(), 
         _passwordField(), 
         SizedBox(height: 20), 
         ElevatedButton( 
           onPressed: (){}, 
           style: ElevatedButton.styleFrom( 
             backgroundColor: Colors.blue, 
             foregroundColor: Colors.white, 
             minimumSize: Size(200, 45), 
           ), 
           child: Text('Login'), 
         ),
]
```

Untuk properti **onPressed** kita kosongkan dulu, kedepannya akan kita 
isi dengan function.

9. Jalankan ulang program, pastikan tampilan aplikasi seperti ini dan kita dapat menggunakan input field.


![Gambar 3.3 UI Login](images/modul_3/img_p9_1_37.png)
*Gambar 3.3 UI Login*

10. Silahkan berkreasi sebanyak mungkin untuk mencoba berbagai hal seperti menambahkan gambar, text, dan lain-lain.

### B. Mengolah Data dengan State

Sekarang kita sudah punya UI form login yang bagus, namun jika kita menekan tombol login, tidak terjadi apa-apa karena kita belum menentukan action apa yang akan dilakukan. Di bagian ini, kita akan memasukkan algoritma ketika user menekan tombol login:

- Melakukan pengecekan, apakah yang di input di field benar.
- Jika salah, akan menampilkan SnackBar error.
- Jika benar, form login akan berubah menjadi menampilkan username dan password user.
Ayo kita lakukan.

1. Pertama-tama, karena kedepannya kita akan mengubah tampilan sesuai hasil login, kita perlu menggunakan method **setState()**. Maka dari itu, sekarang kita perlu mengubah LoginPage yang tadinya bersifat Stateless ke **Stateful**. Ini bisa kita lakukan dengan klik kanan pada teks StatelessWidget, **Refactor > Convert to StatefulWidget.**


![Gambar 3.4 Refactor](images/modul_3/img_p10_1_40.png)
*Gambar 3.4 Refactor*

Atau bisa manual dengan mengubah dari

##### Contoh Program 3.12 Sebelum refactor (login.dart)

```dart
class LoginPage extends StatelessWidget { 
  const LoginPage({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    // ... 
  } 
}
```

Menjadi:

##### Contoh Program 3.13 Setelah refactor ke StatefulWidget (login.dart)

```dart
class LoginPage extends StatefulWidget { 
  const LoginPage({super.key}); 
 
  @override 
  State<LoginPage> createState() => _LoginPageState(); 
} 
 
class _LoginPageState extends State<LoginPage> { 
  @override 
  Widget build(BuildContext context) { 
    // ... (isi sama seperti sebelumnya) 
  } 
}
```

2. Meskipun kita sudah bisa melakukan input pada field, namun program belum bisa **mengambil data** yang kita input. Kita perlu menggunakan yang namanya **TextEditingController**. **TextEditingController** yang digunakan untuk mengontrol dan mengambil nilai dari TextField. Pada class _LoginPageState, kita tambahkan TextEditingController untuk username dan password. Sekaligus variabel state bernama **isLoggedIn** untuk tracking apakah user sudah login atau belum.

##### Contoh Program 3.14 Menambahkan TextEditingController

```dart
class _LoginPageState extends State<LoginPage> { 
  
final 
TextEditingController 
_usernameController 
= 
TextEditingController(); 
  
final 
TextEditingController 
_passwordController 
= 
TextEditingController(); 
  bool isLoggedin = false; 
 
  @override 
  Widget build(BuildContext context) { 
    // ... (kode build seperti sebelumnya) 
  } 
}
```

3. Tambahkan atribut controller dan parameter pada widget _usernameField, Lakukan hal yang sama pada _passwordField.

##### Contoh Program 3.15 Menambahkan Controller (login.dart)

```dart
Widget _usernameField(TextEditingController controller) { 
  return Container( 
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 
10), 
    child: TextField( 
      controller: controller, 
      enabled: true, 
      decoration: InputDecoration( 
        hintText: 'Username', 
        contentPadding: EdgeInsets.all(8.0), 
        border: OutlineInputBorder( 
          borderRadius: 
BorderRadius.all(Radius.circular(8.0)), 
          borderSide: BorderSide(color: Colors.blue), 
        ), 
      ), 
    ), 
  ); 
} 
 
Widget _passwordField(TextEditingController controller) { 
  return Container( 
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 
10), 
    child: TextField( 
      controller: controller, 
      obscureText: true, 
      enabled: true, 
      decoration: InputDecoration( 
        hintText: 'Password', 
        contentPadding: EdgeInsets.all(8.0), 
        border: OutlineInputBorder( 
          borderRadius: 
BorderRadius.all(Radius.circular(8.0)), 
          borderSide: BorderSide(color: Colors.blue), 
        ), 
      ), 
    ), 
  ); 
}
```

Kita menggunakan parameter agar widget _usernameField dan _passwordField tahu controller mana yang harus dia pakai. Kita akan **passing** 
_usernameController 
dan 
_passwordController 
dari _LoginPageState ke kedua widget ini.

4. Sekarang karena _usernameField dan _passwordField punya parameter, kita harus passing controller saat memanggilnya di Column.

##### Contoh Program 3.16 Update body untuk controller

```dart
body: Center( 
  child: Padding( 
    padding: EdgeInsets.all(16.0), 
    child: Column( 
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [ 
        Text('this is login page'), 
        SizedBox(height: 20), 
        _usernameField(_usernameController),        
        _passwordField(_passwordController), 
        SizedBox(height: 20), 
        _loginButton(), 
      ], 
    ), 
  ), 
),
```

5. Selanjutnya kita akan membuat function _login() yang akan dipanggil saat button Login diklik. Function ini akan:

a. Menggunakan data TextEditingController yang diambil dari TextField

b. Mengecek apakah username dan password cocok

c. Mengubah state isLoggedin sesuai hasil pengecekan

d. Menampilkan pesan error jika login gagal Tambahkan didalam _LoginPageState

##### Contoh Program 3.17 Modifikasi teknis untuk login

```dart
class _LoginPageState extends State<LoginPage> { 
  final TextEditingController _usernameController = 
TextEditingController(); 
  final TextEditingController _passwordController = 
TextEditingController(); 
  bool isLoggedin = false; 
 
  void _login() { 
    String username = _usernameController.text; 
    String password = _passwordController.text; 
     
    if (username == "budi123" && password == "password123")  
    { 
      setState(() { 
        isLoggedin = true; 
      }); 
    } else { 
      ScaffoldMessenger.of(context).showSnackBar( 
        const SnackBar( 
          content: Text('Login gagal: Username atau 
Password salah'), 
        ), 
      ); 
    } 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    // ... (kode build seperti sebelumnya) 
  } 
}
```

Disini bisa dilihat bahwa untuk mengambil value dari TextField dengan TextEditingController adalah dengan memanggil atribut .text. Disini value tersebut kita simpan lagi ke dalam variabel baru.

Kemudian, validasinya menunjukkan bahwa kriteria login berhasil adalah jika username adalah **budi123** dan password adalah **password123**.

isLoggedIn defaultnya **false**. Jika pengecekan terpenuhi (benar), **setState()** akan mengubah isLoggedIn menjadi **true**. isLoggedIn akan tetap menjadi false jika tidak menggunakan setState. Variabel ini yang nantinya akan kita gunakan utk acuan utk perubahan tampilannya.

6. Kita hubungkan button agar memanggil function _login saat diklik.

##### Contoh Program 3.18 Update Button onPressed

```dart
ElevatedButton( 
  onPressed: _login, // Panggil function _login saat diklik 
  style: ElevatedButton.styleFrom( 
    backgroundColor: Colors.blue, 
    foregroundColor: Colors.white, 
    minimumSize: Size(200, 45), 
  ), 
  child: Text('Login'), 
),
```

7. Silahkan jalankan project, dan coba masukkan username dan password yang salah lalu tekan tombol submit. Jika salah, Snackbar error harusnya muncul. Jika benar harusnya belum terjadi apa apa.

8. Sekarang kita ingin memasukkan algoritma: jika login benar, page login akan berubah menjadi memunculkan username dan password nya. Ini bisa kita lakukan 
dengan metode **conditional rendering**, dimana teknik ini memungkikan program untuk merender tampilan sesuai dengan keadaan mana yang terpenuhi. Lakukan ini pada body.

##### Contoh Program 3.19 Penambahan untuk conditional rendering

```dart
//ini hanya merupakan snippet code, sisanya sama 
 
body: Center( 
        child: Padding( 
          padding: EdgeInsets.all(16.0), 
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [ 
              if (!isLoggedin) ...[ 
                Text('this is login page'), 
                SizedBox(height: 20), 
                _usernameField(_usernameController), 
                _passwordField(_passwordController), 
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
              ] else ...[ 
                Text('Halo, User!'), 
                SizedBox(height: 20), 
                Text('Pasti username kamu: budi123'), 
                Text('Pasti password kamu: password123'), 
              ], 
            ], 
          ), 
        ), 
      ),
```

Conditional Rendering dilakukan dengan menggunakan **if else**.

Pengecekan dilakukan dengan menggunakan isLoggedIn, sama sepertinya if else pada umumnya, widget ditampilkan berdasarkan conditional yang terpenuhi.

9. Jalankan program kembali. Jika username atau password sesuai, maka widget akan dibangun ulang dan akan memunculkan tampilan baru, dan apabila salah akan memunculkan SnackBar.

### C. Menggunakan Model

Sampai sini, tujuan kita untuk membuat algoritma login sebenarnya sudah selesai. Namun, sekarang kita lanjut menerapkan konsep Model yang sudah kita pelajari di Dasar Teori. Model akan membuat data kita lebih terstruktur.

1. Kita akan membuat model User, agar nantinya atribut username dan password yang dimiliki user akan kita jadikan acuan pengecekan pada login page. Buat folder baru bernama **models,** di dalamnya buat file baru bernama **data.dart**, tambahkan model User, dan buat satu user:

##### Contoh Program 3.20 data.dart

```dart
class User { 
  String username; 
  String password; 
  String nama; 
 
  User({required this.username, required this.password, 
required this.nama}); 
} 
 
User user1 = User( 
  username: 'budi123', 
  password: 'password123', 
  nama: 'Budi Doremi', 
);
```

Jangan lupa untuk **import data.dart** pada file **main.dart** agar file 
data.dart-nya terbaca!

2. Nah, tadi kan ketika login, pengecekan yang kita lakukan kan langsung dimasukkan (string) di statement if nya:

##### Contoh Program 3.21.1 Statement if di method login (login.dart)

```dart
if (username == "budi123" && password == "password123") {
```

Sekarang, kita ganti dari model User yang telah kita buat tadi. **Import** **data.dart di login.dart**, lalu ubah statement if-nya jadi seperti ini

##### Contoh Program 3.21.2 Statement if di method login (login.dart)

```dart
if (username == user1.username && password == user1.password) 
{
```

Sebenarnya value yang di cek sama aja, cuman asal dari datanya beda. Sekarang data berasal dari Model User yang lebih terstruktur.

3. Lalu, di conditional rendering else, ubah juga agar menampilkan nama dari model User

##### Contoh Program 3.22 Update Conditional Rendering dengan Model

```dart
] else ...[ 
                Text('Halo, ${user1.nama}!'), 
                SizedBox(height: 20), 
                Text('Pasti username kamu: 
${user1.username}'), 
                Text('Pasti password kamu: 
${user1.password}'), 
 ],
```

Catatan, jangan pernah menampilkan password di UI ya, ini hanya 
untuk demo pembelajaran

4. Jalankan aplikasi dan tes dengan data dari model.

### D. Error Handling

Sekarang kita akan membuat form login menjadi lebih interaktif dengan mengubah warna border TextField menjadi merah saat login gagal. Ini adalah contoh bagus **bagaimana state dapat mengubah styling widget.**

1. Karena sebelumnya kita memiliki variabel isLoggedin (sebagai indikator sudah ada login/belum), kita buat variabel isLoginFailed (sebagai indikator error login).

##### Contoh Program 3.23 Menambahkan isLoginFailed

```dart
class _LoginPageState extends State<LoginPage> { 
  final TextEditingController _usernameController = 
TextEditingController(); 
  final TextEditingController _passwordController = 
TextEditingController(); 
  bool isLoggedin = false; 
  bool isLoginFailed = false; // Tambahkan variabel ini 
 
  // ... (function _login dan build di bawah) 
}
```

Kita bisa saja cuma pakai isLoggedin, tapi dengan punya isLoginFailed terpisah, kode bisa lebih tepat **menjelaskan "ada error" atau** **"belum login"**, dan lebih mudah untuk handle berbagai kondisi di masa depan.

2. Mari kita sesuaikan dengan kodingan kita sebelumnya, terutama di function _Login yang akan menghasilkan state baru:

##### Contoh Program 3.24 Update Function _login

```dart
void _login() { 
    String username = _usernameController.text; 
    String password = _passwordController.text; 
    if (username == user1.username && password == 
user1.password) { 
      setState(() { 
        isLoggedin = true; 
        isLoginFailed = false; 
      }); 
    } else { 
      setState(() { 
        isLoggedin = false; 
        isLoginFailed = true; 
      }); 
      ScaffoldMessenger.of(context).showSnackBar( 
        const SnackBar( 
          content: Text('Login failed. Incorrect username or 
password.'), 
        ), 
      ); 
    } 
  }
```

3. Setelah hal-hal di atas selesai kita lakukan sudah saatnya kita buat tampilannya, 
kita 
akan 
memodifikasi 
_usernameField 
dan 
juga _passwordField. Tambahkan kodingan yang di bold di dalam atribut decoration, pada function _usernameField dan _passwordField.

##### Contoh Program 3.25 Dynamic Styling TextField

```dart
decoration: InputDecoration( 
          hintText: 'Username', 
          contentPadding: EdgeInsets.all(8.0), 
          border: OutlineInputBorder( 
            borderRadius: 
BorderRadius.all(Radius.circular(8.0)), 
            borderSide: BorderSide( 
              color: isLoginFailed ? Colors.red : 
Colors.blue, 
            ), 
          ), 
          enabledBorder: OutlineInputBorder( 
            borderRadius: 
BorderRadius.all(Radius.circular(8.0)), 
            borderSide: BorderSide( 
              color: isLoginFailed ? Colors.red : 
Colors.blue, 
              width: 2.0, 
            ), 
          ), 
        ),
```

4. Namun, akan terjadi error. Pada kedua widget, variabel isLoginFailed tidak dikenali karena **dideklarasikan di class yang berbeda**. Maka dari itu variabel ini perlu kita passing melalui parameter juga.

##### Contoh Program 3.26 Parameter isLoginFailed

```dart
// Di build 
_usernameField(_usernameController, isLoginFailed), 
_passwordField(_passwordController, isLoginFailed),

// parameter function _usernameField
Widget _usernameField(TextEditingController controller, 
bool isLoginFailed) 
 
// parameter function _passwordField 
Widget _passwordField(TextEditingController controller, 
bool isLoginFailed)
```

5. Jalankan program dan perhatikan hasilnya ketika kita melakukan kesalahan dan gagal dalam melakukan proses login


![Gambar 3.5 Error Handling](images/modul_3/img_p19_1_60.png)
*Gambar 3.5 Error Handling*

### E. Membuat Widget Reusable

Salah satu prinsip penting dalam coding adalah **menghindari** **duplikasi** **kode.** Jika kita perhatikan widget _usernameField dan _passwordField memiliki struktur yang hampir sama, perbedaannya  hanya pada hintText dan obscureText. Daripada membuat dua widget terpisah yang mirip, kita bisa membuat **satu widget** ***reusable*** yang menerima parameter untuk perbedaan tersebut.

Langkah ini **opsional**, tapi sangat direkomendasikan untuk melatih kebiasaan coding yang baik.

1. Tambahkan widget baru bernama _inputField.

##### Contoh Program 3.27 Widget _inputField

```dart
Widget _inputField({ 
  required TextEditingController controller, 
  required String hint, 
  required bool isLoginFailed, 
  bool obscure = false, 
}) { 
  return Container( 
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 
10), 
    child: TextField( 
      controller: controller, 
      obscureText: obscure, 
      enabled: true, 
      decoration: InputDecoration( 
        hintText: hint, 
        contentPadding: EdgeInsets.all(8.0), 
        border: OutlineInputBorder( 
          borderRadius: 
BorderRadius.all(Radius.circular(8.0)), 
          borderSide: BorderSide(color: Colors.blue), 
        ), 
        enabledBorder: OutlineInputBorder( 
          borderRadius: 
BorderRadius.all(Radius.circular(8.0)), 
          borderSide: BorderSide( 
            color: isLoginFailed ? Colors.red : Colors.blue, 
            width: 2.0, 
          ), 
        ), 
      ), 
    ), 
  ); 
}
```

2. Lalu perbarui widget _usernameField dan _passwordField menjadi seperti 
berikut:

##### Contoh Program 3.28 Update _usernameField & _passwordField

```dart
Widget _usernameField(TextEditingController controller, bool 
isLoginFailed) { 
  return _inputField( 
    controller: controller, 
    hint: 'Username', 
    isLoginFailed: isLoginFailed, 
  ); 
} 
 
Widget _passwordField(TextEditingController controller, bool 
isLoginFailed) { 
  return _inputField( 
    controller: controller, 
    hint: 'Password', 
    isLoginFailed: isLoginFailed, 
    obscure: true, 
  ); 
}
```

Untuk melihat hasil dari langkah praktikum ini, bisa dilihat di link repository berikut: https://github.com/AndiZirahitaf/modul_3_prak_mobile.

## V. Tugas Praktikum

Buatlah sebuah aplikasi bebas yang menerapkan konsep state management dengan minimal fitur:

- StatefulWidget
- TextEditingController
- setState()
- Conditional rendering
- Model/Class untuk struktur data