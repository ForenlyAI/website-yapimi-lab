// Menüdeki her ürün bir nesnedir. Yeni ürün eklemek için ilgili kategoriye bir satır ekleyin.
// Fiyatlar Türk lirası (TL) cinsindendir ve örnektir.
export type Urun = {
  ad: string;
  aciklama: string;
  fiyat: number;
  gorsel: string;
  etiket?: string;
};

export type Kategori = {
  id: string;
  baslik: string;
  urunler: Urun[];
};

export const MENU: Kategori[] = [
  {
    id: 'sicak',
    baslik: 'Sıcak Kahveler',
    urunler: [
      { ad: 'Espresso', aciklama: 'Tek shot, yoğun ve kısa.', fiyat: 70, gorsel: '/img/espresso.svg' },
      { ad: 'Americano', aciklama: 'Espresso ve sıcak su, sade içim.', fiyat: 85, gorsel: '/img/espresso.svg' },
      { ad: 'Latte', aciklama: 'Espresso, buharda ısıtılmış süt, ince köpük.', fiyat: 105, gorsel: '/img/latte.svg', etiket: 'Çok sevilen' },
      { ad: 'Türk Kahvesi', aciklama: 'Közde pişmiş, yanında lokum ile.', fiyat: 80, gorsel: '/img/turk-kahvesi.svg' },
    ],
  },
  {
    id: 'soguk',
    baslik: 'Soğuk İçecekler',
    urunler: [
      { ad: 'Soğuk Demleme', aciklama: '16 saat soğukta demlenmiş, buzlu.', fiyat: 115, gorsel: '/img/soguk-kahve.svg', etiket: 'Yeni' },
      { ad: 'Buzlu Latte', aciklama: 'Espresso, soğuk süt ve buz.', fiyat: 110, gorsel: '/img/soguk-kahve.svg' },
      { ad: 'Ev Yapımı Limonata', aciklama: 'Taze limon ve nane.', fiyat: 90, gorsel: '/img/limonata.svg' },
    ],
  },
  {
    id: 'tatli',
    baslik: 'Tatlılar ve Atıştırmalıklar',
    urunler: [
      { ad: 'Cheesecake', aciklama: 'Günlük, frambuaz soslu.', fiyat: 140, gorsel: '/img/pasta.svg' },
      { ad: 'Havuçlu Kek', aciklama: 'Tarçınlı, cevizli dilim.', fiyat: 95, gorsel: '/img/pasta.svg' },
      { ad: 'Peynirli Poğaça', aciklama: 'Her sabah fırından.', fiyat: 45, gorsel: '/img/pogaca.svg' },
    ],
  },
];

// 105 → "105 TL" (Türkçe sayı biçimiyle)
export function fiyatYaz(fiyat: number): string {
  return `${fiyat.toLocaleString('tr-TR')} TL`;
}
