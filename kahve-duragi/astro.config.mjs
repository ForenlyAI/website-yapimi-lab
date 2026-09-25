// @ts-check
import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

// `site`: sitenin yayındaki tam adresi. sitemap.xml ve og:url bu adresle üretilir.
// Buradaki adres ÖRNEKTİR — kendi Cloudflare Pages adresinizi (ör. https://proje-adi.pages.dev)
// ya da kendi alan adınızı yazın.
export default defineConfig({
  site: 'https://kahve-duragi.pages.dev',
  trailingSlash: 'ignore',
  integrations: [
    sitemap({
      // Teşekkür sayfası arama motorlarına gösterilmez.
      filter: (sayfa) => !sayfa.includes('/tesekkurler'),
    }),
  ],
});
