class AddImagenUidToFotos < ActiveRecord::Migration
  def change
    add_column :fotos, :imagen_uid, :string

  end
end
