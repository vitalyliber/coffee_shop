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


  $('.alert-danger').delay(4000).slideUp();
  $('.alert-success').delay(4000).slideUp();


  $('[data-long-press]').mouseup(function(){
    clearTimeout(pressTimer);
    return false;
  }).mousedown(function(){
    edit_order_path = $(this).attr('data-long-press');
    pressTimer = window.setTimeout(function() {
      window.location.href = edit_order_path
    },700);
    return false;
  });

});