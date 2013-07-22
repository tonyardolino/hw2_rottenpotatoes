RP = {};
RP.setup = function() {
    // construct new DOM elements
    $('<label for="filter" class="explanation">' +
      'Restrict to movies suitable for children' +
      '</label>' +
      '<input type="checkbox" id="filter"/>'
    ).insertBefore('#movies').change(RP.filter_adult);
};
RP.filter_adult = function () {
    // 'this' is element that received event (checkbox)
    if ($(this).is(':checked')) {
      $('#movies tbody tr.adult').hide();
    } else {
      $('#movies tbody tr').show();
    };
};
$(RP.setup);       // when document ready, run setup code
