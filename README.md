Video Tanıtım

https://www.youtube.com/watch?v=I6xLX93nV2s

Proje Açıklaması

Bu proje, Zenity araçlarını kullanarak geliştirilmiş, kullanıcı dostu bir grafik arayüz sunan basit bir Envanter Yönetim Sistemidir. Proje, ürün ekleme, listeleme, güncelleme, silme, raporlama ve kullanıcı yönetimi gibi temel işlevleri sağlar.

Özellikler

Kullanıcı Rolleri

Yönetici: Ürün ekleme, güncelleme, silme ve kullanıcı yönetimi yapabilir.

Kullanıcı: Sadece ürünleri görüntüleyebilir ve rapor alabilir.

Veri Saklama

Veriler depo.csv, kullanici.csv ve log.csv dosyalarında saklanır.

Ana Menü

Ürün Ekle: Yeni bir ürün ekleme.

Ürün Listele: Mevcut ürünlerin listesi.

Ürün Güncelle: Mevcut ürün bilgilerini güncelleme.

Ürün Sil: Ürünü envanterden kaldırma.

Rapor Al: Stok raporları.

Stokta Azalan Ürünler.

En Yüksek Stok Miktarına Sahip Ürünler.

Kullanıcı Yönetimi: Kullanıcı ekleme, listeleme, güncelleme, silme.

Program Yönetimi:

Diskte Kapladığı Alanı Göster.

Diske Yedek Al.

Hata Kayıtlarını Görüntüle.

Çıkış.

Gereksinimler

Linux işletim sistemi.

Zenity (GUI diyalog kutuları için).

Kurulum ve Çalıştırma

chmod +x inventory_management.sh komutu ile betik çalıştırılabilir hale getirin.

./inventory_management.sh komutu ile programı başlatın.

Kullanım Kılavuzu

Giriş

Program başlatıldığında yönetici veya kullanıcı rolü seçilir.

Yönetici giriş bilgileri kullanici.csv dosyasına kaydedilmiştir.

Ürün Yönetimi

Ürün Ekle: Ürün adı, kategori, stok miktarı ve fiyat bilgileri girilerek yeni ürün eklenir.

Ürün Listele: Tüm ürünlerin listesi gösterilir.

Ürün Güncelle: Seçilen ürünün stok veya fiyat bilgileri güncellenir.

Ürün Sil: Belirtilen ürün envanterden kaldırılır.

Raporlama

Stokta Azalan Ürünler: Belirli bir eşik değerin altındaki ürünler listelenir.

En Yüksek Stok Miktarına Sahip Ürünler: Belirli bir eşik değerin üzerindeki ürünler listelenir.

Kullanıcı Yönetimi

Yönetici, yeni kullanıcı ekleyebilir, mevcut kullanıcıları listeleyebilir, güncelleyebilir veya silebilir.

Program Yönetimi

Diskte Kapladığı Alanı Göster: Depo, kullanıcı ve log dosyalarının toplam alanı gösterilir.

Diske Yedek Al: depo.csv ve kullanici.csv dosyaları yedeklenir.

Hata Kayıtlarını Görüntüle: log.csv içeriği görüntülenir.



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

