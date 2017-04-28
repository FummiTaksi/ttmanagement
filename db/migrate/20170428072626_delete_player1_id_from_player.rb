class DeletePlayer1IdFromPlayer < ActiveRecord::Migration
  def change
    remove_column :players, :player1_id
  end
end
