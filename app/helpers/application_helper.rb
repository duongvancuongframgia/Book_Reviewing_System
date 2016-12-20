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
    if book.image?
      image_tag book.image, class: class_image, size: 140
    else
      image_tag "book1.jpg", class: class_image, size: 140
    end
  end
end
