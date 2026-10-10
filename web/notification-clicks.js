// Receive clicks before Flutter/authentication finishes mounting.
(() => {
  let callback = null;
  const storageKey = 'sun.pendingNotificationClick';
  let pending = null;
  try { pending = JSON.parse(sessionStorage.getItem(storageKey) || 'null'); } catch (_) {}
  const deliver = () => {
    if (!callback || !pending) return;
    const payload = pending;
    pending = null;
    try { sessionStorage.removeItem(storageKey); } catch (_) {}
    callback(JSON.stringify(payload));
  };
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.addEventListener('message', (event) => {
      if (event.data?.type !== 'SUN_NOTIFICATION_CLICK') return;
      pending = event.data.payload;
      try { sessionStorage.setItem(storageKey, JSON.stringify(pending)); } catch (_) {}
      event.source?.postMessage({ type: 'SUN_NOTIFICATION_ACK' });
      deliver();
    });
    navigator.serviceWorker.ready.then(() => navigator.serviceWorker.getRegistrations()).then((registrations) => {
      for (const registration of registrations) {
        registration.active?.postMessage({ type: 'SUN_NOTIFICATION_READY' });
      }
    });
  }
  window.listenForSunNotificationClicks = (onClick) => {
    callback = onClick;
    deliver();
    return () => {
      callback = null;
      pending = null;
      try { sessionStorage.removeItem(storageKey); } catch (_) {}
    };
  };
})();
