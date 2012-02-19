class AddImagenToDiscos < ActiveRecord::Migration
  def change
    add_column :discos, :imagen, :string

  end
end
