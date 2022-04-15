window.onload = () => {
  window.addEventListener('message', event => {
    var options = event.data
    if (options !== undefined) {
      Notify(options)
    }
  });
};