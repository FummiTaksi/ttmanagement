class AddPlayer1ToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :player1_id, :integer
  end
end
