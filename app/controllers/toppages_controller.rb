class ToppagesController < ApplicationController
  def index
    @books = Book.order('updated_at DESC')
  end
end
