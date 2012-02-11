class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps
    end
  end
end
