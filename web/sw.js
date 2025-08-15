// Toledo Tour - Service Worker for faster loading
const CACHE_NAME = 'toledo-tour-v1.0.0';
const STATIC_CACHE_URLS = [
  '/',
  '/index.html',
  '/fast-start.html',
  '/guia-completa-toledo.html',
  '/privacy-policy.html',
  '/terms-of-service.html',
  '/contact.html',
  '/favicon.png',
  '/icons/Icon-192.png',
  '/icons/Icon-512.png',
  '/manifest.json'
];

// Install event - cache static resources
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('Toledo Tour: Caching static resources');
        return cache.addAll(STATIC_CACHE_URLS);
      })
      .catch((error) => {
        console.log('Toledo Tour: Cache installation failed:', error);
      })
  );
  self.skipWaiting();
});

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            console.log('Toledo Tour: Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  self.clients.claim();
});

// Fetch event - serve from cache with network fallback
self.addEventListener('fetch', (event) => {
  // Skip non-GET requests
  if (event.request.method !== 'GET') {
    return;
  }

  // Skip external resources
  if (!event.request.url.startsWith(self.location.origin)) {
    return;
  }

  event.respondWith(
    caches.match(event.request)
      .then((response) => {
        // Return cached version if available
        if (response) {
          console.log('Toledo Tour: Serving from cache:', event.request.url);
          return response;
        }

        // Otherwise fetch from network
        console.log('Toledo Tour: Fetching from network:', event.request.url);
        return fetch(event.request)
          .then((response) => {
            // Don't cache if not a valid response
            if (!response || response.status !== 200 || response.type !== 'basic') {
              return response;
            }

            // Clone the response
            const responseToCache = response.clone();

            // Add to cache for future use
            caches.open(CACHE_NAME)
              .then((cache) => {
                cache.put(event.request, responseToCache);
              });

            return response;
          })
          .catch((error) => {
            console.log('Toledo Tour: Network fetch failed:', error);
            
            // Return offline fallback for navigation requests
            if (event.request.mode === 'navigate') {
              return caches.match('/fast-start.html');
            }
            
            throw error;
          });
      })
  );
});

// Background sync for offline functionality
self.addEventListener('sync', (event) => {
  if (event.tag === 'toledo-tour-sync') {
    event.waitUntil(
      // Perform background sync operations
      console.log('Toledo Tour: Background sync triggered')
    );
  }
});

// Push notifications (for future use)
self.addEventListener('push', (event) => {
  if (event.data) {
    const data = event.data.json();
    const options = {
      body: data.body || 'Nueva información turística disponible',
      icon: '/icons/Icon-192.png',
      badge: '/icons/Icon-192.png',
      data: data.url || '/',
      actions: [
        {
          action: 'open',
          title: 'Ver más'
        },
        {
          action: 'close',
          title: 'Cerrar'
        }
      ]
    };

    event.waitUntil(
      self.registration.showNotification(data.title || 'Toledo Tour', options)
    );
  }
});

// Notification click handling
self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  if (event.action === 'open') {
    event.waitUntil(
      clients.openWindow(event.notification.data || '/')
    );
  }
});
