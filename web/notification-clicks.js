// Receive clicks before Flutter/authentication finishes mounting.
(() => {
  let callback = null;
  const pendingMessages = [];
  const storageKey = 'sun.pendingNotificationClick';
  let pending = null;
  try { pending = JSON.parse(sessionStorage.getItem(storageKey) || 'null'); } catch (_) {}
  const deliver = () => {
    if (!callback || !pending) return;
    const payload = pending;
    pending = null;
    try { sessionStorage.removeItem(storageKey); } catch (_) {}
    callback(JSON.stringify({ ...payload, sunOpened: true }));
  };

  function waitForActiveWorker(registration) {
    const worker = registration.active ?? registration.installing ?? registration.waiting;
    if (!worker) throw new Error('FCM service worker is missing');
    return new Promise((resolve, reject) => {
      function checkState() {
        if (worker.state === 'activated') finish();
        else if (worker.state === 'redundant') finish(new Error('FCM service worker installation failed'));
      }
      function finish(error) {
        clearTimeout(timer);
        worker.removeEventListener('statechange', checkState);
        if (error) reject(error);
        else resolve();
      }
      const timer = setTimeout(() => finish(new Error('FCM service worker activation timed out')), 12000);
      worker.addEventListener('statechange', checkState);
      checkState();
    });
  }

  let workerReady;
  const workerPath = '/firebase-messaging-sw.js';
  window.prepareSunFcmWorker = async () => {
    if (!('serviceWorker' in navigator)) throw new Error('Service workers are unavailable');
    // Match the default Firebase Web SDK registration used by getToken().
    workerReady ??= navigator.serviceWorker.register(workerPath, {
      scope: '/firebase-cloud-messaging-push-scope',
    }).then(waitForActiveWorker).catch((error) => {
      workerReady = null;
      throw error;
    });
    await workerReady;
  };

  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.addEventListener('message', (event) => {
      if (event.data?.type === 'SUN_NOTIFICATION_RECEIVED') {
        const payload = { ...event.data.payload, sunOpened: false };
        if (callback) callback(JSON.stringify(payload));
        else {
          pendingMessages.push(payload);
          if (pendingMessages.length > 100) pendingMessages.shift();
        }
        return;
      }
      if (event.data?.type !== 'SUN_NOTIFICATION_CLICK') return;
      pending = event.data.payload;
      try { sessionStorage.setItem(storageKey, JSON.stringify(pending)); } catch (_) {}
      event.source?.postMessage({ type: 'SUN_NOTIFICATION_ACK' });
      deliver();
    });
    const workerUrl = new URL(workerPath, window.location.href).href;
    window.prepareSunFcmWorker()
      .then(() => navigator.serviceWorker.getRegistrations())
      .then((registrations) => {
        for (const registration of registrations) {
          if (registration.active?.scriptURL === workerUrl) {
            registration.active.postMessage({ type: 'SUN_NOTIFICATION_READY' });
          }
        }
      })
      .catch((error) => console.warn('[FCM] service worker startup failed', error));
  }
  window.listenForSunNotificationClicks = (onClick) => {
    callback = onClick;
    for (const payload of pendingMessages.splice(0)) callback(JSON.stringify(payload));
    deliver();
    return () => {
      callback = null;
      pendingMessages.length = 0;
      pending = null;
      try { sessionStorage.removeItem(storageKey); } catch (_) {}
    };
  };
})();
