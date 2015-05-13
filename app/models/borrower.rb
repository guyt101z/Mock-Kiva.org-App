class Borrower < ActiveRecord::Base
	has_many :transfers
	has_many :lenders, through: :transfers
		attr_accessor :password, :password_confirmation

  	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	validates :first_name,    :presence   => true,
            :length               => { :maximum => 30 }
  
	validates :last_name,    :presence   => true,
            :length               => { :maximum => 30 }
  
	validates :email,   :presence   => true,
            :format               => { :with => email_regex },
            :uniqueness           => { :case_sensitive => false }
            #this validates the form input
 	validates :password,  :presence => true,
            :confirmation         => true,
            :length               => { :within => 4..100 }

    validates :amount, :presence => true,
    			numericality: true

	validates :plan, :presence => true
		
	validates :description, :presence => true


  #before the borrower gets added to DB, run this function.
  before_save :encrypt_password

 	#this method encrypts the borrower's unencrypted login attempt and returns true if the password is a match
	def full_name
		first_name + ' ' + last_name
	end

	def has_password?(submitted_password)
		self.encrypted_password == encrypt(submitted_password)
	end


	# class method that checks whether the borrower's email and submitted password are valid
	def self.authenticate(email, submitted_password)
		borrower = find_by_email(email)
		return nil if borrower.nil?
		return borrower if borrower.has_password?(submitted_password)
	end
  
	private
		def encrypt_password
		  # generate a unique salt if it's a new borrower
		  # self.password uses the attr_accessor we defined above to allow me to grab the inputed password 
		  self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{self.password}") if self.new_record?

		  # encrypt the password and store that in the encrypted_password field
		  self.encrypted_password = encrypt(self.password)  #this self.password is what's in the post data!
		end

		# encrypt the password using both the salt and the passed password
		def encrypt(pass)
		  Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
		end
end
