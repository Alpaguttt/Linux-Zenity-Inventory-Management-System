Video Tanıtım

https://www.youtube.com/watch?v=I6xLX93nV2s

Zenity ile Envanter Yönetim Sistemi
Proje Açıklaması
Bu proje, Zenity araçlarını kullanarak grafik arayüz ile çalışan bir Envanter Yönetim Sistemidir. Program, ürün yönetimi (ekleme, listeleme, güncelleme, silme), raporlama ve kullanıcı yönetimi gibi özellikler sunar. Kullanıcılar iki farklı rol ile giriş yapabilir:

Yönetici: Ürün ve kullanıcı yönetimi yapabilir.
Kullanıcı: Sadece ürünleri görüntüleyebilir ve rapor alabilir.


Özellikler
1) Kullanıcı Rolleri ve Yetkileri:
Yönetici, ürün ve kullanıcı yönetimi yapabilir.
Kullanıcı, ürünleri listeleyebilir ve rapor alabilir.

2) Veri Saklama ve Dosya Yönetimi:
depo.csv: Ürün bilgileri saklanır.
kullanici.csv: Kullanıcı adı ve parolalar tutulur.
log.csv: Hatalı giriş denemeleri ve önemli işlemler kayıt edilir.

3) Raporlama:
Stokta Azalan Ürünler: Belirli bir eşik değerin altında kalan ürünler listelenir.
En Yüksek Stok Miktarına Sahip Ürünler: Belirli bir eşik değerin üstündeki ürünler gösterilir.

4) Program Yönetimi:
Diskteki toplam dosya boyutlarını gösterir.
depo.csv ve kullanici.csv dosyalarını yedekler.
log.csv dosyasındaki hata kayıtlarını gösterir.

Gereksinimler
Linux işletim sistemi.
Zenity (GUI araçları için).

Kullanım Kılavuzu

Giriş

Program açıldığında rol seçimi yapılır (Yönetici veya Kullanıcı).
Yönetici, kullanıcı adı ve parolasını girerek yetkilere erişebilir.

Ürün Yönetimi

Ürün Ekleme: Ürün adı, kategori, miktar ve fiyat bilgilerini girin.
Ürün Güncelleme: Mevcut bir ürünün stok veya fiyat bilgilerini değiştirin.
Ürün Silme: Ürünü listeden seçip envanterden kaldırın.

Raporlama

Stokta Azalan Ürünler: Miktarı belirli bir değerin altında olan ürünleri görüntüler.
Stok Fazlası: Fazla miktardaki ürünleri listeler.

Program Yönetimi

Disk Alanı: Dosyaların toplam disk kullanımını gösterir.
Yedekleme: Veri dosyalarını sıkıştırıp yedekler.
Hata Kayıtları: log.csv dosyasındaki tüm kayıtları görüntüler.


Ekran Görüntüleri
![Ekran görüntüsü 2025-01-07 195505](https://github.com/user-attachments/assets/aba9fa54-0a5e-4454-91ab-b4cc6dd7020b)

![Ekran görüntüsü 2025-01-07 195440](https://github.com/user-attachments/assets/8d48714b-29bd-4de9-8984-85a6dcb9dc8f)

![Ekran görüntüsü 2025-01-07 195309](https://github.com/user-attachments/assets/4208becc-d242-4d3a-b4c6-e4e055a12351)

![Ekran görüntüsü 2025-01-07 195238](https://github.com/user-attachments/assets/15c6fb81-57c9-42e1-b995-17294848a891)

![Ekran görüntüsü 2025-01-07 195223](https://github.com/user-attachments/assets/a8ada825-1d06-4149-ba7b-2bcd2e08c019)

![Ekran görüntüsü 2025-01-07 195159](https://github.com/user-attachments/assets/e3f117ce-d9bb-4879-aea3-dfcc0b32c134)

![Ekran görüntüsü 2025-01-07 195521](https://github.com/user-attachments/assets/637830be-5480-43d6-b56e-0544edcdf2cb)

![Ekran görüntüsü 2025-01-07 195642](https://github.com/user-attachments/assets/72cd01c9-0915-449d-9115-6fb6d1d37262)

![Ekran görüntüsü 2025-01-07 195627](https://github.com/user-attachments/assets/f2cc4d36-4da1-49ce-932a-9a6826d51dac)

![Ekran görüntüsü 2025-01-07 195545](https://github.com/user-attachments/assets/6e8a27e8-62c3-4643-a806-82fe795364c7)

![Ekran görüntüsü 2025-01-07 195652](https://github.com/user-attachments/assets/3e9d15bd-618d-4fc4-a0e7-4ca9c9bd100c)


Karşılaşılan Sorunlar

Karşılaştığınız en büyük teknik sorun neydi ve nasıl çözdünüz?
Sorun: CSV dosyalarının senkronizasyonunda veri kaybı yaşanması.

Çözüm: Veri yazma ve okuma işlemleri için dosya kilitleme mekanizması kullanıldı.

Zenity kullanımında en zorlandığınız kısım neydi?
Karmaşık form yapılarını sade bir şekilde oluşturma ve doğrulama mekanizmaları.

Hata tespiti için hangi adımları izlediniz?
Tüm hatalar log.csv dosyasında kaydedildi. Hata mesajları ve tarih bilgileri inceleyerek sorunun kaynağına ulaşıldı.

Ürün güncellerken farklı kategorilerde ürünlerin aynı ada sahip olabileceğini nasıl ele aldınız?
Her ürün için benzersiz bir kategori-ürün kimliği oluşturduk.

Veri kaybını önlemek için hangi adımları attınız?
Tüm veriler işlem sonrası otomatik olarak yedeklendi.

