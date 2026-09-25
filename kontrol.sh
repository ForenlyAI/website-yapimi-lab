#!/usr/bin/env bash
# Website Yapımı 101 — lab kontrolü.
#
#   ./kontrol.sh                 her projede temiz kurulum (npm ci) + npm run build → GEÇTİ/KALDI
#   ./kontrol.sh --onizleme      + son sitede `astro preview` açıp her sayfanın HTTP kodunu denetler
#   ./kontrol.sh --lighthouse    + son sitede Lighthouse (mobil + masaüstü) çalıştırır, rapor/ içine yazar
#
# Hiçbir yere yayın yapmaz; yalnız bu bilgisayarda çalışır.
set -u
cd "$(dirname "$0")"
LAB="$(pwd)"

# Astro 7, bir yapay zekâ ajanının içinden çalıştığını anlarsa dev sunucusunu arka plana atar.
# Öğrencinin terminalindeki davranışı görmek için bu değişkenleri temizliyoruz.
for d in $(env | grep -oE '^(AI_AGENT|AGENT|CLAUDECODE|CLAUDE_[A-Z_]*|CODEX_[A-Z_]*|GEMINI_CLI|CURSOR_TRACE_ID)='); do
  unset "${d%=}"
done

PROJELER=(asamalar/1.3-bos-proje asamalar/2.1-duzen asamalar/2.2-icerik kahve-duragi)
ONIZLEME=0; LIGHTHOUSE=0
for a in "$@"; do
  case "$a" in
    --onizleme) ONIZLEME=1 ;;
    --lighthouse) LIGHTHOUSE=1; ONIZLEME=1 ;;
    *) echo "bilinmeyen seçenek: $a"; exit 2 ;;
  esac
done

HATA=0
GECICI="$LAB/.kontrol-gecici"; mkdir -p "$GECICI"; trap 'rm -rf "$GECICI"' EXIT
sonuc() { printf '%-28s %-22s %s\n' "$1" "$2" "$3"; }

echo "node $(node -v) · npm $(npm -v)"
echo
for p in "${PROJELER[@]}"; do
  (cd "$p" && rm -rf node_modules dist .astro && npm ci --no-audit --no-fund >"$GECICI/ci.log" 2>&1)
  if [ $? -ne 0 ]; then sonuc "$p" "npm ci" "KALDI"; tail -5 "$GECICI/ci.log"; HATA=1; continue; fi
  cikti=$(cd "$p" && npm run build 2>&1)
  if [ $? -eq 0 ]; then
    sonuc "$p" "npm run build" "GEÇTİ ($(echo "$cikti" | grep -oE '[0-9]+ page\(s\) built' | grep -oE '^[0-9]+') sayfa)"
  else
    sonuc "$p" "npm run build" "KALDI"; echo "$cikti" | tail -15; HATA=1
  fi
done
rm -f "$GECICI/ci.log"

if [ "$ONIZLEME" = 1 ]; then
  echo
  PORT=4321
  setsid bash -c "cd kahve-duragi && exec npx astro preview --port $PORT" >"$GECICI/preview.log" 2>&1 &
  SUNUCU=$!
  for _ in $(seq 1 50); do curl -s -o /dev/null "http://localhost:$PORT/" && break; sleep 0.2; done
  for yol in / /menu/ /hakkimizda/ /iletisim/ /tesekkurler/ /robots.txt /sitemap-index.xml /sitemap-0.xml \
             /favicon.svg /favicon.ico /og-kahve-duragi.png /olmayan-sayfa/; do
    kod=$(curl -s -o /dev/null -w '%{http_code}' "http://localhost:$PORT$yol")
    beklenen=200; [ "$yol" = /olmayan-sayfa/ ] && beklenen=404
    if [ "$kod" = "$beklenen" ]; then sonuc "preview $yol" "HTTP $kod" "GEÇTİ"; else sonuc "preview $yol" "HTTP $kod" "KALDI (beklenen $beklenen)"; HATA=1; fi
  done

  if [ "$LIGHTHOUSE" = 1 ]; then
    echo
    mkdir -p rapor
    CHROME_PATH="${CHROME_PATH:-$(ls -d "$HOME"/.cache/ms-playwright/chromium-*/chrome-linux64/chrome 2>/dev/null | sort -V | tail -1)}"
    export CHROME_PATH
    for bicim in mobil masaustu; do
      ek=""; [ "$bicim" = masaustu ] && ek="--preset=desktop"
      npx -y lighthouse@13.5.0 "http://localhost:$PORT/" $ek --quiet \
        --chrome-flags="--headless=new --no-sandbox" --locale=tr \
        --output=json --output=html --output-path="rapor/lighthouse-$bicim" >"$GECICI/lh.log" 2>&1
      if [ -f "rapor/lighthouse-$bicim.report.json" ]; then
        puan=$(node -e "const r=require('./rapor/lighthouse-$bicim.report.json');console.log(Object.values(r.categories).map(k=>k.title+' '+Math.round(k.score*100)).join(' · '))")
        sonuc "lighthouse $bicim" "ana sayfa" "$puan"
      else
        sonuc "lighthouse $bicim" "ana sayfa" "ÇALIŞMADI"; tail -5 "$GECICI/lh.log"; HATA=1
      fi
    done
    rm -f "$GECICI/lh.log"
  fi
  kill -- -"$SUNUCU" 2>/dev/null; wait "$SUNUCU" 2>/dev/null
  rm -f "$GECICI/preview.log"
fi

echo
if [ "$HATA" = 0 ]; then echo "SONUÇ: GEÇTİ"; else echo "SONUÇ: KALDI"; fi
exit $HATA
