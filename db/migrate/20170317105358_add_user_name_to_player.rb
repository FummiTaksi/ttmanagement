class AddUserNameToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :username, :string
  end
end
