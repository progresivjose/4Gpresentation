class AddProyectoIdToFotos < ActiveRecord::Migration
  def change
    add_column :fotos, :proyecto_id, :integer
    add_index :fotos, :proyecto_id

  end
end
