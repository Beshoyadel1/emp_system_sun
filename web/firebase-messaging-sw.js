const pendingClicks = new Map();
// Register before Firebase installs its own notification click handler.
self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  event.stopImmediatePropagation();
  const raw = event.notification.data || {};
  const payload = raw.FCM_MSG || raw;
  event.waitUntil((async () => {
    const clientList = await clients.matchAll({ type: 'window', includeUncontrolled: true });
    const scope = new URL('./', self.location.href).href;
    let client = clientList.find((item) => item.url.startsWith(scope));
    if (client) await client.focus();
    else client = await clients.openWindow(scope);
    if (!client) return;
    pendingClicks.set(client.id, payload);
    client.postMessage({ type: 'SUN_NOTIFICATION_CLICK', payload });
  })());
});
self.addEventListener('message', (event) => {
  const id = event.source?.id;
  if (event.data?.type === 'SUN_NOTIFICATION_ACK') pendingClicks.delete(id);
  if (event.data?.type === 'SUN_NOTIFICATION_READY' && pendingClicks.has(id)) {
    event.source.postMessage({ type: 'SUN_NOTIFICATION_CLICK', payload: pendingClicks.get(id) });
  }
});

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
    data: payload,
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
