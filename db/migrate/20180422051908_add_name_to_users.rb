class AddNameToUsers < ActiveRecord::Migration
  def up
    add_column("users", "name", :string,
               :after => "email")
  end

  def down
    remove_column("users", "name")
  end
end
