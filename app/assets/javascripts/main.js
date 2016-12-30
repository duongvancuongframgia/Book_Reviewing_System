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

  $('#bt-favourite').on('click', function() {
    action = ($(this).val().trim()) === 'favourite' ? 'POST' : 'DELETE';
    text = ($(this).val().trim()) === 'favourite' ? 'unfollow' : 'Follow';
    book_id = $('#book_id').val();
    url = ($(this).val().trim()) === 'favourite' ? '/favourites' : '/favourites/' + book_id;
    $.ajax({
      type: action,
      url : url,
      dataType: 'json',
       data: {
        favourite: {
          book_id: book_id
        }
      },
      success: function(data) {
        if ($('#bt-favourite').hasClass('btn btn-circle')) {
          $('#bt-favourite').removeClass('btn btn-circle').addClass('btn btn-danger btn-circle');
        } else {
          $('#bt-favourite').removeClass('btn btn-danger btn-circle').addClass('btn btn-circle');
        }
        $('#bt-favourite').val(data.value);
      },
      error: function(error_message) {
        alert('error ' + error_message);
      }
    });
  });

  $("#book_image").bind("change", function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert("Maximum file size is 5MB. Please choose a smaller file.");
    }
  });
});
