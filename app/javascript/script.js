
//check and warn user if password doesn't match with confirmation
window.checkForm = function (form) {
  if (
    form["user[password]"].value !== form["user[password_confirmation]"].value
  ) {
    alert("Error: Passwords do not match!");
    form["user[password]"].value = "";
    form["user[password_confirmation]"].value = "";
    form["user[password]"].focus();
    return false;
  }
};

document.addEventListener("click", updateHeartCount);

function updateHeartCount(event) {
  const loggedIn = document.querySelector("#logged-in");
  if (loggedIn) {
    const clickedElement = event.target.closest(".heart_icon");

    if (clickedElement && !clickedElement.classList.contains("liked")) {
      const id = clickedElement.getAttribute("data-activity-id");
      fetch(`/activities/${id}`)
        .then((response) => response.json())
        .then((data) => {
          const heartCount = document.querySelector(`#heart-count-${id}`);
          heartCount.innerText = data.heart_count;
          clickedElement.classList.add("liked");
          heartCount.classList.add("bold");
        });
    }
  }
}
