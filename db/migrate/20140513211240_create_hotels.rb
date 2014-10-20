class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.text :hotel
      t.string :hr_no
      t.string :hr_pw
      t.string :hr_point
      t.integer :user_id

      t.timestamps
    end
  end
end
