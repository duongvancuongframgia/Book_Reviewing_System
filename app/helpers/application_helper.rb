module ApplicationHelper
	
	def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  # get image for a Book
  def get_image book, class_image = ""
    if book.picture?
      image_tag book.picture, class: class_image
    else
      image_tag "book1.jpg", class: class_image
    end
  end
end
