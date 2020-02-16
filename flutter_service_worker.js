'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/index.html": "764466633335ca32c07d47fb1045ff41",
"/manifest.json": "a25a289d9e559469dae80791fb66924c",
"/icons/android-icon-96x96.png": "9edd3a64dc2e66d54461582f7184fb51",
"/icons/apple-icon-60x60.png": "c75b312e3677a984b36f202659bb5d4e",
"/icons/android-icon-192x192.png": "4a96772ccf33e44f2129e97823f07d99",
"/icons/apple-icon-180x180.png": "d2ef5eda92c87a729942e22bd5cc7707",
"/icons/apple-icon-precomposed.png": "be6e6ce6650f49be58ae8c910101a68f",
"/icons/ms-icon-144x144.png": "73537edf94730e69e2235e5e1a472238",
"/icons/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"/icons/android-icon-36x36.png": "6efa398f79d9de8bc984a6de0746b127",
"/icons/android-icon-72x72.png": "1824bc84ec2e2dc0d989ed659b557e19",
"/icons/android-icon-144x144.png": "73537edf94730e69e2235e5e1a472238",
"/icons/apple-icon-144x144.png": "73537edf94730e69e2235e5e1a472238",
"/icons/apple-icon-72x72.png": "1824bc84ec2e2dc0d989ed659b557e19",
"/icons/apple-icon-57x57.png": "f15753986c91a483ec8bbf0fb659cdfc",
"/icons/apple-icon-152x152.png": "236267bbfd3bf29f3d33183b690885e7",
"/icons/ms-icon-150x150.png": "1230af4fd1b8f846a61a87adb254eafc",
"/icons/apple-icon-114x114.png": "504a8ec4718dde46ee72e05780be1b0a",
"/icons/favicon-96x96.png": "9edd3a64dc2e66d54461582f7184fb51",
"/icons/apple-icon-76x76.png": "906ab71c1e2753cbe393dc0c293fe280",
"/icons/apple-icon.png": "be6e6ce6650f49be58ae8c910101a68f",
"/icons/favicon-32x32.png": "a2835f6c489c2d69ad248e9b255b19e4",
"/icons/ms-icon-310x310.png": "34a74c71cf3991c1445af3e33053f0e3",
"/icons/ms-icon-70x70.png": "2b15a60a8d5b10c9cf3d7f42649e91dc",
"/icons/android-icon-48x48.png": "450e2e54dd9249d7120fca67b87ad102",
"/icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"/icons/favicon-16x16.png": "2ba60ec9b1112ee4462fa46af48dbc6f",
"/icons/apple-icon-120x120.png": "31cdebc269ba897420d041f3d1e109a2",
"/icons/favicon.ico": "2850fcb5ef3b5752fa8c2c35a06eb028",
"/assets/assets/images/twitter.png": "3d2099a2710f64ccffba2695a075890a",
"/assets/assets/images/github.png": "472739dfb5857b1f659f4c4c6b4568d0",
"/assets/AssetManifest.json": "6e9976cf4019e754c2d69fc2325f7036",
"/assets/LICENSE": "e5cc1661b7fac549872cf6f8c493fd65",
"/assets/FontManifest.json": "580ff1a5d08679ded8fcf5c6848cece7",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/main.dart.js": "a31b25dffcba5b779669c04ccda4c8c3"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request, {
          credentials: 'include'
        });
      })
  );
});
