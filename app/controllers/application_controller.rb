class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def read(result)
    isbn = result['isbn']
    title = result['title']
    title += ' ' + result['subTitle'] if result['subTitle'].present?
    title += ' (' + result['seriesName'] + ')' if result['seriesName'].present?
    url = result['itemUrl']
    image_url = result['mediumImageUrl'].gsub('?_ex=120x120', '')
    author = result['author']
    caption = result['itemCaption']
    price = result['itemPrice']

    {
      isbn: isbn,
      title: title,
      url: url,
      image_url: image_url,
      author: author,
      caption: caption,
      price: price,
    }
  end
end
