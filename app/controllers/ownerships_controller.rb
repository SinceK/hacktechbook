class OwnershipsController < ApplicationController
  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])

    unless @book.persisted?
      # @book が保存されていない場合、先に @book を保存する
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)

      @book = Book.new(read(results.first))
      @book.save
    end

    # Want 関係として保存
    if params[:type] == 'Want'
      current_user.want(@book)
      flash[:success] = '欲しい！に追加 しました。'
    elsif params[:type] == 'Have'
      current_user.have(@book)
      flash[:success] = '持ってる！に追加 しました。'
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])

    if params[:type] == 'Want'
      current_user.unwant(@book) 
      flash[:success] = '欲しい！ を解除しました。'
    elsif params[:type] == 'Have'
      current_user.unhave(@book) 
      flash[:success] = '持ってる！を解除しました。'
    end

    redirect_back(fallback_location: root_path)
  end
end