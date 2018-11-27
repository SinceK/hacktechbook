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
    if result['mediumImageUrl'].present?
      image_url = result['mediumImageUrl'].gsub('?_ex=120x120', '')
    elsif result['smallImageUrl'].present?
      image_url = result['smallImageUrl'].gsub('?_ex=64x64', '')
    elsif result['largeImageUrl'].present?
      image_url = result['largeImageUrl'].gsub('?_ex=200x200', '')
    else
      image_url = ""
    end
    author = result['author'].present? ? result['author'] : ''
    caption = result['itemCaption'].present? ? result['itemCaption'] : ''
    price = result['itemPrice'].present? ? result['itemPrice'] : ''

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
