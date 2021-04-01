console.log("hello");
window.checkForm = function(form) {
	if (form.user[password].value !== form.user[password_confirmation].value) {
		alert("Error: Passwords do not match!");
		form.user[password].focus();
		return false;
	}
}