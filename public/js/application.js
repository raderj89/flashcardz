$(document).ready(function() {
  $('#guess').on("submit", function(event){
    event.preventDefault();
    var id = $(this).attr("action").match(/\d/)[0];
    var posting = $.post('/decks/' + id, $("#guess").serialize(), null, "json" );
    posting.done(function(data) {
      $(".jumbotron form").css("display", "none");
      $(".jumbotron h1").empty().html("<h1>" + data.response + "</h1>");
      $("#next-button").text("Next");
      $("#num_correct").text(data.num_correct);
      $("#num_wrong").text(data.num_wrong);
      $("#num_remaining").text(data.num_left);
    });
  });
});
