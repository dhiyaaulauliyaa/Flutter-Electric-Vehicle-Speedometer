# Flutter Electric Vehicle Speedometer
## _Speedometer untuk proyek Molina UI. Dikembangkan menggunakan Flutter & Python._

Full paper: [https://ieeexplore.ieee.org/document/9042456]

### Cara debugging aplikasi dashboard single display (aplikasi skipsi 3_2 → dengan koneksi websocket)
1.	Download & install flutter sdk (https://flutter.dev/docs/get-started/install)
2.	Clone repo ini, lalu buka folder `[Aplikasi Dashboard (Dengan Koneksi Server)/skripsi_3_2]`
3.	Buka command prompt pada directory aplikasi
4.	Pada command prompt di directory aplikasi, run command 
```sh
flutter run 
``` 

### Cara memakai aplikasi dashboard dengan koneksi server [Aplikasi Dashboard (Dengan Koneksi Server)/skripsi_3_2]
1.	Hidupkan ECU/Modul ELM327 terlebih dahulu. Apabila sudah hidup, maka nyalakan raspberry.
2.	Program server akan otomatis running.
3.	Pastikan IP pada kodingan `/home/pi/Documents/Skripsi/3/main_server.py` sama dengan IP raspberry
4.	Buka aplikasi `skripsi_3_2` pada android. 
5.	Pada aplikasi, masukkan host address sesuai dengan IP raspberry dan port number sesuai dengan yang sudah di set pada kodingan `/home/pi/Documents/Skripsi/3/main_server.py`
6.	Tekan button “+”, maka websocket address akan berubah. Apabila websocket address sudah sesuai, maka tekan button play. Aplikasi akan menampilkan dashboard speedometer.
7.	Tambahan: apabila terjadi error, matikan program `main_server.py` terlebih dahulu menggunakan command “kill” pada terminal. Setelah program mati, jalankan kembali program `main_server.py` dengan command 
```sh
python main_server.py
```
8.	Apabila program di matikan, data log akan otomatis terbuat dengan format excel. Biasanya tersimpan pada direktori home.

> PENTING! Pastikan layar hp memiliki aspect ratio 16:9. Jika rasio nya berbeda, maka tampilan akan kacau. Hal ini dikarenakan aplikasi belum dibuat responsive.

### Cara memakai aplikasi dashboard multi display [Aplikasi Dashboard (User Interface Saja)]
1.	Clone repo ini, lalu buka folder `[Aplikasi Dashboard (User Interface Saja)/skripsi_2_1]`
2.	Run/debug aplikasi (bisa menggunakan simulator maupun real smartphone) dengan command flutter run pada direktori folder. Pastikan layar hp memiliki aspect ratio 16:9. Jika rasio nya berbeda, maka tampilan akan kacau. Hal ini dikarenakan aplikasi belum dibuat responsive.
3.	Aplikasi akan masuk ke halaman utama. Untuk mengubah tampilan/parameter bisa menggunakan slider yang ada pada bagian bawah.
4.	Aplikasi ini digunakan untuk mendebug/menguji user interface saja, belum memiliki fungsionalitas koneksi dengan modul ECU. apabila ingin menguji koneksi dengan modul ECU, bisa menggunakan aplikasi yang satunya lagi.
	
### Tambahan:
-	File kodingan pada folder autorun script digunakan untuk memutar program main_server.py secara otomatis pada raspberry dan mengkoneksikan modul ECU ke Raspi melalui bluetooth secara otomatis.
