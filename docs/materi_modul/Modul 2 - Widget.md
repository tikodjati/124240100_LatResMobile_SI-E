# Modul 2: WIDGET

## I. Tujuan Praktikum

- Memperkenalkan *widget* dan bagaimana perannya pada Flutter.
- Mengetahui jenis-jenis *widget.*
- Dapat membuat *layout* menggunakan *widget*.
## II. Alokasi Waktu : 1 x Pertemuan = 120 Menit

## III. Dasar Teori

Pada Flutter, *user interface* (UI) disusun menggunakan ***widget***. Elemen-elemen yang tampil di layar seperti gambar, ikon, dan teks adalah widget. Bahkan seluruh halaman aplikasi juga adalah widget. Oleh karena itu, penting untuk dipahami bahwa konsep dasar dalam *layouting* di Flutter adalah "***everything is widget***".

Masih ingat di modul sebelumnya kita membahas bahwa Flutter mengadopsi paradigma OOP, dimana elemen-elemen pada program dikelompokkan sebagai objek? Nah, widget adalah implementasi dari objek tersebut. Setiap widget dibuat sebagai class yang memiliki **atribut dan** ***behavior***. Atribut atau *properties* ini **menentukan karakteristik widget** seperti warna, ukuran, atau teks yang ditampilkan. Misalnya, ketika kamu membuat widget `Text`, kamu bisa mengatur `fontSize` menjadi 20 dan `color` menjadi biru.

Yang membuat Flutter *powerful* adalah kemampuan widget untuk mengandung widget lain. Hampir semua atribut dari widget di Flutter diisi oleh widget, sehingga membentuk struktur *nested* yang disebut **widget tree.** Contoh, widget `Container` bisa diisi dengan `Column`, yang kemudian memiliki `Text`**,** `Image`**,** dan `Button` di dalamnya. Hierarki widget demi widget inilah yang kemudian membentuk seluruh tampilan aplikasi. Semakin kamu memahami konsep *widget tree* ini, semakin mudah kamu membangun UI yang kompleks dengan cara yang terstruktur dan mudah dipahami.

Pada Flutter, widget bersifat modular dan reusable, memastikan tampilan konsisten di berbagai platform (Android, iOS, Web, Desktop) berkat kapabilitas cross-platform-nya.

Agar mudah dalam mengenal widget-widget pada flutter, widget dikelompokkan ke dalam beberapa kelompok yaitu;

### A. Foundation Widgets

Adalah widget-widget yang berperan sebagai fondasi dasar dari sebuah aplikasi.

#### 1. Material App

Dalam pembuatan sebuah aplikasi dengan menggunakan Flutter, dibutuhkan suatu widget yang digunakan untuk mengatur segala route dan theme, atau biasa disebut dengan **top level**. Hal ini dapat menggunakan suatu widget bernama dengan **MaterialApp**. Dengan MaterialApp, kita diberikan beberapa 
kemudahan 
antara 
lain 
suatu 
Material 
Theme yang telah diperkenalkan di android dan sekarang menjadi tampilan baku di android.

Dengan implementasi tampilan dari Material Theme ini, maka tampilan di Scaffold, AppBar, ListView dan widget yang lain akan mendapatkan tampilan dari Material Theme.

##### Contoh Program 2.1 MaterialApp Widget

```dart
import 'package:flutter/material.dart'; 
 
void main() { runApp(const MyApp()); } 
class MyApp extends StatelessWidget { 
  const MyApp({Key? key}) : super(key: key); 
 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp(); 
  } 
}
```

#### 2. Home dan Scaffold

Home merupakan sebuah **properti** dari MaterialApp yang digunakan untuk menempatkan widget di saat aplikasi pertama kali termuat. Sedangkan Scaffold bisa dibilang adalah **kerangka / fondasi awal** dari widget-widget lainnya untuk membentuk tampilan aplikasi. Properti yang paling sering digunakan pada Scaffold adalah **appBar** dan **body**, yang akan kita bahas selanjutnya.

##### Contoh Program 2.2 Home dan Scaffold

```dart
import 'package:flutter/material.dart'; 
 
void main() { runApp(const MyApp()); } 
class MyApp extends StatelessWidget { 
  const MyApp({Key? key}) : super(key: key); 
 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      home: Scaffold(), 
    ); 
  } 
}
```

#### 3. AppBar

AppBar merupakan salah satu bagian yang umumnya digunakan pada sebuah aplikasi sebagai menu petunjuk untuk memudahkan pengguna aplikasi.

Widget ini terletak pada posisi bagian paling atas aplikasi. AppBar biasanya menyediakan tampilan seperti daftar menu, judul aplikasi ataupun tombol-tombol aksi.

Umumnya sebuah dalam sebuah basic Appbar widget tersusun dari tiga element utama yaitu Leading, Title dan Actions.


![Gambar 2.1 Struktur Appbar](images/modul_2/img_p3_1_21.png)
*Gambar 2.1 Struktur Appbar*

##### Contoh Program 2.3 Appbar widget

```dart
return Scaffold( 
  appBar: AppBar( 
    leading: Icon(Icons.home), 
    title: Text('Praktikum TPM'), 
    actions: <Widget>[ 
      IconButton(icon: new Icon(Icons.call, color: 
Colors.white)), 
      IconButton(icon: new Icon(Icons.search, color: 
Colors.white)), 
    ], 
  ), 
);
```

#### 4. Body

Merupakan salah satu property dari Scaffold, body berperan sebagai wadah bagi sebagian besar widget yang nantinya akan menjadi antarmuka aplikasi. Sebagai contoh, disini pada body kita masukkan widget bernama **Column**.

##### Contoh Program 2.4 Body

```dart
return Scaffold( 
  appBar: AppBar( 
    title: Text('This is Title'), 
  ), 
  body: Center( 
    child: Column(), 
  ), 
);
```

Mari kita perhatikan tampilan layar yang sederhana di bawah ini. Terlihat tampak sederhana akan tetapi ternyata tersusun dari berbagai widget-widget yang berbeda. Seperti sebelumnya, widget **Scaffold** menjadi penopang yang memiliki 3 'anak' di bawahnya yaitu AppBar, Center, FloatingActionButton. Nah sementara di bawahnya lagi merupakan widget yang 'mendetailkan' tampilan ini.


![Gambar 2.2 Widget Tree](images/modul_2/img_p4_1_24.png)
*Gambar 2.2 Widget Tree*

### B. Layout Widgets

Kita sudah tahu bahwa gambar, ikon, dan teks yang kita lihat di aplikasi Flutter semuanya adalah widget. Tetapi hal-hal yang **tidak kita lihat juga merupakan** **widget,** seperti baris, kolom, dan kisi yang **mengatur, membatasi, dan** **menyelaraskan widget yang terlihat.** Kita membuat *layout* dengan menyusun *widget* untuk membuat *widget* yang lebih kompleks. Misalnya, gambar di bawah ini menunjukkan 3 ikon dengan label di bawahnya masing-masing:


![Gambar 2.3 Contoh layout](images/modul_2/img_p5_1_28.png)
*Gambar 2.3 Contoh layout*

Untuk dapat melihat detail dari *layout* diatas, kita dapat melihatnya pada gambar diagram dibawah ini,


![Gambar 2.4 Diagram layout](images/modul_2/img_p5_2_29.png)
*Gambar 2.4 Diagram layout*

Jadi 
mengapa 
bisa 
ada 
3 
icon 
yang 
berbaris 
sejajar, 
dan 
di masing-masingnya terdapat teks yang ter-*align* secara *center* di bawahnya, itu semua berkat **layout widgets**.

**Layout Widget** bisa kita kelompokkan berdasarkan perannya. Jika berperan mengatur hanya **satu** widget, termasuk **Single Child Layout** widget. Jika berperan **lebih dari 1** widget, disebut **Multi Child Layout** widget

#### 1. Single Child Layout

- **a)** Container
Container digunakan ketika sebuah widget perlu diberi penyesuaian tambahan, seperti padding, background color, ataupun border. Hal ini karena widget tersebut mungkin **tidak memiliki atribut** untuk menyesuaikannya secara langsung. Untuk menggunakan container, kita cukup membungkus widget yang ingin disesuaikan kedalam properti `child` milik `Container`.

##### Contoh Program 2.5 Container

```dart
Container ( 
   child: Text("Ini di dalam kontainer",), 
   padding: EdgeInsets.all(50.0), 
   color: Colors.blue, 
  );
```


![Gambar 2.5 Container](images/modul_2/img_p6_1_33.png)
*Gambar 2.5 Container*

- **b)** SizedBox
SizedBox adalah widget dengan ukuran tetap yang digunakan untuk memberikan batasan **dimensi** (lebar dan tinggi) yang spesifik pada anaknya, atau sering kali digunakan tanpa anak sebagai **penyekat kosong** (spacer) untuk memberikan **jarak antar widget.** Umumnya sering dipakai untuk spacing karena sederhana dan mencegah *rebuild* widget yang tidak perlu.

##### Contoh Program 2.6 SizedBox

```dart
Text("Ini di atas Sized Box"), 
SizedBox( 
  height: 50, 
  width: 50, 
 ), 
Text("Ini dibawah Sized Box")
```


![Gambar 2.6 SizedBox](images/modul_2/img_p6_2_34.png)
*Gambar 2.6 SizedBox*

- **c)** Center / Align
Center dan Align adalah widget pemosisian yang berfungsi untuk mengatur letak child di dalam ruang yang tersedia berdasarkan titik koordinat tertentu. Widget Center sebenarnya merupakan varian khusus dari Align yang secara otomatis menempatkan anaknya tepat di tengah-tengah ruang induknya.

##### Contoh Program 2.7 Center

```dart
Center( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[ 
            const Text( 
              'You have pushed the button this many times:', 
            ), 
            Text( 
              '$_counter', 
              style: 
Theme.of(context).textTheme.headlineMedium, 
            ), 
         ), 
      );
```

#### 2. Multi Child Layout

Pada Single-Child Layout widget, terdapat properti **child** karena hanya dapat memuat satu widget. Sedangkan pada Multi-Child Layout widget, properti yang digunakan adalah **children**, karena berfungsi sebagai **wadah untuk banyak** **widget sekaligus**. Properti children sendiri berupa **list/array**, sehingga memungkinkan beberapa widget dimasukkan ke dalamnya secara bersamaan.

- **a)** Column
Seperti namanya widget ini elemen-elemen yang ada di dalam *children* yang ada di dalamnya dalam sebuah layout kolom (bersifat y-axis).

Oleh 
karena 
itu, 
seringkali 
penggunaannya 
dipadukan 
dengan ***mainAxisAlignment*** dan ***crossAxisAlignment***. Pada column main axis berjalan secara vertikal dan cross axis berjalan secara horizontal.

##### Contoh Program 2.8 Column

```dart
Column( 
  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
  children: [ 
    Image.asset('images/pic1.jpg'), 
    Image.asset('images/pic2.jpg'), 
    Image.asset('images/pic3.jpg'), 
  ], 
);
```


![Ilustrasi](images/modul_2/img_p8_1_39.png)


![Gambar 2.7 Aligning Widget pada Column](images/modul_2/img_p8_2_40.png)
*Gambar 2.7 Aligning Widget pada Column*

- **b)** Row
Seperti namanya widget ini akan mengatur *children* yang ada di dalamnya dalam sebuah layout baris. Oleh karena itu, seringkali penggunaannya 
dipadukan 
dengan 
***mainAxisAlignment*** 
dan ***crossAxisAlignment***. Pada column main axis berjalan secara horizontal dan cross axis berjalan secara vertikal.

##### Contoh Program 2.9 Row

```dart
Row( 
  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
  children: [ 
    Image.asset('images/pic1.jpg'), 
    Image.asset('images/pic2.jpg'), 
    Image.asset('images/pic3.jpg'), 
  ], 
);
```


![Ilustrasi](images/modul_2/img_p8_3_42.png)


![Gambar 2.8 Aligning Widget pada Row](images/modul_2/img_p8_4_44.png)
*Gambar 2.8 Aligning Widget pada Row*

- **c)** Stack
Sesuai dengan artinya stack akan menumpuk, tumpukan tersebut urutan dari lapisan widget pada stack dari bawah ke atas, jadi widget yang pertama di dalam stack akan berada di posisi paling bawah dan begitu juga sebaliknya, widget yang terakhir di stack widget akan berada di posisi

##### Contoh Program 2.10 Stack

```dart
body: Stack( 
  children: <Widget>[ 
    Container( 
      color: Colors.green, 
    ), 
    Container( 
      color: Colors.red, 
      height: 400.0, 
      width: 300.0, 
    ), 
    Container( 
      color: Colors.deepPurple, 
      height: 200.0, 
      width: 200.0, 
    ), 
  ], 
),
```


![Gambar 2.9 Stack](images/modul_2/img_p9_1_47.png)
*Gambar 2.9 Stack*

### C. Basic Widgets

#### 1. Text

Dalam sebuah *user interface*, *text* merupakan salah satu komponen yang sangat penting. Oleh karena itu, kita perlu mengetahui cara membuat *text* pada *layout* Flutter kita.

##### Contoh Program 2.11 Text

```dart
Text('Ini adalah widget Text'),
```

#### 2. Button

Selain text, *button* merupakan salah satu *widget* dasar dari Flutter dan merupakan salah satu komponen penting pada sebuah UI. Flutter sendiri mengenal 3 jenis *button* yang dapat kita gunakan sesuai dengan kepentingan.

Ketiga jenis tersebut meliputi, *Text Button* merupakan salah satu jenis *widget* button dari *Material* *Design* yang tidak memiliki garis (*border*) dan elevasi (*elevation*).

Sehingga *widget* ini hanya berupa text dan bergantung pada posisi dari posisi *widget* lain.

##### Contoh Program 2.12 TextButton

```dart
TextButton( 
  onPressed: (), // Respon ketika button ditekan 
  child: Text("Text Button"), 
)
```


![Gambar 2.10 Text Button](images/modul_2/img_p10_1_50.png)
*Gambar 2.10 Text Button*

2) Outlined Button Sedikit berbeda dengan *Text Button, Outlined Button* memiliki garis atau *border* yang mengelilingi tombol. Jenis tombol ini juga merupakan salah satu jenis *widget* *button* dari *Material Design.* Biasanya jenis tombol ini digunakan untuk aksi penting namun bukan aksi utama.

##### Contoh Program 2.13 OutlinedButton

```dart
OutlinedButton( 
  onPressed: (), // Respon ketika button ditekan 
  child: Text("Outlined Button"), 
)
```


![Gambar 2.11 Outlined Button](images/modul_2/img_p10_2_51.png)
*Gambar 2.11 Outlined Button*

3) Contained Button *Contained* *Button* merupakan salah satu jenis tombol dari Material Design yang memiliki ciri khas elevasi yang meningkat saat ditekan oleh pengguna.

##### Contoh Program 2.14 ElevatedButton

```dart
ElevatedButton( 
  onPressed: (), // Respon ketika button ditekan 
  child: Text("Elevated Button"), 
)
```


![Gambar 2.12 Contained Button](images/modul_2/img_p11_1_55.png)
*Gambar 2.12 Contained Button*

#### 3. Icon

Icon dalam Flutter adalah salah satu widget dasar yang digunakan untuk menampilkan simbol visual guna memperjelas fungsi atau navigasi dalam antarmuka pengguna (UI). ikon berasal dari Font Icon, yang berarti mereka bersifat vektor. Hal ini memungkinkan ikon untuk diperbesar atau diperkecil ke ukuran berapa pun tanpa kehilangan ketajaman (tidak pecah) dan dapat diubah warnanya dengan sangat mudah melalui properti color.

Flutter secara bawaan menyertakan pustaka Icons yang sangat lengkap berdasarkan standar Material Design (Dapat diakses di dokumentasi flutter), sehingga kita dapat langsung icon siap pakai hanya dengan mengetikkan nama ikonnya.

##### Contoh Program 2.15 Icon

```dart
Icon( 
  Icons.favorite, 
  color: Colors.pink, 
  size: 24.0, 
  semanticLabel: 'Text to be read by screen readers', 
)
```

#### 4. Image

Selain text dan button, sebuah aplikasi juga membutuhkan sebuah gambar yang dapat membuat aplikasi kita menjadi lebih menarik. Tidak hanya menampilkan gambar, terkadang kita perlu menyesuaikan bagaimana gambar harus ditampilkan.

Untuk menampilkan sebuah gambar *local*, kita perlu menambahkan gambar tersebut ke dalah *project* kita dan juga mendaftarkan gambar tersebut ataupun lokasi gambar tersebut berada di ***pubspec.yaml***. Sebagai contoh berikut ini,

##### Contoh Program 2.16 pubspec.yaml

```yaml
flutter: 
    assets: 
     # Berikut ketika kita ingin mendaftarkan setiap gambar 
      - assets/images/file-name.jpg 
      - assets/images/file-name-2.jpg 
 
     # Berikut ketika kita ingin mendaftarkan lokasi gambar 
      - assets/images/
```

Indentasi dari penulisan code diatas berpengaruh terhadap proses import assets yang dilakukan, inkonsistensi pada pemberian indent disetiap line menyebabkan error sehingga agar dapat menuliskan indent yang sesuai, gunakan tombol **Tab** pada keyboard anda. Setelah kita mendaftar gambar ataupun lokasi gambar berada, kita dapat dengan mudah memanggil gambar tersebut dengan menggunakan ***Image.asset()***. Apabila ingin menggunakan gambar yang berasal dari internet, kita dapat menggunakan ***Image.network().***

##### Contoh Program 2.17 Local and public Image

```dart
// menampilkan local Image yang sudah didaftarkan 
Image.asset('assets/images/file-name.jpg') 
 
// menampilkan gambar yang berasal dari internet 
Image.network(http://fti.upnyk.ac.id/images/upn.png')
```

#### 5. Text Field

Salah satu *widget* yang tidak kalah penting adalah TextField. *Widget* ini berfungsi untuk menerima masukkan dari pengguna dan biasanya sering digunakan ketika di dalam aplikasi yang dibangun memiliki *form*. TextField pada Flutter memiliki 2 jenis yaitu, 1) TextField TextField adalah widget input teks yang paling umum digunakan.

Secara default, TextField didekorasi dengan garis bawah. Anda dapat menambahkan label, *icon*, *inline hint text,* dan *error text* dengan menyediakan InputDecoration sebagai properti dekorasi TextField.

##### Contoh Program 2.18 TextField

```dart
TextField( 
  decoration: InputDecoration( 
    border: OutlineInputBorder(), 
    hintText: 'Enter a search term', 
  ), 
)
```


![Gambar 2.13 TextField](images/modul_2/img_p12_1_58.png)
*Gambar 2.13 TextField*

2) TextFormField TextFormField membungkus TextField dan mengintegrasikannya dengan Formulir terlampir. Ini menyediakan fungsionalitas tambahan, seperti validasi dan integrasi dengan widget FormField lainnya.

##### Contoh Program 2.19 TextFormField

```dart
TextFormField( 
  decoration: const InputDecoration( 
    icon: Icon(Icons.person), 
    hintText: 'What do people call you?', 
    labelText: 'Name *', 
  ), 
  onSaved: (String? value) { 
  }, 
  validator: (String? value) { 
    return (value != null && value.contains('@')) ? 'Do not use 
the @ char.' : null; 
  }, 
)
```


![Ilustrasi](images/modul_2/img_p13_1_61.png)


![Ilustrasi](images/modul_2/img_p13_2_62.png)


![Gambar 2.14 TextFormField](images/modul_2/img_p13_3_63.png)
*Gambar 2.14 TextFormField*

### D. Scrollable Widgets

#### 1. List View

List merupakan salah satu hal yang mendasar dalam mempelajari layout sebuah aplikasi. Contoh penggunaan list pada aplikasi umumnya dapat kita temukan di daftar kontak atau aplikasi berita. Membuat sebuah List widget yang dapat di scroll pada Flutter cukup mudah dengan menggunakan widget ListView.

Jenis ListView widget dibagi berdasarkan cara penggunaanya. Terdapat tiga cara yang sering digunakan yaitu sebagai berikut:

1) ListView ListView adalah bentuk default dari sebuah ListView class. Dengan ListView maka children atau widget yang ada di dalamnya akan menjadi *scrollable* (dapat di scroll). Penggunaan default ListView ini hanya untuk widget yang bersifat statis. Statis yang dimaksud bukan untuk isi kontennya melainkan lebih kepada jumlah widget di dalamnya.

##### Contoh Program 2.20 ListView

```dart
body: ListView( 
  children: <Widget>[ 
    Container( 
      padding: EdgeInsets.all(15), 
      child: Text('Flutter Widget: Penggunaan ListView Class', 
          style: TextStyle(fontSize: 30, fontWeight: 
FontWeight.bold) 
      ), 
    ), 
    Container( 
      padding: EdgeInsets.all(15), 
      child: Text( 'Lorem Ipsum', 
          style: TextStyle(fontSize: 16) 
      ), 
    ), 
  ] 
),
```


![Gambar 2.15 ListView](images/modul_2/img_p14_1_66.png)
*Gambar 2.15 ListView*

2) ListView.builder Untuk list yang bersifat dinamis (jumlah list item mengikuti dari jumlah data) maka gunakan ListView.builder. ListView.builder memiliki dua properti utama yaitu itemCount (jumlah list item) dan itemBuilder (untuk membangun tampilan dari list item).

##### Contoh Program 2.21 ListView.builder

```dart
body: ListView.builder( 
  itemBuilder: (context, index) { 
    return Card( 
      child: Padding( 
        padding: const EdgeInsets.all(15.0), 
        child: Text('Index $index', style: TextStyle(fontSize: 
30)), 
      ), 
    ); 
  }, 
  itemCount: 12, 
),
```


![Gambar 2.16 ListView.builder](images/modul_2/img_p15_1_69.png)
*Gambar 2.16 ListView.builder*

3) ListTile ListTile merupakan salah satu bentuk list lain yang lebih compact dan sudah terformat sehingga hanya membutuhkan sedikit kode untuk membuat sebuah tampilan yang baik dan lengkap.

##### Contoh Program 2.22 ListTile

```dart
ListTile( 
  leading: CircleAvatar( 
                child: Text("B"), 
              ), 
  title: Text( 
          "Budi Doremi" 
           ), 
  subtitle: Text( 
          "Ini subtitle" 
           ), 
  trailing: Icon(Icons.home), 
       );
```


![Gambar 2.17 ListView.builder](images/modul_2/img_p16_1_72.png)
*Gambar 2.17 ListView.builder*

#### 2. Grid View

Kita tentunya sudah tidak asing dengan tampilan dari feed instagram.

Bentuk tampilan kotak-kotak dan dapat di scroll seperti itu yang dinamakan grid view. Penggunaan GridView di Flutter seperti penggabungan antara penggunaan ListView widget serta penggunaan row dan column widget.

Jenis GridView widget dibagi berdasarkan cara penggunaanya. Terdapat dua cara yang sering digunakan yaitu sebagai berikut:

1) GridView GridView adalah bentuk default dari sebuah GridView class.

Seperti halnya ListView, GridView juga akan membuat children atau widget yang ada di dalamnya menjadi scrollable.

##### Contoh Program 2.23 GridView

```dart
body: GridView( 
  gridDelegate: 
SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
  children: <Widget>[ 
    FlutterLogo(), 
    FlutterLogo(), 
    FlutterLogo(), 
    FlutterLogo(), 
  ], 
),
```

2) GridView.builder Untuk list yang bersifat dinamis (jumlah list item mengikuti dari jumlah data) maka gunakan GridView.builder. GridView.builder memiliki tiga properti utama yaitu itemCount (jumlah list item) dan itemBuilder (untuk membangun tampilan dari list item).

##### Contoh Program 2.24 GridView

```dart
body: GridView.builder( 
  gridDelegate: 
SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
  itemBuilder: (_, index) => FlutterLogo(), 
  itemCount: 4, 
),
```


![Gambar 2.18 GridView dan GridView.builder](images/modul_2/img_p17_1_75.png)
*Gambar 2.18 GridView dan GridView.builder*

#### 3. Single Child Scroll View

*SingleChildScrollView* merupakan *widget* yang dapat menggulir (*scroll*) sebuah widget*.* Ketika ruang aplikasi tidak cukup, widget di dalam dapat menggulir pada poros. Sebagai contoh seperti berikut,

##### Contoh Program 2.25 SingleChildScrollView Bagian 1

```dart
body: Column( 
  mainAxisSize: MainAxisSize.min, 
  mainAxisAlignment: MainAxisAlignment.spaceAround, 
  children: <Widget>[ 
    Container( 
      color: const Color(0xffeeee00), 
      height: 400.0, 
      alignment: Alignment.center, 
      child: const Text('Fixed Height Content'), 
    ), 
    Container( 
      color: const Color(0xff008000), 
      height: 450.0, 
      alignment: Alignment.center, 
      child: const Text('Fixed Height Content'), 
    ), 
  ], 
),
```


![Gambar 2.19 Overflow Column Layout](images/modul_2/img_p18_1_78.png)
*Gambar 2.19 Overflow Column Layout*

Jika melihat gambar diatas, dengan menggunakan Column dan *layout* yang telah dibuat melewati layar aplikasi kita. Maka akan tampil warna kuning dan hitam yang melambangkan bahwa terdapat beberapa bagian dari *layout* yang tidak terlihat (*overflow*). Untuk mengatasi hal tersebut, kita dapat menambahkan sebuah *widget SingleChildScrollView*.

##### Contoh Program 2.26 SingleChildScrollView Bagian 2

```dart
body: SingleChildScrollView( 
  child: Column( 
    mainAxisSize: MainAxisSize.min, 
    mainAxisAlignment: MainAxisAlignment.spaceAround, 
    children: <Widget>[ 
      Container( 
        color: const Color(0xffeeee00), 
        height: 400.0, 
        alignment: Alignment.center, 
        child: const Text('Fixed Height Content'), 
      ), 
      Container( 
        color: const Color(0xff008000), 
        height: 450.0, 
        alignment: Alignment.center, 
        child: const Text('Fixed Height Content'), 
      ), 
    ], 
  ), 
),
```


![Gambar 2.20 SingleChildScrollView](images/modul_2/img_p19_1_81.png)
*Gambar 2.20 SingleChildScrollView*

## IV. Langkah Praktikum

### A. Lakukan semua contoh program sebelumnya dan pastikan bahwa mereka

dikompilasi dan dieksekusi dengan benar.

### B. Diskusikan dengan kelompok belajar Anda untuk modifikasi atau peningkatan dalam

implementasi *widget* pada flutter.

## V. Tugas Praktikum

### A. Buatlah sebuah layout seperti gambar dibawah dengan menerapkan materi yang

sudah diajarkan di atas.


![Gambar 2.21 Tugas](images/modul_2/img_p20_1_84.png)
*Gambar 2.21 Tugas*
