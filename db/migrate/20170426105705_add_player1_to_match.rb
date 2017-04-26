class AddPlayer1ToMatch < ActiveRecord::Migration
  def change
    add_column :players, :player1_id, :integer
  end
end
