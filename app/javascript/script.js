console.log("hello");
window.checkForm = function (form) {
	// console.log(form["user[password]"].value);
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

document.addEventListener("click", (event) => {
	const clickedElement = event.target.closest(".heart_icon");
  const loggedInUser = document.querySelector("#logged-in")
	if (clickedElement && loggedInUser) {
		clickedElement.classList.toggle("liked");
const id = clickedElement.getAttribute("data-activity-id");
		  fetch(`/activities/${id}`).then(response => response.json()).then(data => {
      console.log(data);
      document.q
		  // fetch(`/activities/${id}`).then((response) => response.text()).then(data => {
      // clickedElement.parentNode.children[1].innerHTML = data
    })
  }
	});


