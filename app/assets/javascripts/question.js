$(document).on('page:load', bindResponseEditing);
$(document).on('ready', bindResponseEditing);

$(document).on('page:load', bindResponseRating);
$(document).on('ready', bindResponseRating);

$(document).on('page:load', bindResponseNavigation);
$(document).on('ready', bindResponseNavigation);

function bindResponseNavigation() {
  if($("ul.options").length > 0) {
    $(".nav-right-active a").click(function(e) {
      var currentGroup = $("ul.options:not(:hidden)");
      if( !currentGroup.is(":last-child")) {
        e.preventDefault();
        currentGroup.hide();
        currentGroup.next().show();
      }
    });

    $(".nav-left-active a").click(function(e) {
      var currentGroup = $("ul.options:not(:hidden)");
      if( !currentGroup.is(":first-child")) {
        e.preventDefault();
        currentGroup.hide();
        currentGroup.prev().show();
      }
    });
  }
}

function bindResponseEditing() {
  bindResponseSelectionEditing();
  bindFreeformEditing();
}

function bindFreeformEditing() {
  $(".option-group textarea").change(function () {
    var box = $(this);
    var data = {question_id: box.parents(".question").data('id'),
                response_option_id: parseInt(box.data('response-option-id')),
                value: box.val()};

    $.ajax({
      type: "POST",
      url: "/response_option_selections",
      data: data,
      dataType: "JSON",
      context: box
    }).done(function(data) {
      this.data('response-option-selection-id', data.id);
    });
  });
}

function bindResponseSelectionEditing() {
  $("input[name='response-options[]']").change(function () {
    var box = $(this);

    if(box.is(':checked')){
      var data = {question_id: box.parents(".question").data('id'),
                  response_option_id: parseInt(box.attr('value'))};

      $.ajax({
        type: "POST",
        url: "/response_option_selections",
        data: data,
        dataType: "JSON",
        context: box
      }).done(function(data) {
        this.data('response-option-selection-id', data.id);
      });
    } else {
      var selection_id = box.data('response-option-selection-id');
      if(selection_id) {
        var data = {_method: "delete"};
        $.ajax({
          type: "POST",
          url: "/response_option_selections/" + selection_id,
          data: data,
          dataType: "JSON",
          context: box
        }).done(function(data) {
          this.data('response-option-selection-id', "");
        });
      }
    }
  });
};

function bindResponseRating() {
  $("input[name='factor-ratings[]']").change(function () {
    var box = $(this);

    if(box.is(':checked')){
      var data = {id: box.data('response-option-selection-id'),
                  rating: box.attr('value')};

      $.ajax({
        type: "POST",
        url: "/factor_ratings",
        data: data,
        dataType: "JSON",
        context: box
      });
    }
  });
};
