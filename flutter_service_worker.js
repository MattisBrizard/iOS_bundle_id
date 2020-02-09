'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/index.html": "7533ead3b776be52e7b97b51199c7598",
"/manifest.json": "a25a289d9e559469dae80791fb66924c",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/assets/assets/images/twitter.png": "3d2099a2710f64ccffba2695a075890a",
"/assets/assets/images/bmc.png": "076ce920fe95d3c54dc1c00c6a1d74ad",
"/assets/AssetManifest.json": "1c064e9c276aa3b4c28d97c20fc592d7",
"/assets/LICENSE": "63e03e4ce5f13798a57ad0022c0e459a",
"/assets/FontManifest.json": "580ff1a5d08679ded8fcf5c6848cece7",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/main.dart.js": "a708960768b0a65d76e4964f3f81a1fa"
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
