module ApplicationHelper
  def full_title page_title
    base_title = t "app.helpers.application.base_title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def get_image book, class_image = ""
    if book.image?
      image_tag book.image, class: class_image, size: Settings.size_image_book
    else
      image_tag "book1.png", class: class_image, size: Settings.size_image_book
    end
  end

  def get_image_user user, class_image = ""
    if user.avatar?
      image_tag user.avatar, class: class_image, size: Settings.size_image_avater
    else
      image_tag "avatar.jpg", class: class_image, size: Settings.size_image_avater
    end
  end
end
