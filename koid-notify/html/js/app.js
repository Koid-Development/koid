$(() => {
  let sound = new Audio("./js/notify-sound.mp3");
  const title = document.getElementById("title");
  const message = document.getElementById("message");
  const notify = document.getElementsByClassName("container");

  $(notify).css({ opacity: "0" });

  window.addEventListener("message", (event) => {
    const data = event.data;

    if (data.action === "notification") {
      $.post("http://koid-notify/activeNotification", JSON.stringify(true));
      $(message).html(data.message || "No message provided");
      $(title).html(data.title || "INFORMATION");

      setTimeout(async () => {
        $(notify).css({
          animation:
            "myAnim 1.4s cubic-bezier(0.68, -0.6, 0.32, 1.6) 0s 1 normal both",
          opacity: "1",
        });
        sound.play();
      }, 100);

      setTimeout(async () => {
        $(notify).css({ top: "-25%", opacity: "0" });
        $.post("http://koid-notify/activeNotification", JSON.stringify(false));
      }, data.timeout);
    }
  });
});
