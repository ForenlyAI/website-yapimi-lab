// Kafenin iletişim bilgileri tek yerde durur; Header, Footer ve sayfalar buradan okur.
// Tüm bilgiler KURGUSALDIR (ders örneği): telefon ve e-posta gerçek değildir.
export const SITE = {
  ad: 'Kahve Durağı',
  slogan: 'Odunpazarı’nda mahalle kahvecisi',
  aciklama:
    'Kahve Durağı, Eskişehir’de taze kavrulmuş kahve, ev yapımı tatlılar ve sakin bir mola sunan küçük bir mahalle kafesidir.',
  telefon: '0222 000 00 00',
  telefonLink: 'tel:+902220000000',
  eposta: 'merhaba@example.com',
  adres: 'Örnek Sokak No: 1, Odunpazarı / Eskişehir',
  saatler: [
    { gun: 'Pazartesi – Cuma', saat: '08:00 – 20:00' },
    { gun: 'Cumartesi', saat: '09:00 – 21:00' },
    { gun: 'Pazar', saat: '10:00 – 18:00' },
  ],
};

export const MENU_LINKLERI = [
  { href: '/', ad: 'Ana Sayfa' },
  { href: '/menu/', ad: 'Menü' },
  { href: '/hakkimizda/', ad: 'Hakkımızda' },
  { href: '/iletisim/', ad: 'İletişim' },
];
