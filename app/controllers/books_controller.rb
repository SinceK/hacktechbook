class BooksController < ApplicationController
  #before_action :require_user_logged_in
  
  def new
    @books = []
    
    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
        #booksGenreId: '001005'
      })
      
      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
  end
  
  private

  def read(result)
    isbn = result['isbn']
    title = result['title']
    url = result['itemUrl']
    image_url = result['mediumImageUrl'].gsub('?_ex=120x120', '')

    {
      isbn: isbn,
      title: title,
      url: url,
      image_url: image_url,
    }
  end
end
