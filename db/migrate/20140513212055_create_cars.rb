class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.text :car
      t.string :cr_no
      t.string :cr_pw
      t.string :cr_point
      t.integer :user_id

      t.timestamps
    end
  end
end
