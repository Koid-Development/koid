$(() => {
  let entry = new Audio("./js/sounds/entry.ogg");
  let exit = new Audio("./js/sounds/exit.ogg");
  const title = document.getElementById("title");
  const message = document.getElementById("message");
  const notify = document.getElementsByClassName("container");

  window.addEventListener("message", (event) => {
    const data = event.data.data;

    if (event.data.action === "notification") {
      $.post("http://koid-notify/activeNotification", JSON.stringify(true));
      $(message).html(data.message);
      $(title).html(data.title);

      setTimeout(async () => {
        $(notify).css({
          animation:
            "entryAnimation 1.4s cubic-bezier(0.68, -0.6, 0.32, 1.6) 0s 1 normal both",
        });
        setTimeout(() => {
          entry.volume = 0.2;
          entry.play();
        }, 400);
      }, 100);

      setTimeout(() => {
        $(notify).css({
          animation:
            "exitAnimation 0.8s cubic-bezier(0.36, 0, 0.66, -0.56) 0s 1 normal both",
        });
        exit.volume = 0.2;
        exit.play();
        $.post("http://koid-notify/activeNotification", JSON.stringify(false));
      }, data.duration);
    }
  });
});
