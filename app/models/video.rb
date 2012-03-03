class Video < ActiveRecord::Base
		
	mount_uploader :video, AvatarUploader
#	mount_uploader :video_mp4, AvatarUploader
	
	validates :nombre, :presence => true
	
	belongs_to :proyecto
end
