$(document).ready(function() {
  $('#guess').on("submit", function(event){
    event.preventDefault();
    var id = $(this).attr("action").match(/\d/)[0];
    var posting = $.post('/decks/' + id, $("#guess").serialize(), null, "json" );
    posting.done(function(data) {
      $(".jumbotron form").css("display", "none");
      $(".jumbotron h1").empty().html("<h1>" + data.response + "</h1>");
      $("#num_correct").text(data.num_correct);
      $("#num_wrong").text(data.num_wrong);
      $("#num_remaining").text(data.num_left);
      $('#cometomama').val('');
      $("#next-button").hide();
    });

    setTimeout(function() {
      $.get(id, function(data) {
        $("#card_id").prop("value", data.card.id);
        $("#num_correct").text(data.num_correct);
        $(".jumbotron form").css("display", "block");
        $("#num_wrong").text(data.num_wrong);
        $("#num_remaining").text(data.num_left);
        $("#card-question").text(data.card.question);
        $("#next-button").show();
      }, "json")
    }, 3000);
  });

  $("#next-button").on("click", function(event) {
    event.preventDefault();
    var route = $(this).attr("href");

    $.get(route, function(data) {
      $("#card_id").prop("value", data.card.id);
      $("#card-question").text(data.card.question);
    }, "json");
  });
});
