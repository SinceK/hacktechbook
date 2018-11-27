class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :ownerships
  has_many :books, through: :ownerships
  has_many :wants
  has_many :want_books, through: :wants, class_name: 'Book', source: :book
  has_many :haves, class_name: 'Have'
  has_many :have_books, through: :haves, class_name: 'Book', source: :book
  has_many :my_conditions
  has_many :reviews
  has_many :review_books, through: :reviews, class_name: 'Book', source: :book
  
  def want(book)
    self.wants.find_or_create_by(book_id: book.id)
  end

  def unwant(book)
    want = self.wants.find_by(book_id: book.id)
    want.destroy if want
  end

  def want?(book)
    self.want_books.include?(book)
  end
    
  def have(book)
    self.haves.find_or_create_by(book_id: book.id)
  end

  def unhave(book)
    have = self.haves.find_by(book_id: book.id)
    have.destroy if have
  end

  def have?(book)
    self.have_books.include?(book)
  end
end