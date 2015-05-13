class TransfersController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def edit
  end

  def create
    if params[:balance].to_i >= params[:amountlent].to_i
      @transfer = Transfer.new(amountlent: params[:amountlent], lender_id: session[:lender_id], borrower_id: params[:borrower_id])
      if @transfer.save
        flash[:notice] = 'New Transfer created!'
        redirect_to "/lenders/#{session[:lender_id]}"
      else
        flash[:errors] = @transfer.errors.full_messages
        redirect_to "/lenders/#{session[:lender_id]}"
      end
    else
      flash[:error] = "You do not have that much money"
      redirect_to "/lenders/#{session[:lender_id]}"
    end
  end

  def update
  end

  def destroy
  end
end
