class AddFirstNameToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :firstname, :string
  end
end
