class AddLastNameToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :lastname, :string
  end
end
