class CreateDiscos < ActiveRecord::Migration
  def change
    create_table :discos do |t|
      t.string :nombre
      t.text :descripcion
      t.string :muestra

      t.timestamps
    end
  end
end
