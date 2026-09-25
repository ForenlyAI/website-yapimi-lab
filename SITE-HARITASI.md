# Kahve Durağı — Site Haritası

İçerik dersleri bu dosyayı **sözleşme** olarak kullanır: ders metninde geçen sayfa adresi, dosya adı,
bileşen adı ve özellik (prop) adları burada yazdığı gibidir. Bir ad değişirse önce burası, sonra kod,
sonra ders metni güncellenir.

Kök: `lab/kahve-duragi/` (bitmiş hâl). Astro 7.3.5, statik çıktı (`output: "static"`).

## Sayfalar

| Adres | Dosya | `<title>` | Amaç | Kullandığı bileşenler | Site haritasında |
|---|---|---|---|---|---|
| `/` | `src/pages/index.astro` | Kahve Durağı · Odunpazarı’nda mahalle kahvecisi | Karşılama, “Neden biz?”, öne çıkan 3 ürün, saatler | Layout, MenuItem | evet |
| `/menu/` | `src/pages/menu.astro` | Menü · Kahve Durağı | 3 kategori, 10 ürün, fiyatlar TL | Layout, MenuItem | evet |
| `/hakkimizda/` | `src/pages/hakkimizda.astro` | Hakkımızda · Kahve Durağı | Hikâye + 3 değer | Layout | evet |
| `/iletisim/` | `src/pages/iletisim.astro` | İletişim · Kahve Durağı | Bilgiler, saatler, form (ad, e-posta, mesaj, KVKK onayı), teşekkür durumu | Layout | evet |
| `/tesekkurler/` | `src/pages/tesekkurler.astro` | Teşekkürler · Kahve Durağı | Form servisinin yönlendireceği sayfa (`noindex`) | Layout | **hayır** (filtre) |
| (bulunamayan her adres) | `src/pages/404.astro` → `dist/404.html` | Sayfa bulunamadı · Kahve Durağı | 404, ana sayfa/menü bağlantısı (`noindex`) | Layout | hayır |

Üst menü sırası (`src/data/site.ts` → `MENU_LINKLERI`): Ana Sayfa · Menü · Hakkımızda · İletişim.
Etkin sayfanın bağlantısı `aria-current="page"` alır.

## Bileşenler

| Bileşen | Dosya | Özellikler (props) | Görevi |
|---|---|---|---|
| **Layout** | `src/layouts/Layout.astro` | `baslik` (zorunlu), `aciklama?`, `gorsel?` (varsayılan `/og-kahve-duragi.png`), `indekslenmesin?` | `<html lang="tr">`, `<head>` (title, description, canonical, og:*, twitter:card, favicon, theme-color, sitemap bağlantısı, yazı tipi ön yüklemesi), “İçeriğe geç” bağlantısı, Header + `<main>` + Footer |
| **Header** | `src/components/Header.astro` | — | Logo + ana menü; 760 px altında “Menü” düğmesi (`aria-expanded`, Esc ile kapanır) |
| **Footer** | `src/components/Footer.astro` | — | Adres, telefon, e-posta, çalışma saatleri, alt menü, telif satırı |
| **MenuItem** | `src/components/MenuItem.astro` | `ad`, `aciklama`, `fiyat` (sayı, TL), `gorsel` (yol), `etiket?` | Tek ürün kartı; fiyatı `fiyatYaz()` ile “105 TL” biçiminde yazar |

## Veri dosyaları

| Dosya | İçerik |
|---|---|
| `src/data/site.ts` | `SITE` (ad, slogan, açıklama, telefon, telefonLink, eposta, adres, saatler) ve `MENU_LINKLERI` |
| `src/data/menu.ts` | `Urun`, `Kategori` türleri; `MENU` (sicak · soguk · tatli) ve `fiyatYaz()` |

Menü (fiyatlar örnektir):

| Kategori (`id`) | Ürün | Fiyat | Etiket |
|---|---|---|---|
| Sıcak Kahveler (`sicak`) | Espresso | 70 TL | |
| | Americano | 85 TL | |
| | Latte | 105 TL | Çok sevilen |
| | Türk Kahvesi | 80 TL | |
| Soğuk İçecekler (`soguk`) | Soğuk Demleme | 115 TL | Yeni |
| | Buzlu Latte | 110 TL | |
| | Ev Yapımı Limonata | 90 TL | |
| Tatlılar ve Atıştırmalıklar (`tatli`) | Cheesecake | 140 TL | |
| | Havuçlu Kek | 95 TL | |
| | Peynirli Poğaça | 45 TL | |

## Stil

`src/styles/global.css` — renk değişkenleri (`--krem`, `--espresso`, `--karamel`, `--yesil` …),
yazı tipleri (`@font-face`, `font-display: swap`), ortak sınıflar: `.kap` (orta sütun, 1120 px),
`.bolum`, `.sayfa-basi`, `.ust-yazi`, `.dugme` / `.dugme.ikincil`, `.gorunmez` (yalnız ekran okuyucu),
`.atla`. Sayfa ve bileşenlere özel stiller kendi dosyalarındaki `<style>` içindedir (Astro bunları o
bileşene sınırlar).

## `public/` dosyaları

| Dosya | Not |
|---|---|
| `favicon.svg`, `favicon.ico`, `apple-touch-icon.png` | Logo simgesi; PNG/ICO, `araclar/gorseller.py` ile SVG’den üretildi |
| `og-kahve-duragi.png` | 1200×630 paylaşım kartı |
| `robots.txt` | Herkese açık + `Sitemap:` satırı (adres yer tutucu) |
| `fonts/*.woff2` | Baloo 2 (700, başlık), Source Sans 3 (değişken 200–900, gövde); latin + latin-ext |
| `img/hero.svg`, `img/kafe.svg`, `img/bos-fincan.svg` | Ana sayfa, Hakkımızda, 404 çizimleri (alt metinli) |
| `img/espresso.svg`, `latte.svg`, `turk-kahvesi.svg`, `soguk-kahve.svg`, `limonata.svg`, `pasta.svg`, `pogaca.svg` | Menü simgeleri (süs görseli: `alt=""`, ürün adı başlıkta) |

Derleme sonrası ayrıca `dist/sitemap-index.xml` ve `dist/sitemap-0.xml` oluşur (@astrojs/sitemap).

## Yer tutucular (yayından önce değişecek)

| Nerede | Değer | Neden |
|---|---|---|
| `astro.config.mjs` → `site` | `https://kahve-duragi.pages.dev` | sitemap, canonical ve og:url bu adresle üretilir |
| `public/robots.txt` → `Sitemap:` | aynı adres | |
| `src/pages/iletisim.astro` → `FORM_ADRESI` | `/tesekkurler/` | Statik sitenin form sunucusu yok; ders sürümünde gönderim tarayıcıda durdurulur, veri gönderilmez |
| `src/data/site.ts` | 0222 000 00 00 · merhaba@example.com · Örnek Sokak No: 1 | Kurgusal iletişim bilgileri |

## Aşamalar (ne zaman ne eklenir)

| Klasör | Sayfalar | Eklenenler |
|---|---|---|
| `asamalar/1.3-bos-proje` | `/` (“Astro” başlığı) | `npm create astro` minimal şablonu; yalnız `astro` sürümü sabitlendi |
| `asamalar/2.1-duzen` | `/`, `/menu/`, `/hakkimizda/`, `/iletisim/` (son üçü “yakında”) | global.css, yazı tipleri, Layout (sade `<head>`), Header (mobil menü), Footer, `site.ts`, kahraman bölümü |
| `asamalar/2.2-icerik` | + dolu Menü ve Hakkımızda, tam ana sayfa | `menu.ts`, MenuItem, menü/dükkân çizimleri |
| `kahve-duragi` | + İletişim formu, Teşekkürler, 404 | og/twitter etiketleri, canonical, favicon.ico, apple-touch-icon, og görseli, robots.txt, @astrojs/sitemap |

## Ekran görüntüleri (`ekran/<ders>/`)

Ders numaraları geçici plana göredir; ders planı onaylanınca klasör adları eşlenir.

| Ders | Dosya | Kaynak |
|---|---|---|
| 1.3 | `npm-create-astro.png/.txt` | gerçek `npm create astro@latest … --template minimal` çıktısı |
| 1.3 | `npm-install.png/.txt`, `npm-run-dev.png/.txt` | `asamalar/1.3-bos-proje` |
| 1.3 | `bos-proje-tarayici.png` | boş proje, `astro dev` (alttaki Astro geliştirici çubuğu dahil) |
| 2.1 | `ana-sayfa-masaustu.png`, `ana-sayfa-mobil.png`, `mobil-menu-acik.png` | `asamalar/2.1-duzen` |
| 2.2 | `menu-masaustu.png`, `menu-tam-sayfa.png`, `menu-mobil.png`, `hakkimizda-masaustu.png` | `asamalar/2.2-icerik` |
| 2.3 | `iletisim-bos.png`, `iletisim-hatalar.png`, `iletisim-dolu.png`, `iletisim-tesekkur.png`, `iletisim-mobil.png`, `404-sayfasi.png` | `kahve-duragi` |
| 3.1 | `npm-run-build.png/.txt`, `npm-run-preview.png/.txt`, `son-site-masaustu.png`, `son-site-mobil.png` | `kahve-duragi` |
| 3.4 | `lighthouse-mobil.png`, `lighthouse-masaustu.png` | `rapor/lighthouse-*.report.html` |
