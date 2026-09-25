# Yapay zekâ taslağı ve doğrulaması (Ders 2.3)

- `istem.txt` — yapay zekâya verilen istem (yalnız src/data/site.ts'teki bilgiler; kişisel veri, parola, anahtar yok)
- `taslak.md` — yapay zekânın ham taslağı (bu ders için bir yapay zekâ modeliyle üretildi; olduğu gibi saklanır)
- `duzeltilmis.md` — her iddia site.ts ve ana sayfayla karşılaştırıldıktan sonra kalan metin
- `YZ-KONTROL.md` — doğrulama kontrol listesi

Farkı görmek için: `diff -u taslak.md duzeltilmis.md`
Bu klasör siteye derlenmez (src/ dışında); Hakkımızda sayfasının kendisi değiştirilmedi.
