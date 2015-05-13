class BsessionsController < ApplicationController
  def new
  end

  def create
  	borrower = Borrower.authenticate(params[:borrower][:email], params[:borrower][:password])
    if borrower.nil?
      flash[:error] = "couldn't find a borrower with those credentials"
      #if there is an error, redirect back to login
      redirect_to '/bsessions/new'
    else
      # sign_in borrower #helper function 
    session[:borrower_name] = borrower.full_name
    session[:borrower_id] = borrower.id
    redirect_to "/borrowers/#{borrower.id}"
 	end
  end

  def destroy
    session.clear
    redirect_to '/signinb'
  end
end
