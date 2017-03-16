class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.date :birthday
      t.integer :age
      t.boolean :clubowner
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
