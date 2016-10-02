document.addEventListener("turbolinks:load", function() {
  $('.time').each(function() {
    DateUtc = moment.utc( $(this).attr('val') );
    localDate = moment(DateUtc).local();
    this.textContent = localDate.format('HH:mm');
  });

  $('.datetime').each(function() {
    DateUtc = moment.utc( $(this).attr('val') );
    localDate = moment(DateUtc).local();
    this.textContent = localDate.format('D.MM HH:mm');
  });


  $('.alert-danger').delay(4000).slideUp();
  $('.alert-success').delay(4000).slideUp();

  activate_edit_point = false;
  $('#activate-edit-point').click(function () {

    if (activate_edit_point == false) {
      activate_edit_point = true;
      $('.edit-point').show();
      $('.set-point').hide();
    } else {
      activate_edit_point = false;
      $('.edit-point').hide();
      $('.set-point').show();
    }

  })

});