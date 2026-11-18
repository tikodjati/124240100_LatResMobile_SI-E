# Modul 6: LOCAL STORAGE

## I. Tujuan Praktikum

- Mampu memahami penggunaan Shared Preferences
- Mampu memahami penggunaan Hive
- Mampu membuat Local Database
## II. Alokasi Waktu : 1 x Pertemuan = 120 menit

## III. Dasar Teori

### A. Local Storage

Local Storage adalah mekanisme penyimpanan data secara permanen di dalam memori internal perangkat pengguna. Berbeda dengan penyimpanan berbasis cloud yang membutuhkan koneksi internet, data yang disimpan di local storage akan tetap tersimpan meskipun pengguna telah keluar dari aplikasi atau mematikan perangkatnya. Sebenarnya ada banyak prinsip lain dan jenis local storage yang bisa digunakan, namun pada modul kali ini kita akan mempelajari dua contoh penerapan dari Local Storage, yaitu **Shared Preferences** & **Hive.**

### B. Shared Preferences

Shared Preferences memiliki fungsi yang hampir sama dengan session, dengan menggunakan Shared Preferences maka data yang telah diinputkan atau diubah akan tetap tersimpan meskipun telah keluar dari aplikasi tersebut. Menggunakan prinsip *key-value* nantinya data akan disimpan di XML untuk digunakan lebih lanjut. Contohnya adalah penerapan pada authentication.

Untuk contoh sintaks dari Shared Preferences, akan kita bahas langsung di Langkah Praktikum.

### C. Hive

Hive adalah sebuah database noSQL yang ditulis murni menggunakan bahasa Dart. Hive memiliki banyak keunggulan dibandingkan dengan database lain.


![Gambar 6.1 Perbandingan Hive dengan database lain](images/modul_6/img_p2_1_20.png)
*Gambar 6.1 Perbandingan Hive dengan database lain*

Salah satu diantaranya adalah karena Hive memiliki runtime yang cukup kecil dibandingkan dengan SQLite (contoh, ketika membaca dan menulis 1000 *entries*). Selain itu, Hive dapat digunakan secara cross-platform pada mobile, desktop, ataupun browser.

Dalam Hive dikenal istilah **Box**, ini merupakan unit penyimpanan utama pada Hive, ataupun selayaknya tabel pada database SQL, selayaknya pada tabel di database SQL Box juga harus memiliki nama yang identik.

Selain menyimpan tipe data pada umumnya, Hive juga dapat menyimpan tipe data custom menggunakan **TypeAdapter & HiveObject**, salah satu penerapannya ialah kita dapat **menyimpan Class** langsung menggunakan Hive.

Berbeda dengan database lain untuk melakukan CRUD, Hive memiliki caranya sendiri tanpa SQL namun menggunakan method yang telah tersedia.

##### Contoh program 6.1 Operasi CRUD pada hive

```dart
Create Data 
: add(value) 
Retrieve Data
: getAt(index) 
Update Data 
: putAt(index) 
Delete Data 
: deleteAt(index)
```

Setelah membaca penjelasan diatas, bisa kita simpulkan bahwa peran dari Shared Preferences dan Hive sebagai penerapan dari *local storage* adalah seperti berikut:

#### 1. Shared Preferences berperan sebagai penyimpanan lokal yang ringan, hanya

menyimpan data sederhana, yang menggunakan *key-value.* Bersifat cepat untuk diakses, namun tidak cocok untuk data yang kompleks. Maka dari itu, biasanya **SP digunakan untuk autentikasi, tema, dll.**

2. Sedangkan untuk Hive, karena adalah *local database*, berperan untuk menyimpan data di aplikasi yang memang disimpan secara lokal di device pengguna. Hive bisa menyimpan objek-objek yang kompleks, seperti list, nested data, dan lain-lain. Hive bersifat reaktif. Berdasarkan hal tersebut, Hive lebih cocok digunakan untuk **data utama aplikasi**. Contohnya aplikasi to-do list.

## IV. LANGKAH PRAKTIKUM

### A. Pendahuluan: Membuat Aplikasi To-do List dengan menerapkan Shared

**Preferences serta menggunakan Hive**


![Gambar 6.2 Alur Authentication menggunakan Shared Preferences yang akan dibuat](images/modul_6/img_p3_1_23.png)
*Gambar 6.2 Alur Authentication menggunakan Shared Preferences yang akan dibuat*

Konsep yang digunakan pada aplikasi To-do List kali ini adalah penggunaan Shared Preferences yang diterapkan untuk *authentication,* dimana SP akan **menyimpan memori login sebelumnya** apabila telah ada. Selanjutnya aplikasi dapat dijalankan **tanpa menggunakan internet** karena nantinya To-do list akan disimpan menggunakan Hive, nantinya kita dapat menerapkan CRUD sebagai operasi dasar dan inti dari program ini.

Penggunaan SharedPreferences sendiri nanti hanya akan diterapkan pada **login_screen.dart** 
dan 
**home_screen.dart**. 
Sehingga 
jangan 
lupa 
untuk menambahkan import SharedPreferences pada kedua file tersebut.

##### Contoh program 6.2 import shared preferences package

```dart
import 'package:shared_preferences/shared_preferences.dart';
```

Kemudian jika kita ingin melakukan penyimpanan data pada Shared Preferences 
kita 
bisa 
melakukannya 
dengan 
menggunakan 
`set(Tipe`

```dart
data)('nama_key', nilai_key)
```

##### Contoh program 6.4 menginisiasi nilai shared preferences

```dart
logindata.setBool('loginData', true);
```

Keterangan : 'loginData' sebagai key atau kunci sedangkan true adalah nilai dari kunci tersebut.

Setelah itu untuk mengambil data pada Shared Preferences adalah dengan menggunakan code berikut

##### Contoh program 6.5 mengambil nilai shared preferences

```dart
Final adaLogin = logindata.getBool('loginData');
```

Pada baris tersebut 'adaLogin' adalah kunci yang memegang nilai dari username itu.

Nah inilah yang merupakan **inti dari Shared Preferences**, hal ini bisa kalian terapkan di hal lainnya dengan konsep yang sama. yaitu ada bagian untuk **membuat** **nilai Shared Preferences** dan nantinya akan ada yang **mengecek nilai Shared** **Preferences**. Kalian hanya perlu memahami **nilai apa** yang kalian **'set'** dan **apa** yang akan kalian **ambil**, sesuaikan dengan kebutuhan yang kalian inginkan.

### B. Langkah Pengerjaan

1. Buat sebuah project flutter baru.

2. Tambahkan dependency Shared Preferences dan Hive databases pada pubspec.yaml

##### Contoh program 6.6 Import packages pada pubspec.yaml

```yaml
dependencies: 
 shared_preferences: ^2.5.3 
 hive: ^2.2.3 
 hive_flutter: ^1.1.0 
 
dev dependencies: 
 hive_generator: ^2.0.1
 build_runner: ^2.4.8 //tersedia hingga 2.13.1 (21-03-2026)
```

3. Setelah menambahkan dependency, pada bagian atas akan muncul Flutter Commands, klik **Packages get** atau **Pub Get**

4. Menuju pada step pertama, masukkan kode berikut pada **main.dart**

##### Contoh program 6.7 Kodingan lengkap halaman main.dart

```dart
import 'package:flutter/material.dart'; 
import '../models/todo.dart'; //Bisa nanti 
import '../screens/login_screen.dart'; //Bisa nanti 
import 'package:hive_flutter/hive_flutter.dart'; 
 
void main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
  await Hive.initFlutter(); 
  Hive.registerAdapter(TodoAdapter()); 
  await Hive.openBox<Todo>('todos'); 
 
  runApp(MainApp()); 
} 
 
class MainApp extends StatelessWidget { 
  const MainApp({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      debugShowCheckedModeBanner: false, 
      home: LoginScreen(), 
    ); 
  } 
}
```

Sekilas cukup umum baris kode yang kita miliki di dalam file main.dart ini. Satu-satunya baris yang perlu kita perhatikan adalah baris mengenai deklarasi database yang kita buat. Mari kita bahas!

```dart
a. WidgetsFlutterBinding.ensureInitialized() : baris
```

kode ini bertanggung jawab untuk memastikan bahwa demikian? jika kita perhatikan **fungsi main()** bersifat **async** hal ini dikarenakan ada kodingan di dalamnya (selanjutnya kita bahas) yang menggunakan await. Sehingga baris ini penting digunakan agar program tidak crash.

```dart
b. await Hive.initFlutter() : Nah kalau baris ini
```

berfungsi untuk **menginisialisasi Hive** dan menentukan lokasi penyimpanan database di perangkat kita.

```dart
c. Hive.registerAdapter(TodoAdapater()) : Baris ini
```

menandakan **kita mendaftarkan adapter kita**. Seperti penjelasan 
sebelumnya 
**adapter** 
**digunakan** 
**untuk** **menyimpan object dart custom** yang kita miliki. Pada kasus kali 
ini 
namanya 
TodoAdapter() 
(nanti 
pada 
langkah selanjutnya kita akan membahas mengenai ini).

```dart
d. await Hive.openBox<Todo>('todos') : Terakhir, baris
```

ini bertanggung jawab sebagai langkah kita **'membuka'** **database**. Tipenya adalah **<Todo>** dan nama box/ table-nya (agar lebih mudah paham) adalah **'todos'**.

5. Selanjutnya adalah pembuatan class custom kita, karena kita menyimpan data To-do nanti dalam bentuk sebuah class object. Kita beri nama filenya **todo.dart.** Buat dulu folder models, lalu bikin todo.dart didalamnya.

##### Contoh program 6.8 Membuat class custom pada todo.dart

```dart
import 'package:hive/hive.dart'; 
part 'todo.g.dart'; 
 
@HiveType(typeId: 0) 
class Todo extends HiveObject { 
  @HiveField(0) 
  final String title; 
  @HiveField(1) 
  final String subtitle; 
 
  Todo({required this.title, required this.subtitle}); 
}
```

Ini artinya kita memiliki object dart custom yang bernama Todo dan kita memiliki dua atribut di dalamnya yang ditandai dengan @HiveField yaitu title dan subtitle.

Selain itu (typeId:0) berfungsi sebagai identifier class kita di Hive, jadi mudahnya adalah typeId : 0 = Class Todo (Hive itu tidak menyimpan nama class saat menyimpan ke disk, yang disimpan adalah angka ini.

Oleh karena itu perhatikan Id yang kalian gunakan jika memiliki Box yang banyak).

Jangan lupa! setelah menulis kode ini, jalankan build runner di dalam terminal kalian dengan mengetikkan kode ini **'dart run build_runner** **build'**. Nantinya akan ada file generate baru bernama **todo.g.dart** kemudian 
kita 
**HANYA** mengganti nama adapternya menjadi **TodoAdapter**.

6. Pada percobaan pembuatan fitur login dan logout ini kita akan menggunakan dua file pada dua kelas yang berbeda. Pada file pertama yaitu **login_screen.dart** terdapat Kelas **LoginScreen** yang digunakan untuk setting nilai Shared Preferences dan melakukan pengecekan nilai tersebut. Kemudian pada file kedua yaitu **home_screen.dart** terdapat kelas **HomeScreen** yang nantinya akan digunakan untuk melakukan logout.

7. Pertama, dalam lib kita buat dulu folder bernama screens, didalamnya buat file **login_screen.dart** dan lakukan import package yang diperlukan.

##### Contoh program 6.9 Import pada file login_screen.dart

```dart
import 'package:flutter/material.dart'; 
import '../screens/home_screen.dart'; //Bisa nanti 
import 'package:shared_preferences/shared_preferences.dart';
```

8. Setelah itu buat class **LoginScreen** menggunakan StatefulWidget yang sebelumnya dipanggil dari kelas **MainApp** pada file **Main.dart**.

##### Contoh program 6.10 Membuat class LoginScreen (StatefulWidget)

```dart
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget { 
  const LoginScreen({super.key}); 
 
  @override 
  State<LoginScreen> createState() => _LoginScreenState(); 
} 
 
class _LoginScreenState extends State<LoginScreen> { 
  @override 
  Widget build(BuildContext context) { 
    return const Placeholder(); 
  } 
}
```

9. Pada fitur Login pasti terdapat Textfield yang digunakan untuk menuliskan username/email dan password dan juga button untuk submit atau mengirimkan data.

##### Contoh program 6.11 Membuat UI pada  login_screen.dart

```dart
class _LoginScreenState extends State<LoginScreen> { 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      backgroundColor: Colors.deepPurple, 
      body: Center( 
        child: Container( 
          padding: EdgeInsets.all(24), 
          child: Card( 
            shape: RoundedRectangleBorder( 
              borderRadius: BorderRadius.circular(16), 
            ), 
            child: Padding( 
              padding: EdgeInsets.all(24), 
              child: Column( 
                mainAxisSize: MainAxisSize.min, 
                children: [ 
                  TextField( 
                    controller: _usernameController, 
                    decoration: InputDecoration( 
                      labelText: 'Username', 
                      prefixIcon: Icon(Icons.person_outline), 
                      border: OutlineInputBorder(), 
                    ), 
                  ), 
                  SizedBox(height: 16), 
                  TextField( 
                    controller: _passwordController, 
                    decoration: InputDecoration( 
                      labelText: 'Password', 
                      prefixIcon: Icon(Icons.lock_outline), 
                      border: OutlineInputBorder(), 
                    ), 
                  ), 
                  SizedBox(height: 12), 
                  SizedBox( 
                    width: double.infinity, 
                    child: ElevatedButton( 
                      style: ElevatedButton.styleFrom( 
                        backgroundColor: Colors.deepPurple, 
                        foregroundColor: Colors.white, 
                        padding: 
EdgeInsets.symmetric(vertical: 14), 
                        shape: RoundedRectangleBorder( 
                          borderRadius: 
BorderRadius.circular(8), 
                        ), 
                      ), 
                      onPressed: _login, 
                      child: Text('Login', style: 
TextStyle(fontSize: 16)), 
                    ), 
                  ), 
                ], 
              ), 
            ), 
          ), 
        ), 
      ), 
    ); 
  } 
}
```

Tampilan dari aplikasi setelah kode dibuat akan menjadi seperti ini


![Gambar 6.3 Tampilan login_screen.dart secara lengkap](images/modul_6/img_p9_1_39.png)
*Gambar 6.3 Tampilan login_screen.dart secara lengkap*

10. Setelah tampilan dibuat, selanjutnya kita akan membuat function-function yang 
mendukung 
operasi 
login. 
Code 
ini 
ditulis 
di 
dalam state _**LoginScreenState** ya!.

a. Void **_login()** Ini merupakan fungsi yang akan melakukan validasi username & password serta nantinya akan memberikan nilai untuk Shared Preferences kita!

##### Contoh program 6.12 Membuat fungsi _login()

```dart
void _login() async { 
    final username = _usernameController.text.trim(); 
    final password = _passwordController.text.trim(); 
    if (username == 'budi123' && password == 
'password123') { 
      final loginData = await 
SharedPreferences.getInstance(); 
      await loginData.setBool('loginData', true); 
      if (mounted) { 
        Navigator.pushReplacement( 
          context, 
          MaterialPageRoute(builder: (context) => const 
HomeScreen()), 
        ); 
      } 
    } 
  }
```

Perhatikan lah baris kode yang diberikan tanda tebal di atas ini!

baris-baris ini lah yang bertanggung jawab dalam **menyimpan nilai** **pada Shared Preferences** dan **mengarahkannya ke HomeScreen** apabila login berhasil.

Jangan lupa buat dulu variabel controller nya dan import package shared preferences.

b. Void **_checkLogin()** Fungsi ini berguna untuk melakukan pengecekan nilai Shared Preferences yang tersimpan. Nantinya fungsi ini akan kita dijalankan di **initState()** agar selalu dijalankan setiap kali file ini dimuat.

##### Contoh program 6.13 Membuat fungsi _checklogin()

```dart
void _checkLogin() async { 
    final loginData = await 
SharedPreferences.getInstance(); 
    final adaLogin = loginData.getBool('loginData') ?? 
false; 
    if (adaLogin && mounted) { 
      Navigator.pushReplacement( 
          context, MaterialPageRoute(builder: (context) 
=> HomeScreen())); 
    } 
  }
```

Perhatikan lah baris kode yang diberikan tanda tebal di atas ini!

Terutama pada baris **variabel adaLogin**, baris tersebut mengambil nilai key **'loginData'** yang sebelumnya ada dan apabila tidak ada maka akan disetting menjadi false.

11. Setelah kita menambah semuanya saatnya untuk melakukan penyesuaian dengan 
**menambahkan** 
**beberapa** 
**build** 
**(initState** 
**&** 
**Dispose),** **menambahkan controller username & password, dst**. Codingan lengkap **LoginScreen.dart** bisa dilihat di bawah sini!

##### Contoh program 6.14 Kodingan lengkap login.dart

```dart
import 'package:flutter/material.dart'; 
import 'home_screen.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 
 
class LoginScreen extends StatefulWidget { 
  const LoginScreen({super.key}); 
 
  @override 
  State<LoginScreen> createState() => _LoginScreenState(); 
} 
 
class _LoginScreenState extends State<LoginScreen> { 
  final _usernameController = TextEditingController(); 
  final _passwordController = TextEditingController(); 
 
  @override 
  void initState() { 
    super.initState(); 
    _checkLogin(); 
  } 
 
  void _checkLogin() async { 
    final loginData = await SharedPreferences.getInstance(); 
    final adaLogin = loginData.getBool('loginData') ?? false; 
    if (adaLogin && mounted) { 
      Navigator.pushReplacement( 
          context, MaterialPageRoute(builder: (context) => 
HomeScreen())); 
    } 
  } 
 
  void _login() async { 
    final username = _usernameController.text.trim(); 
    final password = _passwordController.text.trim(); 
    if (username == 'budi123' && password == 'password123') { 
      final loginData = await 
SharedPreferences.getInstance(); 
      await loginData.setBool('loginData', true); 
      if (mounted) { 
        Navigator.pushReplacement( 
          context, 
          MaterialPageRoute(builder: (context) => const 
HomeScreen()), 
        ); 
      } 
    } 
  } 
 
  @override 
  void dispose() { 
    _usernameController.dispose(); 
    _passwordController.dispose(); 
    super.dispose(); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      backgroundColor: Colors.deepPurple, 
      body: Center( 
        child: Container( 
          padding: EdgeInsets.all(24), 
          child: Card( 
            shape: RoundedRectangleBorder( 
              borderRadius: BorderRadius.circular(16), 
            ), 
            child: Padding( 
              padding: EdgeInsets.all(24), 
              child: Column( 
                mainAxisSize: MainAxisSize.min, 
                children: [ 
                  TextField( 
                    controller: _usernameController, 
                    decoration: InputDecoration( 
                      labelText: 'Username', 
                      prefixIcon: Icon(Icons.person_outline), 
                      border: OutlineInputBorder(), 
                    ), 
                  ), 
                  SizedBox(height: 16), 
                  TextField( 
                    controller: _passwordController, 
                    decoration: InputDecoration( 
                      labelText: 'Password', 
                      prefixIcon: Icon(Icons.lock_outline), 
                      border: OutlineInputBorder(), 
                    ), 
                  ), 
                  SizedBox(height: 12), 
                  SizedBox( 
                    width: double.infinity, 
                    child: ElevatedButton( 
                      style: ElevatedButton.styleFrom( 
                        backgroundColor: Colors.deepPurple, 
                        foregroundColor: Colors.white, 
                        padding: 
EdgeInsets.symmetric(vertical: 14), 
                        shape: RoundedRectangleBorder( 
                          borderRadius: 
BorderRadius.circular(8), 
                        ), 
                      ), 
                      onPressed: _login, 
                      child: Text('Login', style: 
TextStyle(fontSize: 16)), 
                    ), 
                  ), 
                ], 
              ), 
            ), 
          ), 
        ), 
      ), 
    ); 
  } 
}
```

Nah sebenarnya sampai pada tahap ini kita telah melakukan hal penting untuk Shared Preferences. Kita telah melakukan penyimpanan dan **pemberian nilai** pada token **'loginData'**, kita juga telah membuat **fungsi validasi** token **'_checkLogin'**. Jadi penerapan Shared Preferences telah selesai.

Nah disini HomeScreen akan masih error karena belum kita buat.

Nantinya pada file **home_screen.dart**, hal yang berhubungan dengan Shared 
Preferences 
digunakan 
**hanya** 
**untuk** 
**logout**. 
Jadi kedepannya kita akan mulai dalam Tahap **Implementasi Database** **Hive**, Perhatikan dengan baik ya!

12. Kita 
telah 
selesai 
membuat 
**login_screen.dart** 
saatnya 
membuat **home_screen.dart** yang nantinya akan kita kembangkan lebih lanjut!

13. Import packages di file home_screen.dart yang akan digunakan

##### Contoh program 6.15 Import pada home_screen.dart

```dart
import 'package:flutter/material.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 
import '../screens/login_screen.dart'; 
import '../models/todo.dart'; 
import '../screens/add_todo_screen.dart'; //Bisa nanti 
import 'package:hive_flutter/hive_flutter.dart';
```

14. Buat class Stateful Widget bernama **HomeScreen**

##### Contoh program 6.16 Membuat class HomeScreen (StatefulWidget)

```dart
class HomeScreen extends StatefulWidget { 
  const HomeScreen({super.key}); 
 
  @override 
  State<HomeScreen> createState() => _HomeScreenState(); 
} 
 
class _HomeScreenState extends State<HomeScreen> { 
  @override 
  Widget build(BuildContext context) { 
    return const Placeholder(); 
  } 
}
```

15. Nah sekarang kita akan membuat UI-nya terlebih dahulu, nantinya pada halaman ini akan memunculkan daftar-daftar To-do yang telah kita buat sebelumnya dengan menggunakan ListView.builder seperti yang telah kita pelajari sebelumnya. Kalian bisa codingan di bawah ini

##### Contoh program 6.17 Membuat UI pada home_screen.dart

```dart
@override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: const Text( 
          'Todo List App', 
          style: TextStyle(fontWeight: FontWeight.bold), 
        ), 
        centerTitle: true, 
        backgroundColor: Colors.deepPurple, 
        foregroundColor: Colors.white, 
        actions: [ 
          IconButton( 
            icon: const Icon(Icons.logout), 
            tooltip: 'Logout', 
            onPressed: _logout, 
          ), 
        ], 
      ), 
      body: Container( 
        padding: const EdgeInsets.all(16), 
        child: ValueListenableBuilder( 
          valueListenable: 
Hive.box<Todo>('todos').listenable(), 
          builder: (context, box, child) { 
            return ListView.builder( 
              itemCount: box.length, 
              itemBuilder: (context, index) { 
                final todo = box.getAt(index); 
                if (todo == null) return const 
SizedBox.shrink(); 
                return Card( 
                  color: Colors.white, 
                  shadowColor: Colors.black, 
                  elevation: 4, 
                  child: Container( 
                    padding: const EdgeInsets.all(16), 
                    child: Row( 
                      mainAxisAlignment: 
MainAxisAlignment.spaceBetween, 
                      children: [ 
                        Column( 
                          crossAxisAlignment: 
CrossAxisAlignment.start, 
                          children: [ 
                            Text( 
                              todo.title, 
                              style: TextStyle(fontWeight: 
FontWeight.bold), 
                            ), 
                            Text( 
                              todo.subtitle, 
                              style: TextStyle(color: 
Colors.grey[600]), 
                            ), 
                          ], 
                        ), 
                        Row( 
                          children: [ 
                            IconButton( 
                              icon: Icon(Icons.edit, color: 
Colors.blue), 
                              onPressed: () { 
                                Navigator.push( 
                                  context, 
                                  MaterialPageRoute( 
                                    builder: (context) => 
AddTodoScreen( 
                                      index: index, 
                                      todo: todo, 
                                    ), 
                                  ), 
                                ); 
                              }, 
                            ), 
                            IconButton( 
                              icon: Icon(Icons.delete, color: 
Colors.red), 
                              onPressed: () { 
                                box.deleteAt(index); 
                              }, 
                            ), 
                          ], 
                        ), 
                      ], 
                    ), 
                  ), 
                ); 
              }, 
            ); 
          }, 
        ), 
      ), 
      floatingActionButton: FloatingActionButton( 
        onPressed: () { 
          Navigator.push( 
            context, 
            MaterialPageRoute(builder: (context) => 
AddTodoScreen()), 
          ); 
        }, 
        child: Icon(Icons.add), 
      ), 
    ); 
  }
```

Perhatikan kode yang diberikan tanda tebal di atas, ada hal yang menarik 
bukan? 
yap 
betul, 
yaitu 
penggunaan 
widget **ValueListenableBuilder,** yang bertanggung jawab dalam mengupdate build sesuai operasi yang kita lakukan.

**ValueListenableBuilder** mudahnya adalah pengganti setState() yang kita gunakan untuk memperbarui state pada layar kita, alih-alih menggunakan setState() untuk membuild satu halaman penuh, **ValueListenableBuilder** cukup pintar untuk secara spesifik membuild ulang bagian yang memang mengalami perubahan berdasarkan sifat **listener**-nya yang ia miliki.

Perhatikan berikut, kodingan di atas atribut **valuelistenable**-nya merujuk kepada **Hive Box** yang telah kita buka sebelumnya, sehingga apapun 
perubahan 
yang 
terjadi 
pada 
Box 
tersebut **ValueListenableBuilder** 
dapat 
mengetahuinya 
dan 
membuat perubahan UI yang spesifik berdadasarkannya.

Selain itu ada hal lain yang perlu kita perhatikan, yaitu variabel **todo**, masih ingat bagaimana caranya Hive mengambil data? ya betul, menggunakan **'box.getAt(....)'** pada kasus kita parameternya berisi **'index'** hal ini akan menjadi nilai yang penting yang nantinya akan berguna sebagai acuan dalam proses **Edit** maupun **Delete.**

16. Setelah kita membuat tampilannya, sekarang kita membuat beberapa function yang berada pada halaman ini untuk membantunya beroperasi.

a. void **_logout()** Seperti yang sudah dijelaskan pada penjelasan **langkah ke-11** pada kelas **HomeScreen** akan memuat fungsi logout yang akan merubah nilai Shared Preferences yang sebelumnya ada agar sesuai dengan prinsip authentication.

##### Contoh program 6.18 Membuat fungsi _logout()

```dart
void _logout() async { 
    final prefs = await 
SharedPreferences.getInstance(); 
    await prefs.setBool('loginData', false); 
    if (mounted) { 
      Navigator.pushAndRemoveUntil( 
        context, 
        MaterialPageRoute(builder: (context) => const 
LoginScreen()), 
        (route) => false, 
      ); 
    } 
  }
```

Selesai sudah kita dalam membuat halaman **home_screen.dart** sehingga hasil kodenya sebagai berikut.

##### Contoh program 6.19 Kodingan lengkap home_screen.dart

```dart
import 'package:flutter/material.dart'; 
import 
'package:shared_preferences/shared_preferences.dart'; 
import '../screens/login_screen.dart'; 
//import bawah sini untuk Hive db 
import '../models/todo.dart'; 
import '../screens/add_todo_screen.dart'; 
import 'package:hive_flutter/hive_flutter.dart'; 
 
class HomeScreen extends StatefulWidget { 
  const HomeScreen({super.key}); 
 
  @override 
  State<HomeScreen> createState() => 
_HomeScreenState(); 
} 
 
class _HomeScreenState extends State<HomeScreen> { 
  void _logout() async { 
    final prefs = await 
SharedPreferences.getInstance(); 
    await prefs.setBool('loginData', false); 
    if (mounted) { 
      Navigator.pushAndRemoveUntil( 
        context, 
        MaterialPageRoute(builder: (context) => const 
LoginScreen()), 
        (route) => false, 
      ); 
    } 
  } 
 
  @override 
  void dispose() { 
    super.dispose(); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
   //sisa kodingan build-UI (sama seperti di atas kok)  
   ) 
  } 
}
```

Berikut 
adalah 
tampilan 
dari 
**home_screen.dart.** 
Untuk AddTodoScreen akan masih error karena belum ada. Untuk bisa nge-running seperti ini, Navigation yang mengarah ke AddTodoScreen bisa di-comment terlebih dahulu.


![Gambar 6.4 Tampilan home_screen.dart secara lengkap](images/modul_6/img_p19_1_60.png)
*Gambar 6.4 Tampilan home_screen.dart secara lengkap*

17. Sekarang kita akan membuat halaman terakhir yaitu **add_todo_screen.dart** dengan Class **AddTodoScreen** yang merupakan **StatefulWidget**. Kita akan membuat halaman yang sederhana saja, yang penting bisa mengakomodir kebutuhan CRUD kita.

18. Import packages di file **add_todo_screen.dart** yang akan digunakan

##### Contoh program 6.20 Import pada  add_todo_screen.dart

```dart
import 'package:flutter/material.dart'; 
import 'package:hive/hive.dart'; 
import '../models/todo.dart';
```

19. Buat class Stateful Widget bernama AddTodoScreen

##### Contoh program 6.21 Membuat class AddTodoScreen(StatefulWidget)

```dart
class AddTodoScreen extends StatefulWidget { 
  const AddTodoScreen({super.key}); 
 
  @override 
  State<AddTodoScreen> createState() => 
_AddTodoScreenState(); 
} 
 
class _AddTodoScreenState extends State<AddTodoScreen> { 
  @override 
  Widget build(BuildContext context) { 
    return const Placeholder(); 
  } 
}
```

20. Seperti sebelumnya kita akan membuat UI-nya terlebih dahulu

##### Contoh program 6.22 Membuat UI pada add_todo_screen.dart

```dart
@override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text( 
          _isEditMode ? 'Edit Todo' : 'Add Todo', 
          style: const TextStyle(fontWeight: 
FontWeight.bold), 
        ), 
        centerTitle: true, 
        backgroundColor: Colors.deepPurple, 
        foregroundColor: Colors.white, 
      ), 
      body: Container( 
        padding: const EdgeInsets.all(16), 
        child: Column( 
          children: [ 
            TextField( 
              controller: titleController, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(), 
                labelText: 'Title', 
              ), 
            ), 
            const SizedBox(height: 16), 
            TextField( 
              controller: subtitleController, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(), 
                labelText: 'Subtitle', 
              ), 
            ), 
            const SizedBox(height: 10), 
            ElevatedButton( 
              onPressed: () async { 
                final box = Hive.box<Todo>('todos'); 
                final newTodo = Todo( 
                  title: titleController.text, 
                  subtitle: subtitleController.text, 
                ); 
                if (_isEditMode) { 
                  box.putAt(widget.index!, newTodo); 
                } else { 
                  box.add(newTodo); 
                } 
                if (context.mounted) Navigator.pop(context); 
              }, 
              child: Text(_isEditMode ? 'Save' : 'Add'), 
            ), 
          ], 
        ), 
      ), 
    ); 
  }
```

Sangat sederhana sekali bukan? hanya ada dua textfield yang berisi Title 
dan 
juga 
Subtitle. 
Berikut 
adalah 
tampilan 
dari **add_todo_screen.dart**


![Gambar 6.5 Tampilan add_todo_screen.dart secara lengkap](images/modul_6/img_p22_1_67.png)
*Gambar 6.5 Tampilan add_todo_screen.dart secara lengkap*

21. Karena kita baru saja membuat UI-nya pasti masih terdapat error, oleh karena itu mari kita lengkapi kodingan UI-nya dengan **menambahkan fungsi** dan juga **beberapa variabel** lain yang akan membantu operasional pada halaman **add_todo_screen.dart** ini.

a. Menambahkan variabel Masih ingat dengan variabel **todo** dari **home_screen.dart** ? nah, pada halaman ini kita akan menyimpannya untuk digunakan dalam fungsi edit.

Selain itu, kita juga akan membuat variabel sederhana bernama **_isEditMode,** variabel ini akan menentukan apakah screen kita nanti akan berguna untuk **mengedit tugas** atau **menambah tugas** baru

##### Contoh program 6.23 Menambah variabel penting

```dart
class AddTodoScreen extends StatefulWidget { 
  final int? index; //tambahkan ini 
  final Todo? todo; //tambahkan ini 
 
  const AddTodoScreen({super.key, this.index, 
this.todo}); 
 
  @override 
  State<AddTodoScreen> createState() => 
_AddTodoScreenState(); 
} 
 
class _AddTodoScreenState extends State<AddTodoScreen> 
{ 
//tambahkan 3 variabel dibawah ini 
  final titleController = TextEditingController(); 
  final subtitleController = TextEditingController(); 
  late bool _isEditMode; 
 
// kode sisanya 
}
```

b. Menambahkan void dispose() & initState()

##### Contoh program 6.24 Menambahkan fungsi dispose & initState

```dart
@override 
  void initState() { 
    _isEditMode = widget.index != null && widget.todo 
!= null; 
 
    super.initState(); 
    if (_isEditMode) { 
      titleController.text = widget.todo!.title; 
      subtitleController.text = widget.todo!.subtitle; 
    } 
  } 
 
  @override 
  void dispose() { 
    titleController.dispose(); 
    subtitleController.dispose(); 
    super.dispose(); 
  }
```

Terdapat hal yang menarik pada kode di atas, yaitu adalah penjelasan mengenai variabel **_isEditMode** penting bagi kita untuk menuliskan kodingan ini di dalam **initState()**. Hal ini dikarenakan kita menggunakan halaman yang sama untuk **edit** maupun **tambah** To-do.

Pada dasarnya **initState()** akan dijalankan di awal setiap halaman di build dan karena kita menuliskan baris kode **_isEditMode** di dalamnya, variabel ini akan dijalankan dan menentukan apakah akan masuk ke dalam mode edit/ tambah To-do. Adapun cara yang lebih sederhana namun lebih *advanced* adalah dengan menggunakan *getter* 
mengganti 
kodingan 
sebelumnya 
dengan 
`bool` 
`get`

```dart
_isEditMode => widget.index != null && widget.todo 
!= null;
```

Sudah selesai! kita telah berhasil membuat satu aplikasi To-do list sederhana yang berfungsi dengan menerapkan Shared Preferences dalam authentication dan Hive database untuk menyimpan data list To-do yang harus diselesaikan.

Untuk melihat project full dari langkah praktikum modul 6 ini, dapat diakses melalui repository berikut: https://github.com/AndiZirahitaf/modul_6_prak_mobile.

## V. Tugas Praktikum

### A. Buatlah sebuah fitur keranjang belanja dengan memanfaatkan materi yang telah

diajarkan pada modul ini!
