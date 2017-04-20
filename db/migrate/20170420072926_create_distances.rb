class CreateDistances < ActiveRecord::Migration[5.0]
  def change
    create_table :distances do |t|
      t.string :origin
      t.string :destiny
      t.integer :kilometers
      t.timestamps
    end
  end
end
