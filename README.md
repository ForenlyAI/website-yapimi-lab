# Website Yapımı 101 — Öğrenci Laboratuvarı

Forenly AI Academy **Website Yapımı 101** kursunun çalışma ortamı: örnek site **Kahve Durağı**nın bitmiş hâli
ve derslerin ara aşamaları (Astro 7.3.5, sürümler `package-lock.json` ile sabit).

## En kolay yol: GitHub Codespaces (kurulum yok)

[![Codespace'te aç](https://github.com/codespaces/badge.svg)](https://codespaces.new/ForenlyAI/website-yapimi-lab)

1. Düğmeye tıklayın (kişisel GitHub hesabı yeterli; ücretsiz kota içindedir). Node 22 ve Astro eklentisi hazır gelir.
2. İlk açılışta `kahve-duragi` paketleri kurulur; terminalde `Hazır.` yazısını bekleyin.
3. Siteyi çalıştırın ve **Ports** sekmesindeki 4321 adresini açın:
   ```bash
   cd kahve-duragi
   npm run dev -- --host
   ```
4. Tüm projeleri denetlemek için depo kökünde: `./kontrol.sh --onizleme`

İşiniz bitince Codespace'i durdurun (github.com/codespaces), kotanız boşa harcanmaz.

## Kendi bilgisayarınızda

Bu klasörde kurs boyunca yapacağımız örnek sitenin **bitmiş hâli**, derslerin **ara aşamaları** ve
ders görsellerini üreten araçlar var. Örnek site: Eskişehir’de kurgusal bir mahalle kafesi,
**Kahve Durağı**. Astro ile yapılır, bilgisayarınızda önizlenir, derlenir ve Cloudflare Pages’e
yüklenmeye hazır hâle getirilir.

> Kafenin adı, adresi, telefonu (0222 000 00 00) ve e-postası (merhaba@example.com) kurgusaldır.
> Görseller bu kurs için çizilmiş SVG’lerdir; fotoğraf ya da telifli içerik yoktur.

### 1. Kurulum

İhtiyacınız olan iki program:

| Program | Sürüm | Neden |
|---|---|---|
| **Node.js** | 22 LTS (en az 22.12) | Astro’yu çalıştırır; `npm` onunla birlikte gelir |
| **VS Code** | güncel | Kod düzenleyici. “Astro” eklentisini (astro-build.astro-vscode) kurun |

Kurulumdan sonra bir terminal açıp sürümleri kontrol edin:

```bash
node -v    # v22.x.x olmalı
npm -v     # 10.x ya da üstü
```

#### Windows

- Node.js’i <https://nodejs.org> adresinden “LTS” (22) yükleyicisiyle kurun ya da PowerShell’de:
  `winget install OpenJS.NodeJS.LTS`
- Komutları **PowerShell** ya da VS Code’un içindeki terminalde (Ctrl+ö / Ctrl+`) çalıştırın.
- PowerShell `npm` için “running scripts is disabled” derse bir kez şunu çalıştırın:
  `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` (ya da `npm` yerine `npm.cmd` yazın).
- Klasör yollarında Türkçe karakter ve boşluk sorun çıkarabilir; projeyi `C:\siteler\kahve-duragi`
  gibi sade bir yola koyun.

#### macOS

- Node.js’i <https://nodejs.org> adresindeki `.pkg` yükleyiciyle ya da Homebrew ile kurun:
  `brew install node@22` (Homebrew kurulumdan sonra PATH’e eklemeniz için bir satır verir).
- Komutları Terminal uygulamasında ya da VS Code’un terminalinde çalıştırın.

#### Linux

- Dağıtımınızın paket deposundaki Node sürümü eski olabilir; <https://nodejs.org> ya da `nvm` ile 22 LTS kurun.

### 2. Komutlar

Hepsi proje klasörünün içinde çalıştırılır (ör. `cd kahve-duragi`).

| Komut | Ne yapar |
|---|---|
| `npm create astro@latest` | Yeni bir Astro projesi açar (ders 1.3). Bizim kullandığımız hâli: `npm create astro@latest -- ilk-site --template minimal --no-install --no-git --yes` |
| `npm install` | `package.json`’daki paketleri kurar, `package-lock.json`’ı yazar/günceller |
| `npm ci` | `package-lock.json`’daki **birebir** sürümleri temiz kurar (hazır projeyi indirdiyseniz bunu kullanın) |
| `npm run dev` | Geliştirme sunucusu: <http://localhost:4321>. Dosyayı kaydettikçe sayfa kendiliğinden yenilenir. Durdurmak: **Ctrl+C** (ya da `q` + Enter) |
| `npm run build` | Yayına hazır siteyi `dist/` klasörüne üretir (salt HTML/CSS/JS/görsel) |
| `npm run preview` | `dist/` klasörünü yayındaki gibi <http://localhost:4321> adresinde sunar; yayından önce son kontrol |

Bu projede Astro **7.3.5** ve site haritası eklentisi **@astrojs/sitemap 3.7.4** sabit sürümle
(`^` olmadan) kullanılır; `package-lock.json` da klasörde durur. Böylece herkes aynı sürümü kurar.

### 3. Klasör yapısı

```
ForenlyAI/website-yapimi-lab/
├── kahve-duragi/            ← BİTMİŞ SİTE (kursun sonundaki hâl)
│   ├── astro.config.mjs     site adresi + sitemap eklentisi
│   ├── package.json         sabit sürümler; package-lock.json yanında
│   ├── public/              olduğu gibi kopyalanan dosyalar
│   │   ├── fonts/           siteyle gelen yazı tipleri (Baloo 2, Source Sans 3 — OFL)
│   │   ├── img/             SVG çizimler (kahraman, dükkân, menü simgeleri, 404)
│   │   ├── favicon.svg / favicon.ico / apple-touch-icon.png
│   │   ├── og-kahve-duragi.png   paylaşım kartı görseli (1200×630)
│   │   └── robots.txt
│   └── src/
│       ├── layouts/Layout.astro      <head> etiketleri + ortak iskelet
│       ├── components/               Header, Footer, MenuItem
│       ├── data/                     site.ts (iletişim bilgileri), menu.ts (ürünler ve fiyatlar)
│       ├── pages/                    her dosya bir sayfa (index, menu, hakkimizda, iletisim, tesekkurler, 404)
│       └── styles/global.css         renkler, yazı tipleri, ortak sınıflar
├── asamalar/                ← derslerin ARA HÂLLERİ (her biri tek başına derlenir)
│   ├── 1.3-bos-proje/       `npm create astro` çıktısı (minimal şablon), hiç dokunulmamış
│   ├── 2.1-duzen/           Layout + Header + Footer + ana sayfa; diğer sayfalar “yakında”
│   └── 2.2-icerik/          + menü verisi, MenuItem kartı, Menü ve Hakkımızda sayfaları
├── rapor/                   Lighthouse raporları (./kontrol.sh --lighthouse çalıştırınca oluşur)
├── kontrol.sh               tüm projeleri temiz kurup derler, önizlemeyi ve Lighthouse’u denetler
├── README.md                bu dosya
└── SITE-HARITASI.md         sayfalar, bileşenler, dosyalar — içerik derslerinin sözleşmesi
```

Aşamaların ayrıntısı: [asamalar/README.md](asamalar/README.md).

### 4. Yayına hazırlık (Cloudflare Pages)

Site tamamen **statiktir**: `npm run build` sonrası `dist/` klasörü her statik barındırmada çalışır.
Cloudflare Pages ücretsiz planda şu ayarlarla yayınlanır (bu lab’da **yayın yapılmadı**; adımlar dersler içindir):

| Ayar | Değer |
|---|---|
| Framework preset | Astro |
| Build command | `npm run build` |
| Build output directory | `dist` |
| Ortam değişkeni | `NODE_VERSION` = `22` |

İki yol vardır:

1. **Git ile bağlama:** Projeyi GitHub’a yükleyin (ör. `git init`, `git add .`, `git commit -m "ilk sürüm"`,
   `git push`), Cloudflare panelinde *Workers & Pages → Create → Pages → Connect to Git* ile depoyu seçin.
   Her `git push` sonrası site kendiliğinden yeniden yayınlanır.
2. **Doğrudan yükleme:** `npm run build` sonrası `dist/` klasörünü panelden sürükleyip bırakın ya da
   `npx wrangler pages deploy dist` komutunu kullanın (Cloudflare hesabıyla giriş ister).

Yayından önce değiştirilecek iki yer tutucu:

- `astro.config.mjs` → `site: 'https://kahve-duragi.pages.dev'` → kendi adresiniz
- `public/robots.txt` → `Sitemap:` satırındaki adres

Cloudflare Pages `dist/404.html` dosyasını bulunamayan her adres için kendiliğinden gösterir.

**İletişim formu:** Statik sitenin sunucusu yoktur. Formun `action` adresi (`src/pages/iletisim.astro`
içindeki `FORM_ADRESI`) bir **yer tutucudur**; ders sürümünde gönderim tarayıcıda durdurulur ve teşekkür
mesajı gösterilir, hiçbir veri gönderilmez. Gerçek kullanımda bir form servisi ya da Cloudflare Pages
Functions ile küçük bir uç nokta gerekir.

### 5. Kontrol ve ölçüm

```bash
./kontrol.sh                # 4 projede: temiz npm ci + npm run build → GEÇTİ/KALDI
./kontrol.sh --onizleme     # + astro preview: tüm sayfalar 200, olmayan sayfa 404 mü?
./kontrol.sh --lighthouse   # + Lighthouse 13.5.0 (mobil + masaüstü), rapor/ içine JSON + HTML
```

Son ölçüm (2026-09-25, ana sayfa, `astro preview` üzerinde, Lighthouse 13.5.0, Chromium 153):

| | Performans | Erişilebilirlik | En İyi Uygulamalar | SEO |
|---|---|---|---|---|
| Mobil | 99 | 100 | 100 | 100 |
| Masaüstü | 100 | 100 | 100 | 100 |

(Lighthouse 13.5 ayrıca “Ajan Tabanlı Tarama” kategorisi gösteriyor: 2/2.) Yerel sunucuda ölçüldüğü
için yayındaki puan ağ hızına göre birkaç puan farklı çıkabilir.

### 6. Ders görselleri

Derslerdeki ekran görüntüleri bu sitenin ve gerçek komut çıktılarının çekimidir. Görsel üretim araçları
kurs ekibinde durur; bu depoda yalnız öğrencinin ihtiyaç duyduğu projeler vardır.
