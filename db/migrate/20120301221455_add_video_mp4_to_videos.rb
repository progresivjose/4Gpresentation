class AddVideoMp4ToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :video__mp4, :string

  end
end
