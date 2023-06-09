class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  
  def new
  end

  def index
  	@books = Book.all
  	@book = Book.new
  end

  def show
  	@book = Book.find(params[:id])
  end

  def create
  	@book = Book.new(book_params)
  	  if @book.save
  	  flash[:notice] = "Book was successfully updated."
  		redirect_to book_path(@book)
    	else
    	 @books = Book.all
    	 render :index 
    	 
    end
  end


  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  	flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book.id) 
    else
    	 @books = Book.all
    	 render :edit
    	 
    end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	flash[:notice] = "Book was successfully destroyed."
    redirect_to '/books'
  end

  private
  
  def book_params
    params.require(:@book).permit(:title, :body)
  end
  
   def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
  
end