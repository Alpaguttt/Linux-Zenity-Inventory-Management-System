 GNU nano 6.2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            caner.sh                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
# Yönetici Adı ve Parolası dosyalardan alınacak
ADMIN_USERNAME=$(cat "yöneticiadi.csv")
ADMIN_PASSWORD=$(cat "yöneticisifre.csv")

# Envanter dosyasını tanımlayın
INVENTORY_FILE="inventory.csv"

# Envanter dosyasını kontrol edin
if [ ! -f "$INVENTORY_FILE" ]; then
    touch "$INVENTORY_FILE"
fi

# Kullanıcı ve Yönetici Rolleri
select_role() {
    role=$(zenity --list --title="Giriş Yap" \
        --column="Rol" --column="Açıklama" \
        "Yönetici" "Ürün ekleyebilir, güncelleyebilir ve silebilir, kullanıcı yönetebilir." \
        "Kullanıcı" "Sadece ürünleri görüntüleyebilir ve rapor alabilir.")
    [ $? -ne 0 ] && exit

    case $role in
        "Yönetici") admin_login ;;
        "Kullanıcı") user_menu ;;
        *) zenity --error --text="Geçersiz rol seçimi!" ; exit ;;
    esac
}

# Yönetici Giriş Fonksiyonu
admin_login() {
    local username
    local password

    username=$(zenity --entry --title="Yönetici Giriş" --text="Kullanıcı adı girin:")
    [ $? -ne 0 ] && exit

    password=$(zenity --entry --title="Yönetici Giriş" --text="Parola girin:" --hide-text)
    [ $? -ne 0 ] && exit

    if [ "$username" == "$ADMIN_USERNAME" ] && [ "$password" == "$ADMIN_PASSWORD" ]; then
        zenity --info --text="Giriş başarılı. Ana menüye yönlendiriliyorsunuz."
        main_menu  # Ana menüyü başlat
    else
        zenity --error --text="Hatalı kullanıcı adı veya parola!"
        select_role  # Rol seçme ekranına geri dön
    fi
}

# Kullanıcı Menüsü
user_menu() {
    while true; do
        choice=$(zenity --list --title="Kullanıcı Menüsü" \
            --column="İşlem" --column="Açıklama" \
            "1" "Ürünleri Listele" \
            "2" "Rapor Al" \
            "3" "Çıkış")

        [ $? -ne 0 ] && exit

        case $choice in
            1) list_products ;;
            2) generate_report ;;
            3) exit ;;
            *) zenity --error --text="Geçersiz seçim!" ;;
        esac
    done
}

# Envanter dosyasını tanımlayın
INVENTORY_FILE="inventory.csv"
ADMIN_FILE="yönetici.csv"  # Yönetici bilgileri bu dosyada saklanacak

# Envanter dosyasını kontrol edin
if [ ! -f "$INVENTORY_FILE" ]; then
    touch "$INVENTORY_FILE"
fi

# Yönetici Giriş Fonksiyonu
admin_login() {
    local username
    local password
    local stored_username
    local stored_password

    # Kullanıcı adı ve şifreyi dosyadan okuma
    stored_username=$(cut -d',' -f1 "$ADMIN_FILE")
    stored_password=$(cut -d',' -f2 "$ADMIN_FILE")

    username=$(zenity --entry --title="Yönetici Giriş" --text="Kullanıcı adı girin:")
    [ $? -ne 0 ] && exit

    password=$(zenity --entry --title="Yönetici Giriş" --text="Parola girin:" --hide-text)
    [ $? -ne 0 ] && exit

    if [ "$username" == "$stored_username" ] && [ "$password" == "$stored_password" ]; then
        zenity --info --text="Giriş başarılı. Ana menüye yönlendiriliyorsunuz."
        main_menu  # Ana menüyü başlat
    else
        zenity --error --text="Hatalı kullanıcı adı veya parola!"
        select_role  # Rol seçme ekranına geri dön
    fi
}

# Kullanıcı giriş fonksiyonu
user_login() {
    local username
    local password
    local attempts=3

    while [ $attempts -gt 0 ]; do
        username=$(zenity --entry --title="Kullanıcı Giriş" --text="Kullanıcı adı girin:")
        [ $? -ne 0 ] && return

        password=$(zenity --entry --title="Kullanıcı Giriş" --text="Parola girin:" --hide-text)
        [ $? -ne 0 ] && return

        # Kullanıcı adını ve şifreyi kontrol et
        while IFS=, read -r stored_username stored_password; do
            if [ "$username" == "$stored_username" ] && [ "$password" == "$stored_password" ]; then
                zenity --info --text="Giriş başarılı! Kullanıcı menüsüne yönlendiriliyorsunuz."
                user_menu  # Kullanıcı menüsüne yönlendir
                return
            fi
        done < "kullanıcı.csv"

        attempts=$((attempts - 1))
        echo "$(date): Hatalı giriş denemesi - Kullanıcı adı: $username" >> log.csv
        if [ $attempts -gt 0 ]; then
            zenity --error --text="Hatalı kullanıcı adı veya parola! Kalan deneme hakkı: $attempts"
        else
            zenity --error --text="Tüm deneme haklarınız tükendi. Lütfen tekrar deneyin."
        fi
    done

    select_role  # Rol seçme ekranına geri dön
}


# Kullanıcı ve Yönetici Rolleri
select_role() {
    role=$(zenity --list --title="Giriş Yap" \
        --column="Rol" --column="Açıklama" \
        "Yönetici" "Ürün ekleyebilir, güncelleyebilir ve silebilir, kullanıcı yönetebilir." \
        "Kullanıcı" "Sadece ürünleri görüntüleyebilir ve rapor alabilir.")
    [ $? -ne 0 ] && exit

    case $role in
        "Yönetici") admin_login ;;
        "Kullanıcı") user_login ;;  # Kullanıcı giriş fonksiyonu çağrılır

        *) zenity --error --text="Geçersiz rol seçimi!" ; exit ;;
    esac
}

# Kullanıcı Menüsü
user_menu() {
    while true; do
        choice=$(zenity --list --title="Kullanıcı Menüsü" \
            --column="İşlem" --column="Açıklama" \
            "1" "Ürünleri Listele" \
            "2" "Rapor Al" \
            "3" "Çıkış")

        [ $? -ne 0 ] && exit

        case $choice in
            1) list_products ;;
            2) generate_report ;;
            3) exit ;;
            *) zenity --error --text="Geçersiz seçim!" ;;
        esac
    done
}

#kullanıcı ekleme fonksiyonu
add_user() {
    local username
    local password

    username=$(zenity --entry --title="Yeni Kullanıcı Ekle" --text="Kullanıcı adı girin:")
    [ $? -ne 0 ] && return

    if grep -q "^$username," "kullanıcı.csv"; then
        zenity --error --text="Bu kullanıcı adı zaten mevcut!"
        return
    fi

    password=$(zenity --entry --title="Yeni Kullanıcı Ekle" --text="Parola girin:" --hide-text)
    [ $? -ne 0 ] && return

    echo "$username,$password" >> "kullanıcı.csv"
    zenity --info --text="Kullanıcı başarıyla eklendi!"
}

#kullanıcı siilme fonksiyonu
delete_user() {
    if [ ! -s "kullanıcı.csv" ]; then
        zenity --warning --text="Kayıtlı kullanıcı yok!"
        return
    fi

    selected_user=$(zenity --list --title="Kullanıcı Sil" \
        --column="Kullanıcı Adı" \
        $(awk -F, '{print $1}' "kullanıcı.csv"))
    [ $? -ne 0 ] && return

    if zenity --question --title="Onay Gerekiyor" --text="Seçilen kullanıcıyı silmek istediğinize emin misiniz?"; then
        grep -v "^$selected_user," "kullanıcı.csv" > temp.csv && mv temp.csv "kullanıcı.csv"
        zenity --info --text="Kullanıcı başarıyla silindi!"
    else
        zenity --info --text="İşlem iptal edildi."
    fi
}
#kullanıcı görme fonksiyonu
list_users() {
    if [ ! -s "kullanıcı.csv" ]; then
        zenity --warning --text="Kayıtlı kullanıcı yok!"
        return
    fi

    zenity --list --title="Kayıtlı Kullanıcılar" \
        --column="Kullanıcı Adı" \
        $(awk -F, '{print $1}' "kullanıcı.csv")
}


# Ürünleri Listeleme Fonksiyonu
list_products() {
    if [ ! -s "$INVENTORY_FILE" ]; then
        zenity --warning --text="Envanterde ürün yok!"
        return
    fi

    zenity --list --title="Ürün Listesi" \
        --column="Ürün Adı" --column="Miktar" --column="Fiyat" \
        $(awk -F, '{print $1, $2, $3}' OFS=" " "$INVENTORY_FILE")

    # Kullanıcıya işlem yapmak isteyip istemediğini soruyoruz
    continue_choice=$(zenity --question --title="Devam Etmek İster misiniz?" --text="Başka bir işlem yapmak ister misiniz?" --ok-label="Evet" --cancel-label="Hayır")

    if [ $? -ne 0 ]; then
        return  # Eğer Hayır seçildiyse, kullanıcı menüsüne geri döner
    fi
}




# Ürün ekleme fonksiyonu
add_product() {
    local product_name
    local product_quantity
    local product_price

    # Ürün adı girme
    product_name=$(zenity --entry --title="Ürün Ekle" --text="Ürün adı girin:")
    [ $? -ne 0 ] && return

    # Ürün zaten mevcut mu diye kontrol etme
    if grep -q "^$product_name," "$INVENTORY_FILE"; then
        zenity --error --text="Bu ürün zaten mevcut!"
        return
    fi

    # İlerleme çubuğu başlat
    (
        echo "0" ; sleep 1
        echo "# Ürün adı kontrol ediliyor..." ; sleep 1

        # Ürün miktarını girme
        product_quantity=$(zenity --entry --title="Ürün Ekle" --text="Ürün miktarı girin:")
        [ $? -ne 0 ] && return
        echo "20" ; sleep 1
        echo "# Miktar girildi..." ; sleep 1

        # Ürün fiyatını girme
        product_price=$(zenity --entry --title="Ürün Ekle" --text="Ürün fiyatı girin:")
        [ $? -ne 0 ] && return
        echo "50" ; sleep 1
        echo "# Fiyat girildi..." ; sleep 1

        # Ürün verilerini dosyaya ekleme
        first_line=$(head -n 1 "$INVENTORY_FILE")
        tail -n +2 "$INVENTORY_FILE" > tmpfile
        echo "$first_line" > "$INVENTORY_FILE"
        echo "$product_name,$product_quantity,$product_price" >> "$INVENTORY_FILE"
        cat tmpfile >> "$INVENTORY_FILE"
        echo "80" ; sleep 1
        echo "# Ürün dosyaya eklendi..." ; sleep 1

        echo "100" ; sleep 1
        echo "# İşlem tamamlandı." ; sleep 1
    ) | zenity --progress --title="Ürün Ekleme" --text="Ürün ekleniyor..." --auto-close --auto-kill

    zenity --info --text="Ürün başarıyla eklendi!"
}


# Ürün güncelleme fonksiyonu
update_product() {
    local selected_product
    local updated_quantity
    local updated_price

    # Ürün seçme
    selected_product=$(zenity --list --title="Güncellenecek Ürün Seç" \
        --column="Ürün Adı" --column="Miktar" --column="Fiyat" \
        $(awk -F, '{print $1, $2, $3}' OFS=" " "$INVENTORY_FILE"))
    [ $? -ne 0 ] && return

    # İlerleme çubuğu başlat
    (
        echo "0" ; sleep 1
        echo "# Ürün seçiliyor..." ; sleep 1

        # Yeni miktarı girme
        updated_quantity=$(zenity --entry --title="Miktar Güncelle" --text="Yeni miktarı girin:")
        [ $? -ne 0 ] && return
        echo "30" ; sleep 1
        echo "# Miktar güncelleniyor..." ; sleep 1

        # Yeni fiyatı girme
        updated_price=$(zenity --entry --title="Fiyat Güncelle" --text="Yeni fiyatı girin:")
        [ $? -ne 0 ] && return
        echo "60" ; sleep 1
        echo "# Fiyat güncelleniyor..." ; sleep 1

        # Ürün verilerini güncelleme
        awk -F, -v product="$selected_product" -v quantity="$updated_quantity" -v price="$updated_price" \
            'BEGIN {OFS=","} {if ($1 == product) $2 = quantity; if ($1 == product) $3 = price} 1' \
            "$INVENTORY_FILE" > tmpfile && mv tmpfile "$INVENTORY_FILE"

        echo "90" ; sleep 1
        echo "# Dosya güncelleniyor..." ; sleep 1

        echo "100" ; sleep 1
        echo "# İşlem tamamlandı." ; sleep 1
    ) | zenity --progress --title="Ürün Güncelleniyor" --text="Ürün güncelleniyor..." --auto-close --auto-kill

    zenity --info --text="Ürün başarıyla güncellendi!"
}
# Ürün silme fonksiyonu
delete_product() {
    local selected_product
    local selected_product_name

    if [ ! -s "$INVENTORY_FILE" ]; then
        zenity --warning --text="Envanterde ürün yok!"
        return
    fi

    # Ürün seçimi
    selected_product=$(zenity --list --title="Silinecek Ürün Seç" \
        --column="Ürün Adı" --column="Miktar" --column="Fiyat" \
        $(awk -F, '{print $1, $2, $3}' OFS=" " "$INVENTORY_FILE"))
    [ $? -ne 0 ] && return

    selected_product=$(echo "$selected_product" | xargs)
    selected_product_name=$(echo "$selected_product" | cut -d' ' -f1)

    # İlerleme çubuğu başlat
    (
        echo "0" ; sleep 1
        echo "# Ürün seçiliyor..." ; sleep 1

        if zenity --question --title="Onay Gerekiyor" --text="Seçilen ürünü silmek istediğinize emin misiniz?"; then
            echo "30" ; sleep 1
            echo "# Ürün siliniyor..." ; sleep 1

            grep -v "^$selected_product_name," "$INVENTORY_FILE" > tmpfile && mv tmpfile "$INVENTORY_FILE"

            echo "60" ; sleep 1
            echo "# Dosya güncelleniyor..." ; sleep 1

            echo "100" ; sleep 1
            echo "# Silme işlemi tamamlandı." ; sleep 1
        else
            echo "100" ; sleep 1
            echo "# Silme işlemi iptal edildi." ; sleep 1
        fi
    ) | zenity --progress --title="Ürün Siliniyor" --text="Ürün siliniyor..." --auto-close --auto-kill

    zenity --info --text="Ürün başarıyla silindi!"
}

# Rapor al fonksiyonu
generate_report() {
    choice=$(zenity --list --title="Rapor Al" \
        --column="Seçenek" --column="Açıklama" \
        "1" "Stokta Azalan Ürünler" \
        "2" "Stokta Fazla Olan Ürünler" \
        "3" "Geri Dön")
    [ $? -ne 0 ] && return

    case $choice in
        1) low_stock_report ;;
        2) high_stock_report ;;
        3) return ;;
        *) zenity --error --text="Geçersiz seçim!" ;;
    esac
}

# Stokta azalan ürünleri raporlama fonksiyonu
low_stock_report() {
    local threshold=3
    local results=$(awk -F, -v threshold="$threshold" '$2 < threshold {print $1, $2, $3}' OFS=" " "$INVENTORY_FILE")
    if [ -z "$results" ]; then
        zenity --info --text="Stokta azalan ürün yok."
    else
        zenity --list --title="Stokta Azalan Ürünler (Eşik: $threshold)" \
            --column="Ürün Adı" --column="Miktar" --column="Fiyat" $results
    fi
}

# En yüksek stok miktarına sahip ürünleri raporlama fonksiyonu
high_stock_report() {
    local threshold=50
    local results=$(awk -F, -v threshold="$threshold" '$2 > threshold {print $1, $2, $3}' OFS=" " "$INVENTORY_FILE")
    if [ -z "$results" ]; then
        zenity --info --text="Stokta yüksek miktarda ürün yok."
    else
        zenity --list --title="En Yüksek Stok Miktarına Sahip Ürünler (Eşik: $threshold)" \
            --column="Ürün Adı" --column="Miktar" --column="Fiyat" $results
    fi
}

program_management_menu() {
    while true; do
        choice=$(zenity --list --title="Program Yönetimi" \
            --column="İşlem" --column="Açıklama" \
            "1" "Diskte Kapladığı Alanı Göster" \
            "2" "Diske Yedek Al" \
            "3" "Hata Kayıtlarını Görüntüle" \
            "4" "Geri Dön")

        [ $? -ne 0 ] && return

        case $choice in
            1) show_disk_usage ;;
            2) backup_data ;;
            3) view_error_logs ;;
            4) return ;;
            *) zenity --error --text="Geçersiz seçim!" ;;
        esac
    done
}


view_error_logs() {
    if [ ! -s "log.csv" ]; then
        zenity --warning --text="Hata kaydı bulunamadı."
    else
        zenity --text-info --title="Hata Kayıtları" --filename="log.csv"
    fi
}


backup_data() {
    local backup_file="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
    tar -czf "$backup_file" depo.csv kullanici.csv 2>/dev/null
    zenity --info --title="Yedekleme Tamamlandı" --text="Veriler '$backup_file' dosyasına yedeklendi."
}

show_disk_usage() {
    disk_usage=$(du -sh ./*.sh inventory.csv kullanici.csv log.csv 2>/dev/null)
    zenity --info --title="Diskte Kaplanan Alan" --text="Dosyalar:\n$disk_usage"
}


# yöneticinin ekranı
main_menu() {
    while true; do
        choice=$(zenity --list --title="Envanter Yönetim Sistemi" \
            --column="İşlem" --column="Açıklama" \
            "1" "Ürün Ekle" \
            "2" "Ürünleri Listele" \
            "3" "Ürün Güncelle" \
            "4" "Ürün Sil" \
            "5" "Rapor Al" \
            "6" "Kullanıcı Yönetimi" \
            "7" "Program Yönetimi" \
            "8" "Geri" \
            "9" "Çıkış")
        [ $? -ne 0 ] && break

        case $choice in
            1) add_product ;;
            2) list_products ;;
            3) update_product ;;
            4) delete_product ;;
            5) generate_report ;;
            6) user_management ;;
            7)program_management_menu ;;
            8) select_role;;
            9) break ;;
            *) zenity --error --text="Geçersiz seçim!" ;;
        esac
    done
}

#kullanıcı yönetim ekranı
user_management() {
    choice=$(zenity --list --title="Kullanıcı Yönetimi" \
        --column="İşlem" --column="Açıklama" \
        "1" "Yeni Kullanıcı Ekle" \
        "2" "Kullanıcı Sil" \
        "3" "Kullanıcıları Listele" \
        "4" "Geri Dön")
    [ $? -ne 0 ] && return

    case $choice in
        1) add_user ;;
        2) delete_user ;;
        3) list_users ;;  # Kullanıcıları listele seçeneği
        4) return ;;
        *) zenity --error --text="Geçersiz seçim!" ;;
    esac
}

# Script başlatma
select_role  # İlk olarak rol seçimi ekranını başlat


# Ürünleri Listeleme Fonksiyonu
list_products() {
    if [ ! -s "$INVENTORY_FILE" ]; then
        zenity --warning --text="Envanterde ürün yok!"
        return
    fi

    zenity --list --title="Ürün Listesi" \
        --column="Ürün Adı" --column="Miktar" --column="Fiyat" \
        $(awk -F, '{print $1, $2, $3}' OFS=" " "$INVENTORY_FILE")

    # Kullanıcıya işlem yapmak isteyip istemediğini soruyoruz
    continue_choice=$(zenity --question --title="Devam Etmek İster misiniz?" --text="Başka bir işlem yapmak ister misiniz?" --ok-label="Evet" --cancel-label="Hayır")

    if [ $? -ne 0 ]; then
        return  # Eğer Hayır seçildiyse, kullanıcı menüsüne geri döner
    fi
}

# Ürün ekleme, güncelleme, silme ve raporlama fonksiyonlarını ekleyin...

# Ana menü

# Script başlatma
select_role  # İlk olarak rol seçimi ekranını başlat