$(document).on('page:load', bindLoginForm);
$(document).on('ready', bindLoginForm);

function bindLoginForm() {
  $(".login-header img").click(function(e) {
    $(".login-form").fadeIn();
  });
}
