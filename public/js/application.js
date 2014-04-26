$(document).ready(function() {
  $('form').on("submit", function(event){
    event.preventDefault();
    var id = $(this).attr("action").match(/\d/)[0];
    var posting = $.post('/decks/' + id, $("form").serialize(), null, "json" );
    posting.done(function(data) {
      var post_data = data;
      console.log(post_data);
      console.log(typeof(post_data));
      console.log(post_data.response);
      console.log(post_data["response"]);
      $(".jumbotron form").css("display", "none");
      $(".jumbotron h1").empty().html("<h1>" + post_data["response"] + "</h1>");
      $("#next-button").empty().text("Next");
      $("#num_correct").text(post_data.num_correct);
      $("#num_wrong").text(post_data.num_wrong);
    });
  });
});
