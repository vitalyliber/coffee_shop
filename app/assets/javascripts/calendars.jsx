document.addEventListener("turbolinks:load", function() {
  $('.time').each(function() {
    DateUtc = moment.utc( $(this).attr('val') );
    localDate = moment(DateUtc).local();
    this.textContent = localDate.format('HH:mm:ss');
  });

  $('.datetime').each(function() {
    DateUtc = moment.utc( $(this).attr('val') );
    localDate = moment(DateUtc).local();
    this.textContent = localDate.format('D.MM HH:mm');
  });
});