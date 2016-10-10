$(function () {
  if ($('#champions-show').length > 0) {
    championsShow();
  }

  function championsShow() {
    var $itemShow = $('#item-show');

    $('a.item').on('click', function (event) {
      event.preventDefault();

      var url = this.href;

      $('#items-show').load(url);
    });
  }
})
