
$(document).on('page:change', 'page:load', function () {
  var disqusPublicKey = "G5tosdkcwgXvyM5z7zxhrqK7QCOQwrs94xRpAYx6KUpxBW9YK8La8aGgotP4DtV8"; // Replace with your own public key
  var disqusShortname = "digiramp"; // Replace with your own shortname

  var urlArray = [];

  $('.comment-link-marker').each(function () {
    var url = $(this).attr('data-disqus-url');
    urlArray.push('link:' + url);
  });

  $.ajax({
    type: 'GET',
    url: "https://disqus.com/api/3.0/threads/set.jsonp",
    data: { api_key: disqusPublicKey, forum : disqusShortname, thread : urlArray },
    cache: false,
    dataType: 'jsonp',
    success: function (result) {

      for (var i in result.response) {

        var countText = " comments";
        var count = result.response[i].posts;

        if (count == 1)
          countText = " comments";

        $('a[data-disqus-url="' + result.response[i].link + '"]').html(count + countText);

      }
    }
  });
});






















