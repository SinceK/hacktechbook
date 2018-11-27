class BooksController < ApplicationController
  
  def new
    @books = []
    
    @title = params[:title]
    
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
        hits: 20,
        booksGenreId: '001005'
      })
      
      results.each do |result|
        book = Book.find_or_initialize_by(read(result))
        @books << book
      end
    end
  end
  
  def show
    @book = Book.find(params[:id])
    @want_users = @book.want_users
    @have_users = @book.have_users
    @review_users = @book.review_users
    @book_reviews = @book.reviews
    @book_rating_average = Review.book_average(params[:id]).to_f.to_s;
    
    if current_user  
      # ユーザの検索条件取得
      @my_conditions = MyCondition.where(user_id: current_user.id)
      # システムIDの配列を生成
      conditions_systemid = @my_conditions.map { |item| item["systemid_for_calil"] }
      
      # 蔵書検索
      @calil_books = Calil::Book.find([@book["isbn"]], conditions_systemid).first
    end 
  end
end
