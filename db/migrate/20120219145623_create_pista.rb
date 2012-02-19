class CreatePista < ActiveRecord::Migration
  def change
    create_table :pista do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
