class BorrowersController < ApplicationController
  def index
  end

  def new
  end

  def show
    @borrower = Borrower.find(session[:borrower_id])

  end

  def edit
  end

  def create
    @borrower = Borrower.new(borrower_params)
    if @borrower.save
      # sign_in @borrower
      flash[:Bnotice] = 'New borrower created!'
      session[:borrower_name] = @borrower.full_name
      session[:borrower_id] = @borrower.id
      redirect_to "/borrowers/#{@borrower.id}"
    else
      flash[:Berrors] = @borrower.errors.full_messages
      redirect_to '/lenders/new'
    end
  end

  def update
  end

  def destroy
  end

  private
    def borrower_params
      params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :plan, :description, :amount)
    end

end
