class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :amountlent
      t.references :lender, index: true
      t.references :borrower, index: true

      t.timestamps
    end
  end
end
