class RenameDestinyToDestination < ActiveRecord::Migration[5.0]
  def change
    rename_column :distances, :destiny, :destination
  end
end
