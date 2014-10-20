class AddColumnToFfs < ActiveRecord::Migration
  def change
    add_column :ffs, :description, :string
  end
end
