$(document).on('page:load', bindResponseNavigation);
$(document).on('ready', bindResponseNavigation);

function bindResponseNavigation() {
  $(".nav-right-active a").click(function(e) {
    if($("ul.options").length > 0) {
      var currentGroup = $("ul.options:not(:hidden)");
      if( !currentGroup.is(":last-child")) {
        e.preventDefault();
        currentGroup.hide();
        currentGroup.next().show();
      }
    } else if($("input.sectionCode").length > 0) {
      if($("input.sectionCode").val() != $(".current-step.section").data('section-code') ) {
        e.preventDefault();
        alert("Please enter the correct code to continue");
        $("input.sectionCode").addClass("error");
      }
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
