class CreateExpenses < ActiveRecord::Migration
  def up
    create_table :expenses do |t|
      t.column "user_id", :integer
      t.column "transaction_date", :datetime
      t.column "description", :string
      t.column "amount", :decimal, precision: 10, scale: 2
      t.column "category", :string
      t.timestamps
    end
  end

  def down
    drop_table :expenses
  end
end
