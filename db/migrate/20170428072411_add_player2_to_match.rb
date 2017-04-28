class AddPlayer2ToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :player2_id, :integer
  end
end
