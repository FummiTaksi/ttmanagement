class AddPlayer2ToMatch < ActiveRecord::Migration
  def change
    add_column :players, :player2_id, :integer
  end
end
