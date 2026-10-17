const CACHE = 'nexopol-app-v1';
const STATIC = ["./", "./index.html", "./config.js", "./manifest.webmanifest", "./assets/styles.css", "./assets/images.js", "./assets/app.js", "./assets/logo-flor.svg", "./assets/icon-192.png", "./assets/icon-512.png", "./assets/abejas.webp", "./assets/agua_practice.webp", "./assets/colibries.webp", "./assets/community.webp", "./assets/escarabajos.webp", "./assets/flores.webp", "./assets/galletas.webp", "./assets/girasol.webp", "./assets/granola.webp", "./assets/hero.webp", "./assets/manta_photo.webp", "./assets/mariposas.webp", "./assets/miel.webp", "./assets/moscas.webp", "./assets/murcielagos.webp", "./assets/paisaje.webp", "./assets/pastel.webp", "./assets/pradera_photo.webp", "./assets/refugio_practice.webp", "./assets/velas.webp", "./assets/vinagre.webp"];
self.addEventListener('install', event => {
  event.waitUntil(caches.open(CACHE).then(cache=>cache.addAll(STATIC)).then(()=>self.skipWaiting()));
});
self.addEventListener('activate', event => {
  event.waitUntil(caches.keys().then(keys => Promise.all(keys.filter(k=>k!==CACHE).map(k=>caches.delete(k)))).then(()=>self.clients.claim()));
});
self.addEventListener('fetch', event => {
  const req = event.request;
  if (req.method!=='GET') return;
  const url = new URL(req.url);
  if (url.origin!==self.location.origin) return; // Supabase/CDN no se interceptan.
  if (req.mode==='navigate') {
    event.respondWith(fetch(req).then(resp=>resp).catch(()=>caches.match('./index.html')));
  } else {
    event.respondWith(caches.match(req).then(resp=>resp||fetch(req)));
  }
});
