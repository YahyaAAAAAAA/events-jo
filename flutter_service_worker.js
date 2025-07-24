'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "d0175dbe983470feb7504fd35dc4c1d1",
"assets/AssetManifest.bin.json": "741520ac6e96af1244a37bbbea6da01a",
"assets/AssetManifest.json": "86cb773f6f639bec06f4345bcbbd0358",
"assets/assets/animations/approve.json": "cf26ccb61ece5bb6a2a2a9c6e9ab78b3",
"assets/assets/animations/ban.json": "232de0f7864b69b579b145f73f29fadb",
"assets/assets/animations/dashboard_1.json": "715b505b934283b44478a068068336e5",
"assets/assets/animations/dashboard_2.json": "3bdadd26430ee21a6e2cb8422c20b9e3",
"assets/assets/animations/delete.json": "a8c51dd6956450b897e05981ba1e1ea4",
"assets/assets/animations/image.json": "853e75a06beccf58c6da21e9e7cf5cca",
"assets/assets/animations/loading.json": "93f2d533a865569d410336e680b01001",
"assets/assets/animations/loading_admin.json": "dc5d310b17afc7c58769f1b90532ebe5",
"assets/assets/animations/location_loading.json": "99a69bdcf91292f3d364431fba5700d1",
"assets/assets/fonts/Abel-Regular.ttf": "1052d6ca3993ae24a932304560a4c8b4",
"assets/assets/fonts/Baskervville-Regular.ttf": "0dc261498ffe8a08b08e0bd1d08f3217",
"assets/assets/fonts/CustomIcons.ttf": "0aac05be14da6e740e3fd534cb88c0e9",
"assets/assets/fonts/Gugi-Regular.ttf": "d215cc8654cb6b434182cc9150415cc0",
"assets/assets/git_images/empty.png": "12bf05496bceb44acd6416970134910f",
"assets/assets/git_images/empty_logo.png": "8fac7ac9171884d94848c04296aeb730",
"assets/FontManifest.json": "ba0ccdc4674f59c9830ad1e275bb1670",
"assets/fonts/MaterialIcons-Regular.otf": "71968e8b7692d708187541ff0792ea97",
"assets/NOTICES": "b3a3f30ba9446abe28e4f2112792033a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.ico": "ba1201ed787aa4ccfe84ae2c571e7621",
"favicon.png": "055b0b3b26a7bba8cb0257d44a32923d",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "13895917074b80b1bc960e011dffcf5c",
"icons/icon-192-maskable.png": "e0e44986567c13613cb1c18c7f2e1793",
"icons/Icon-192.png": "fb2f5a726880921485fd74c5f3c4a4d3",
"icons/icon-512-maskable.png": "63832386734ed6c37f8e21a835c7ad5b",
"icons/Icon-512.png": "fa285350c37b7fbcdec3f35346202f63",
"index.html": "6ff71ab82a7c703e59ff90b133eb3ad2",
"/": "6ff71ab82a7c703e59ff90b133eb3ad2",
"main.dart.js": "489f412642d5e8bc9d1584b24e6d54cd",
"manifest.json": "95ae0000b741362ec88cb206df893544",
"splash/img/dark-1x.png": "984460ae1e946d26276274a96fc33475",
"splash/img/dark-2x.png": "0de85856628ed26c2f536c4b8543406f",
"splash/img/dark-3x.png": "7501c3b56d45a1c7a664a14f7e1ecd1a",
"splash/img/dark-4x.png": "aaef5cf76b70840335573b6423313ba1",
"splash/img/light-1x.png": "984460ae1e946d26276274a96fc33475",
"splash/img/light-2x.png": "0de85856628ed26c2f536c4b8543406f",
"splash/img/light-3x.png": "7501c3b56d45a1c7a664a14f7e1ecd1a",
"splash/img/light-4x.png": "aaef5cf76b70840335573b6423313ba1",
"splash/img/light-background.png": "12bf05496bceb44acd6416970134910f",
"version.json": "7446e3dbffdc378af8b8927613870e35"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
