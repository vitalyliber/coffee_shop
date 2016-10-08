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

});