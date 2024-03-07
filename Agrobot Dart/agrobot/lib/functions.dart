import 'dart:io';
import 'package:agrobot/dataHarga.dart';
import 'package:agrobot/dataLahan.dart';

class Agrobot {
  
  void lahan() {
    print("No Lahan: ");
    int noLahan = int.parse(stdin.readLineSync()!);

    print("Luas Lahan: ");
    int luasLahan = int.parse(stdin.readLineSync()!);

    print("Jarak Tanam: ");
    int jarakTanam = int.parse(stdin.readLineSync()!);

    print("Lokasi Lahan : ");
    String lokasi = stdin.readLineSync()!;

    int populasi = luasLahan * jarakTanam;

    for (Map<String, String> data in dataLahan.values) {
      if (noLahan == data['nomor']) {
        print("Data dengan nomor $noLahan sudah ada");
        print("Silahkan masukkan nomor setelahnya..");
        lahan();
      }
    }

    Map<String, String> newLahan = {
      'nomor': noLahan.toString(),
      'luas': luasLahan.toString(),
      'lokasi': lokasi,
      'populasi': populasi.toString(),
    };

    dataLahan[dataLahan.length + 1] = newLahan;
    saveDataLahan(dataLahan);
    print("Berhasil disimpan!");
    back();
  }

  void saveDataLahan(Map<int, Map<String, String>> data) {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln("Map<int, Map<String, String>> dataLahan = {");
    for (int key in data.keys) {
      buffer.writeln("$key: {");
      data[key]!.forEach((innerKey, innerValue) {
        buffer.writeln("'$innerKey': '$innerValue',");
      });
      buffer.writeln("},");
    }
    buffer.writeln("};");

    final File file = File('lib/dataLahan.dart');
    file.writeAsStringSync(buffer.toString());
  }
  

  void back() {
    print("Tekan enter untuk kembali...");
    stdin.readLineSync()!;
    tampilan();
  }

  void clear(){
    for(int i = 0; i < stdout.terminalLines; i++) {
      stdout.writeln();
    }
  }

  void tampilan() {
    clear();
    print("""
    ${'=' * 50}
    |${' ' * 21 + 'AGROBOT' + ' ' * 20}|
    ${'=' * 50}
    |${' Option :'.padLeft(48)}|
    |${' '* 48}|
    |${' 1. Lahan'.padLeft(48)}|
    |${' 2. Bibit'.padLeft(48)}|
    |${' ' * 48}|
    |${' 4. EXIT'.padLeft(48)}|
    ${'=' * 50}
    """);
    int opsi = int.parse(stdin.readLineSync()!);
    if (opsi == 1) {
      opsiLahan();
    } else if (opsi == 2) {
      opsiBenih();
    } 
  }

  void opsiLahan() {
    clear();
    print("""
    ${'=' * 50}
    |${' ' * 21 + 'AGROBOT' + ' ' * 20}|
    ${'=' * 50}
    |${' Option :'.padLeft(48)}|
    |${' '* 48}|

    |${' 1. Input Luas Lahan'.padLeft(48)}|
    |${' 2. Informasi Lahan'.padLeft(48)}|
    |${' 3. Hapus Data Lahan'.padLeft(48)}|
    |${' '* 48}|

    |${' 4. BACK'.padLeft(48)}|
    ${'=' * 50}
    """);
    int opsi = int.parse(stdin.readLineSync()!);
    if (opsi == 1) {
      lahan();
    } else if (opsi == 2) {
      infoLahan();
    } else if (opsi == 3) {
      deleteLahan();
    } else if (opsi == 4) {
      tampilan();
    }
  }

  void infoLahan() {
    clear();
    int jumlahLahan = dataLahan.length;
    print("=" * 50);
    print("INFORMASI LAHAN");
    print("=" * 50);

    print("Nomor \t Luas \t\t Lokasi \t Populasi");
    print("-" * 50);
    for (Map<String, String> data in dataLahan.values) {
      print("${data['nomor']} \t ${data['luas']} \t\t ${data['lokasi']} \t ${data['populasi']}");
    }
    print("=" * 50);
    print("Total Lahan: $jumlahLahan");
    print("=" * 50);
    back();
  }

  void deleteLahan() {
    clear();
    print("Nomor \t Luas \t\t Lokasi \t Populasi");
    print("-" * 55);

    for (Map<String, String> data in dataLahan.values) {
      print("${data['nomor']} \t ${data['luas']} \t ${data['lokasi']} \t ${data['populasi']}");
    }

    print("-----------------------");
    print("Hapus lahan dengan nomor : ");
    String nomor = stdin.readLineSync()!;

    // Cari index data yang sesuai
    int index = dataLahan.keys.firstWhere((key) => dataLahan[key]!['nomor'] == nomor, orElse: () => -1);

    if (index != -1) {
      dataLahan.remove(index);
      saveDataLahan(dataLahan);
      print("Data dengan nomor $nomor berhasil dihapus");
    } else {
      print("Data dengan nomor $nomor tidak ditemukan");
    }

    back();
  }



  void opsiBenih() {
    clear();
    print("""
    ${'=' * 50}
    |${' ' * 21 + 'AGROBOT' + ' ' * 20}|
    ${'=' * 50}
    |${' Option :'.padLeft(48)}|
    |${' ' * 48}|
    |${' 1. Daftar Benih'.padLeft(48)}|
    |${' 2. Tambah Benih'.padLeft(48)}|
    |${' 3. Edit Benih'.padLeft(48)}|
    |${' 4. Hapus Benih'.padLeft(48)}|
    |${' 5. Search Benih'.padLeft(48)}|
    |${' ' * 48}|
    |${' 6. BACK'.padLeft(48)}|
    ${'=' * 50}
    """);
    int opsi = int.parse(stdin.readLineSync()!);
    if (opsi == 1) {
      daftarBenih();
    } else if (opsi == 2) {
      tambahBenih();
    } else if (opsi == 3) {
      updateBenih();
    } else if (opsi == 4) {
      deleteBenih();
    } else if (opsi == 5) {
      searchBenih();
    } else if (opsi == 6) {
      tampilan();
    }
  }

  void daftarBenih() {
    clear();
    print("=" * 50);
    print("INFORMASI DAFTAR BENIH");
    print("=" * 50);

    print("Nama \t\t Berat (gram) \t\t Harga");
    print("-" * 50);
    for (Map<String, String> data in hargaSayuran.values) {
      String nama = data['nama']!;
      String berat = data['berat']!;
      String harga = data['harga']!;
      if (nama.length <= 6) {
        print("$nama \t\t $berat \t\t\t Rp.$harga");
      } else if (nama.length > 6) {
        print("$nama \t $berat \t\t\t Rp.$harga");
      }
    }
    print("=" * 50);

    int jumlahBenih = hargaSayuran.length;
    print("Total Benih: $jumlahBenih");
    print("=" * 50);
    back();
  }

  void saveHargaSayuran(Map<int, Map<String, String>> data) {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln("Map<int, Map<String, String>> hargaSayuran = {");
    for (int key in data.keys) {
      buffer.writeln("$key: {");
      data[key]!.forEach((innerKey, innerValue) {
        buffer.writeln("'$innerKey': '$innerValue',");
      });
      buffer.writeln("},");
    }
    buffer.writeln("};");

    final File file = File('lib/dataHarga.dart');
    file.writeAsStringSync(buffer.toString());
  }
  

  void tambahBenih() {
    clear();
    print("=" * 50);
    print("TAMBAH BENIH");
    print("=" * 50);

    print("Nama Benih: ");
    String nama = stdin.readLineSync()!;

    print("Berat Benih: ");
    int berat = int.parse(stdin.readLineSync()!);

    print("Harga Benih: ");
    int harga = int.parse(stdin.readLineSync()!);

    for (Map<String, String> data in hargaSayuran.values) {
      if (nama == data['nama']) {
        print("Data dengan nama $nama sudah ada");
        print("Silahkan masukkan daftar benih lain..");
        tambahBenih();
      }
    }

    Map<String, String> newBenih = {
      'nama': nama,
      'berat': berat.toString(),
      'harga': harga.toString(),
    };

    hargaSayuran[hargaSayuran.length + 1] = newBenih;

    saveHargaSayuran(hargaSayuran);

    print("Berhasil disimpan!");
    back();
  }

  void deleteBenih() {
    clear();
    print("=" * 50);
    print("HAPUS BENIH");
    print("=" * 50);

    print("Nama Benih: ");
    String nama = stdin.readLineSync()!;

    print("Hapus benih dengan nama : $nama");

    int index = hargaSayuran.keys.firstWhere((key) => hargaSayuran[key]!['nama'] == nama, orElse: () => -1);

      if (index != -1) {
        hargaSayuran.remove(index);
        saveHargaSayuran(hargaSayuran);
      }
      index++;

    print("Data sudah terhapus");
    back();
  }

  void searchBenih() {
    clear();
    print("=" * 50);
    print("SEARCH BENIH");
    print("=" * 50);

    print("Cari bibit: ");
    String nama = stdin.readLineSync()!;

    List<Map<String, String>> dataFound = [];

    for (Map<String, String> data in hargaSayuran.values) {
      if (data['nama'] == nama) {
        dataFound.add(data);
      }
    }

    if (dataFound.isNotEmpty) {
      print("DATA DITEMUKAN: ");
      for (Map<String, String> data in dataFound) {
        print("Nama: ${data['nama']}");
        print("Berat: ${data['berat']} gram");
        print("Harga: Rp. ${data['harga']}");
      }
    } else {
      print("Data tidak ditemukan");
    }
    back();
  }

  void updateBenih() {
    print("=" * 50);
    print("INFORMASI DAFTAR BENIH");
    print("=" * 50);

    print("Nama \t\t Berat (gram) \t\t Harga");
    print("-" * 50);
    for (Map<String, String> data in hargaSayuran.values) {
      String nama = data['nama']!;
      String berat = data['berat']!;
      String harga = data['harga']!;
      if (nama.length <= 6) {
        print("$nama \t\t $berat \t\t\t Rp.$harga");
      } else if (nama.length > 6) {
        print("$nama \t $berat \t\t\t Rp.$harga");
      }
    }
    print("=" * 50);

    int jumlahBenih = hargaSayuran.length;
    print("Total Benih: $jumlahBenih");
    print("=" * 50);
    if (hargaSayuran.isNotEmpty) {
    print('');
    print('Masukkan nama benih yang akan diubah: ');
    var nama = stdin.readLineSync()!.toLowerCase();

    int index = hargaSayuran.keys.firstWhere(
      (key) => hargaSayuran[key]!['nama']!.toLowerCase() == nama,
      orElse: () => -1,
    );

    if (index != -1) {
      print('');
      print('Masukkan nama baru: ');
      var newNama = stdin.readLineSync()!;
      print('Masukkan berat baru (gram): ');
      var newBerat = stdin.readLineSync()!;
      print('Masukkan harga baru: ');
      var newHarga = stdin.readLineSync()!;

      Map<String, String> benihToBeUpdated = hargaSayuran[index]!;

      benihToBeUpdated['nama'] = newNama;
      benihToBeUpdated['berat'] = newBerat;
      benihToBeUpdated['harga'] = newHarga;

      saveHargaSayuran(hargaSayuran);

      print('');
      print('Data benih berhasil diubah!....');
      } else {
        print('');
        print('Benih dengan nama $nama tidak ditemukan');
      }
    } else {
      print('Daftar benih masih kosong.');
    }
    back();

  }

  
}
