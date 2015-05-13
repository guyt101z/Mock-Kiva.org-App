class LendersController < ApplicationController
  def index
  end

  def new
    @error =  flash[:errors]
    @notice = flash[:notice]
    @errorB =  flash[:Berrors]
    @noticeB = flash[:Bnotice]


  end

  def show
    @name = session[:name]
    @lender = Lender.find(params[:id])
    @borrowers = Borrower.all

        transfers = Lender.find(session[:lender_id]).transfers
    count = 0
    transfers.each do |transfer|
      count = count + transfer.amountlent
    end
    @balance = session[:money] - count 

    @transfers1 = Transfer.all
  end

  def edit
  end

  def create
      @lender = Lender.new(lender_params)
    if @lender.save
      session[:lender_name] = @lender.full_name
      session[:lender_id] =  @lender.id
      session[:money] = @lender.money
      flash[:notice] = 'New lender created!'
      redirect_to "/lenders/#{@lender.id}"
    else
      flash[:errors] = @lender.errors.full_messages
      redirect_to '/lenders/new'
    end
  end

  def update
  end

  def destroy
  end

  private
    def lender_params
      params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
    end
end
