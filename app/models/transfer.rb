class Transfer < ActiveRecord::Base
  has_many :borrowers
  has_many :lenders
  belongs_to :lender
  belongs_to :borrower

 	validates :amountlent, :presence => true,
    	numericality: true
end
