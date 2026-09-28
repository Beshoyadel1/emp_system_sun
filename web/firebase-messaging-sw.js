importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

if (!firebase.apps.length) {
  firebase.initializeApp({
    apiKey: "AIzaSyB8Lixy-XF0V_UCTGCzUz0AEBzLgIP-7ik",
    appId: "1:567407553652:web:d510db5fa139b829b7b521",
    messagingSenderId: "567407553652",
    projectId: "sun-app-6c6af",
    authDomain: "sun-app-6c6af.firebaseapp.com",
    storageBucket: "sun-app-6c6af.firebasestorage.app",
    measurementId: "G-R3BVP1XBXZ",
  });
}

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log("[firebase-messaging-sw.js] Received background message for Employee: ", payload);

  if (payload.notification && (payload.notification.title || payload.notification.body)) {
    return;
  }

  const notificationTitle =
      payload.data?.title || payload.data?.latintitle || "San Employee System";
  const notificationOptions = {
    body:
        payload.data?.body ||
        payload.data?.description ||
        payload.data?.message ||
        "",
    icon: "/favicon.png",
    data: payload.data,
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});

self.addEventListener("notificationclick", (event) => {
  event.notification.close();
  event.waitUntil(
    clients
      .matchAll({ type: "window", includeUncontrolled: true })
      .then((clientList) => {
        for (const client of clientList) {
          if (client.url && "focus" in client) {
            return client.focus();
          }
        }
        if (clients.openWindow) {
          return clients.openWindow("/");
        }
      })
  );
});
