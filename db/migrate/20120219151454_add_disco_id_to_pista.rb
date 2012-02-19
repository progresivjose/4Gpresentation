class AddDiscoIdToPista < ActiveRecord::Migration
  def change
    add_column :pista, :disco_id, :integer
    add_index :pista, :disco_id

  end
end
