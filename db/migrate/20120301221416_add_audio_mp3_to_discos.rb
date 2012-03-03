class AddAudioMp3ToDiscos < ActiveRecord::Migration
  def change
    add_column :discos, :audio_mp3, :string

  end
end
