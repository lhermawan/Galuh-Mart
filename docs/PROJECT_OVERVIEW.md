# GaluhMart / UMKM Kota Galuh

GaluhMart adalah prototype aplikasi marketplace komunitas untuk membantu warga Perum Kota Galuh menjual dan membeli produk UMKM lokal.

## Cakupan MVP Flutter

- Customer app: splash, autentikasi, katalog, detail produk, keranjang, checkout, riwayat order, profil, dan notifikasi.
- Seller panel: dashboard toko, tambah/edit produk, daftar order, laporan penjualan, chat customer, dan profil toko.
- Admin dashboard web-style: statistik, data user/seller, approval seller, produk, transaksi, kategori, dan pengumuman.
- Arsitektur awal: pemisahan `core`, `data`, dan `presentation` dengan repository pattern sederhana berbasis data mock.

## Teknologi yang disiapkan

- Flutter mobile-first, siap dikembangkan untuk Android dan iOS.
- REST API Laravel dan MySQL sebagai target backend.
- Firebase Cloud Messaging untuk notifikasi.
- Midtrans, QRIS, transfer bank, dan COD sebagai opsi pembayaran.

## Menjalankan

```bash
flutter pub get
flutter run
```

> Catatan: repository ini berisi implementasi Flutter prototype. Integrasi API Laravel, OTP WhatsApp, Midtrans, dan FCM perlu ditambahkan pada tahap berikutnya.
