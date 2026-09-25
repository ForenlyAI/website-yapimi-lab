# Aşamalar

Her klasör, sitenin o dersin **sonundaki** hâlidir ve tek başına çalışır:

```bash
cd asamalar/2.1-duzen
npm ci          # package-lock.json'daki sürümleri kurar
npm run dev     # http://localhost:4321
```

Bir derste takılırsanız kendi projenizi o dersin klasörüyle karşılaştırın (VS Code: iki dosyayı seçip
sağ tık → “Compare Selected”).

| Klasör | Ders | Durum |
|---|---|---|
| `1.3-bos-proje/` | 1.3 | `npm create astro@latest -- ilk-site --template minimal --no-install --no-git --yes` çıktısı. Tek değişiklik: `package.json`’da `"astro": "^7.3.5"` → `"7.3.5"` (sabit sürüm) ve `npm install` ile oluşan `package-lock.json`. Şablonun kendi `README.md`, `AGENTS.md`, `CLAUDE.md` dosyaları olduğu gibi duruyor. |
| `2.1-duzen/` | 2.1 | Ortak düzen: `Layout.astro` (sade `<head>`: title, description, favicon), `Header.astro` (telefonda açılır menü), `Footer.astro`, `global.css`, siteyle gelen yazı tipleri, `data/site.ts`. Ana sayfada yalnız karşılama bölümü var; Menü, Hakkımızda, İletişim “yakında” sayfası. |
| `2.2-icerik/` | 2.2 | İçerik: `data/menu.ts` (10 ürün, TL fiyat), `MenuItem.astro` kartı, dolu Menü ve Hakkımızda sayfaları, ana sayfanın tamamı (“Neden biz?”, öne çıkanlar, saatler). İletişim hâlâ “yakında”. |
| `../kahve-duragi/` | 2.3 → 3.x | Bitmiş site: iletişim formu + teşekkür durumu, 404, Teşekkürler sayfası, paylaşım (og) etiketleri, favicon seti, `robots.txt`, site haritası. |

Aşamalar arası farkların tam listesi: [../SITE-HARITASI.md](../SITE-HARITASI.md) → “Aşamalar”.
