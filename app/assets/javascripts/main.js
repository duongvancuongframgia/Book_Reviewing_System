$(document).on('turbolinks:load',function() {
	$('#to-top').bind('click', function() {
		$('body,html').animate({scrollTop: 0}, 2500);
	});

  $('#btn-follow').on('click', function() {
    action = ($(this).text().trim()) === 'Follow' ? 'POST' : 'DELETE';
    text = ($(this).text().trim()) === 'Follow' ? 'unfollow' : 'Follow';
    id = $('#followed_id').val();
    url = ($(this).text().trim()) === 'Follow' ? '/relationships' : '/relationships/' + id;
    $.ajax({
      type: action,
      url : url,
      dataType: 'json',
       data: {
        relationship: {
          id: id
        }
      },
      success: function(data) {
        $('#btn-follow').text(text);
        $('#followers').html(data.followers);
        $('#following').html(data.following);
      },
      error: function(error_message) {
        alert('error ' + error_message);
      }
    });
  });
});
