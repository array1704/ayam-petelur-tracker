# 🐔 Ayam Petelur Tracker - Aplikasi Pencatatan Produktivitas Ayam Petelur

Aplikasi Android profesional untuk memantau dan mencatat produktivitas ayam petelur rumahan dengan fitur lengkap tracking produksi, kesehatan, pakan, dan laporan analitik.

## 📱 Fitur Utama

### 1. **Manajemen Data Ayam**
- ✅ Pencatatan identitas ayam (nama, ID unik)
- ✅ Tracking berat badan awal dan update periodik
- ✅ Pencatatan umur ayam dalam hitungan minggu
- ✅ Status kesehatan (sehat/sakit)
- ✅ Riwayat kesehatan dan penyakit

### 2. **Produksi Telur**
- ✅ Pencatatan produksi telur harian per ayam
- ✅ Tracking kualitas telur (normal, retak, kecil)
- ✅ Laporan akumulasi telur per bulan
- ✅ Statistik produktivitas individual

### 3. **Kesehatan Ayam**
- ✅ Status kondisi ayam (Sehat/Sakit)
- ✅ Pencatatan jenis penyakit
- ✅ Riwayat pemberian obat
- ✅ Riwayat pemberian vaksin
- ✅ Log kondisi harian saat ayam sakit
- ✅ Timeline pemulihan

### 4. **Manajemen Pakan**
- ✅ Pencatatan pembelian pakan (kg)
- ✅ Tracking harga per kg
- ✅ Monitoring stok pakan
- ✅ Laporan pengeluaran pakan
- ✅ Estimasi durasi pakan

### 5. **Laporan & Analitik**
- ✅ **Tabel Laporan**: Data harian per ayam dengan detail produksi
- ✅ **Line Chart**: Grafik produksi telur harian
- ✅ **Bar Chart**: Perbandingan produksi per ayam bulanan
- ✅ **Pie Chart**: Persentase produktivitas masing-masing ayam
- ✅ **Export PDF**: Laporan bulanan dalam format PDF
- ✅ **Dashboard**: Ringkasan KPI utama

## 🛠️ Tech Stack

| Layer | Technology | Alasan |
|-------|-----------|--------|
| **Frontend** | Flutter | Cross-platform, performa tinggi, UI modern |
| **Language** | Dart | Strongly-typed, null-safety, modern syntax |
| **Backend/Database** | Firebase Firestore | Real-time sync, scalable, NoSQL |
| **Authentication** | Firebase Auth | Secure, user-friendly, terintegrasi |
| **Local Storage** | Hive | Fast, encrypted, offline-first |
| **State Management** | Riverpod | Modern, testable, reactive |
| **UI Components** | Flutter Material Design | Native look & feel |
| **Charts** | fl_chart | Comprehensive, customizable |
| **PDF Export** | pdf + printing | Export & print support |

## 📁 Struktur Folder

```
ayam-petelur-tracker/
├── lib/
│   ├── main.dart                    # Entry point aplikasi
│   ├── config/
│   │   ├── firebase_config.dart
│   │   ├── theme_config.dart
│   │   └── routes_config.dart
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── ayam/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── produksi/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── kesehatan/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── pakan/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   └── laporan/
│   │       ├── data/
│   │       ├── domain/
│   │       └── presentation/
│   ├── shared/
│   │   ├── models/
│   │   ├── widgets/
│   │   ├── utils/
│   │   └── constants/
│   └── services/
│       ├── firebase_service.dart
│       ├── notification_service.dart
│       └── export_service.dart
├── pubspec.yaml                     # Dependencies
├── android/
├── ios/
└── test/
```

## 🚀 Cara Memulai

### Prerequisites
- Flutter SDK >= 3.10
- Dart >= 3.0
- Android Studio / Xcode (untuk emulator)
- Firebase Console account

### Setup Lokal

```bash
# 1. Clone repository
git clone https://github.com/array1704/ayam-petelur-tracker.git
cd ayam-petelur-tracker

# 2. Install dependencies
flutter pub get

# 3. Setup Firebase
# - Buat project baru di Firebase Console
# - Download google-services.json untuk Android
# - Letakkan di android/app/

# 4. Run aplikasi
flutter run
```

### Setup Firebase

1. Pergi ke [Firebase Console](https://console.firebase.google.com)
2. Buat project baru: "Ayam Petelur Tracker"
3. Tambahkan Android app
4. Download `google-services.json` dan letakkan di `android/app/`
5. Enable Firestore Database (Start in production mode)
6. Enable Firebase Authentication (Email/Password, Google, Phone)

## 📊 Model Data Firebase

### Collections Structure

```
users/
├── {userId}/
│   ├── name
│   ├── email
│   ├── createdAt
│   └── updatedAt

ayam/
├── {userId}/
│   ├── {ayamId}/
│   │   ├── nama
│   │   ├── nomorIdentifikasi
│   │   ├── beratBadanAwal
│   │   ├── umurMinggu
│   │   ├── tanggalMulai
│   │   ├── status (aktif/tidak aktif)
│   │   ├── riwayatBeratBadan[]
│   │   ├── createdAt
│   │   └── updatedAt

produksi_telur/
├── {userId}/
│   ├── {produksiId}/
│   │   ├── ayamId
│   │   ├── tanggal
│   │   ├── jumlahTelur
│   │   ├── kualitas (normal/retak/kecil)
│   │   ├── catatan
│   │   └── timestamp

kesehatan_ayam/
├── {userId}/
│   ├── {kesehatanId}/
│   │   ├── ayamId
│   │   ├── status (sehat/sakit)
│   │   ├── jenisPenyakit
│   │   ├── tanggalMulai
│   │   ├── riwayatObat[]
│   │   ├── riwayatVaksin[]
│   │   ├── logHarian[]
│   │   └── tanggalSembuh

pakan/
├── {userId}/
│   ├── {pakanId}/
│   │   ├── tanggalPembelian
│   │   ├── jumlahKg
│   │   ├── hargaPerKg
│   │   ├── totalHarga
│   │   ├── jenisPakan
│   │   ├── supplier
│   │   └── catatan
```

## 📈 Fitur Laporan

### 1. Dashboard
- Total ayam aktif
- Produksi hari ini
- Ayam sakit
- Stok pakan

### 2. Laporan Tabel
- Tabel harian per ayam
- Detail: Nama, Umur, Berat, Produksi, Status Kesehatan
- Filter by tanggal, status, ayam

### 3. Grafik & Visualisasi
- **Line Chart**: Trend produksi telur (7 hari terakhir)
- **Bar Chart**: Produktivitas per ayam (bulan ini)
- **Pie Chart**: Persentase kontribusi setiap ayam
- **Area Chart**: Tren kesehatan ayam

### 4. Export
- Export PDF laporan bulanan
- Share via WhatsApp, Email
- Print langsung

## 🔐 Keamanan

- ✅ Firebase Authentication (Email verification)
- ✅ Firestore Security Rules (User-based access control)
- ✅ Data encryption at rest
- ✅ Offline-first dengan Hive
- ✅ Input validation & sanitization

## 📱 Platform Support

- ✅ Android 5.0+ (API 21+)
- ✅ iOS 11.0+ (Coming soon)
- ✅ Responsive design untuk berbagai ukuran layar

## 🧪 Testing

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/
```

## 📝 Roadmap

- [x] Setup project structure
- [x] Firebase integration
- [x] Authentication system
- [ ] Manajemen ayam CRUD
- [ ] Pencatatan produksi telur
- [ ] Tracking kesehatan ayam
- [ ] Manajemen pakan
- [ ] Dashboard & analytics
- [ ] Export PDF
- [ ] Push notifications
- [ ] Cloud backup

## 🤝 Kontribusi

Pull requests dipersilakan! Untuk perubahan besar, buka issue terlebih dahulu untuk diskusi.

## 📄 License

MIT License - Lihat file LICENSE untuk detail

## 👨‍💻 Author

**array1704**
- GitHub: [@array1704](https://github.com/array1704)

## 📞 Support

Jika ada pertanyaan atau bug, silakan buka [GitHub Issues](https://github.com/array1704/ayam-petelur-tracker/issues)

---

**Made with ❤️ for chicken farmers** 🐔
