$(document).on('page:load', bindResponseEditing);
$(document).on('ready', bindResponseEditing);

$(document).on('page:load', bindResponseRating);
$(document).on('ready', bindResponseRating);

function bindResponseEditing() {
  bindResponseSelectionEditing();
  bindFreeformEditing();
  bindThoughtsEditing();
  bindResponseOptionSelectionSelection();
  bindAdmireEditing();
  bindUserCareerEditing();
  bindUserFactorEditing();
  bindUserCareerFactorResponseRating();
  bindTieBreakerRating();
}

function bindResponseOptionSelectionSelection() {
  $("input[name='response-option-selections[]']").change(function () {
    var box = $(this);
    var data = {selected: box.is(':checked')};

    $.ajax({
      type: "PUT",
      url: "/response_option_selections/" + box.attr('value'),
      data: data,
      dataType: "JSON"
    });
  });
}


function bindThoughtsEditing() {

  function saveThought(moodThought) {
    var box = moodThought.children("textarea");
    var data = {question_id: moodThought.parents(".question").data('id'),
                response_option_id: moodThought.data('response-option-id'),
                data: {value: box.val(),
                       supportive: moodThought.find("input[value='supportive']").is(':checked'),
                       negative: !moodThought.find("input[value='supportive']").is(':checked')}};

    $.ajax({
      type: "POST",
      url: "/response_option_selections",
      data: data,
      dataType: "JSON"
    });
  }

  $(".mood-thought textarea").change(function () {
    saveThought($(this).parents(".mood-thought"));
  });
  $(".mood-thought input").change(function () {
    saveThought($(this).parents(".mood-thought"));
  });
}

function bindAdmireEditing() {
  $(".admire-group input[type='text']").change(function () {
    var box = $(this);
    var data = {question_id: box.parents(".question").data('id'),
                response_option_id: parseInt(box.data('response-option-id')),
                data: {
                  who: box.parents("li").find("input[name='who']").val(),
                  why: box.parents("li").find("input[name='why']").val()
                }};

    $.ajax({
      type: "POST",
      url: "/response_option_selections",
      data: data,
      dataType: "JSON",
    });
  });
}

function bindUserCareerEditing() {
  $(".user-careers input[type='text']").change(function () {
    var box = $(this);
    var careerId = parseInt(box.data('user-career-id'));
    var data = {name: box.val()};

    $.ajax({
      type: "PUT",
      url: "/user_careers/" + careerId,
      data: data,
      dataType: "JSON",
    });
  });
}

function bindUserFactorEditing() {
  $(".custom-cheetah-factors input[type='text']").change(function () {
    var box = $(this);
    var factorId = parseInt(box.data('cheetah-factor-id'));
    var data = {custom_name: box.val()};

    $.ajax({
      type: "PUT",
      url: "/cheetah_factors/" + factorId,
      data: data,
      dataType: "JSON",
    });
  });
}

function bindFreeformEditing() {
  function saveFreeFormText(box) {
    var data = {question_id: box.parents(".question").data('id'),
                response_option_id: parseInt(box.data('response-option-id')),
                data: {value: box.val()}};

    $.ajax({
      type: "POST",
      url: "/response_option_selections",
      data: data,
      dataType: "JSON",
      context: box
    });
  };

  $(".skills-group input[type='text']").change(function () {
    saveFreeFormText($(this));
  });

  $(".option-group textarea").change(function () {
    saveFreeFormText($(this));
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


function bindTieBreakerRating() {
  $("input[name='tbreaker-cheetah-factor-rankings[]']").change(function () {
    var box = $(this);
    var newRating = parseInt(box.attr("value"));

    if(box.is(':checked')){
      var data = {id: box.data('cheetah-factor-id'),
                  repeat: box.data('repeat'),
                  rating: box.attr('value')};

      $.ajax({
        type: "POST",
        url: "/cheetah_factor_rankings",
        data: data,
        dataType: "JSON",
        context: box
      });
    }
  })
}

function bindResponseRating() {
  $("input[name='cheetah-factor-rankings[]']").change(function () {
    var box = $(this);
    var originalRating = $(".current-step .question").data("original-rating");
    var newRating = parseInt(box.attr("value"));

    if(box.is(':checked')){
      if(window.location.href.indexOf("repeat=true") != -1 &&
         originalRating != undefined &&
         originalRating != "" &&
         parseInt(originalRating) != newRating ) {

        var originalRating = parseInt(originalRating);
        var tieRating = originalRating + Math.abs(originalRating - newRating) / 2;


        var option1 = $("#tiebreaker .rating-option")[0];
        $(option1).find(".value-description").text(originalRating);
        $(option1).find("input").val(originalRating);

        var option2 = $("#tiebreaker .rating-option")[1];
        $(option2).find(".value-description").text(tieRating);
        $(option2).find("input").val(tieRating);

        var option3 = $("#tiebreaker .rating-option")[2];
        $(option3).find(".value-description").text(newRating);
        $(option3).find("input").val(newRating);

        var p = $("#tiebreaker .tie-prompt").text();
        p = p.replace("LAST_VAL", originalRating);
        p = p.replace("NEW_VAL", newRating);
        p = p.replace("RANGE", originalRating + " - " + tieRating + " - " + newRating);
        $("#tiebreaker .tie-prompt").text(p);


        $("#tiebreaker").fadeIn();
      } else {
        var data = {id: box.data('cheetah-factor-id'),
                    repeat: box.data('repeat'),
                    rating: box.attr('value')};

        $.ajax({
          type: "POST",
          url: "/cheetah_factor_rankings",
          data: data,
          dataType: "JSON",
          context: box
        });
      }
    }
  });
};

function bindUserCareerFactorResponseRating() {
  $("input[name='cheetah-factor-career-rankings[]']").change(function () {
    var box = $(this);

    if(box.is(':checked')){
      var data = {id: box.data('user-career-cheetah-factor-ranking-id'),
                  cheetah_factor_id: box.data('cheetah-factor-id'),
                  user_career_id: box.data('user-career-id'),
                  repeat: box.data('repeat'),
                  rating: box.attr('value')};

      $.ajax({
        type: "POST",
        url: "/user_career_cheetah_factor_rankings",
        data: data,
        dataType: "JSON",
        context: box
      });
    }
  });
};
