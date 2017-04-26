class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :homefirst
      t.integer :awayfirst
      t.integer :homesecond
      t.integer :awaysecond
      t.integer :homethird
      t.integer :awaythird
      t.integer :homefourth
      t.integer :awayfourth
      t.integer :homefifth
      t.integer :awayfifth

      t.timestamps null: false
    end
  end
end
