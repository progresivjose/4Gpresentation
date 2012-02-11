class AddProyectoIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :proyecto_id, :integer
    add_index :videos, :proyecto_id

  end
end
