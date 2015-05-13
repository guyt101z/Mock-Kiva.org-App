class SessionsController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def edit
  end

  def create
    lender = Lender.authenticate(params[:lender][:email], params[:lender][:password])
    if lender.nil?
      flash[:error] = "couldn't find a lender with those credentials"
      #if there is an error, redirect back to login
      redirect_to '/sessions/new'
    else
      # sign_in lender #helper function 
      session[:lender_name] =  lender.full_name
      session[:lender_id] =  lender.id
      session[:money] = lender.money
     redirect_to "/lenders/#{lender.id}"
   end
  end

  def update
  end

  def destroy
    session.clear
    redirect_to '/signin'
  end
end
