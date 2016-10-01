document.addEventListener("turbolinks:load", function() {
  $('[data-modal-confirm]').click(function (event) {
    event.preventDefault();

    modalConfirmData = {
      title: $(this).attr('data-modal-confirm'),
      href: $(this).attr('href'),
      data_method: $(this).attr('data-method') || 'get'
    };

    $('#confirmAction').attr('data-method', `${modalConfirmData.data_method}`);
    $('#confirmAction').attr('href', `${modalConfirmData.href}`);

    $('#modalConfirm .modal-title').replaceWith(`<h4 class="modal-title">${modalConfirmData.title}</h4>`);

    $('#modalConfirm').modal();

    event.stopImmediatePropagation();
  });

  $('#modalConfirm').on('hidden.bs.modal', function () {
    $('#confirmAction').attr('data-method', null);
    $('#confirmAction').attr('href', null);
  });
});