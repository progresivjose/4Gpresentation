class Video < ActiveRecord::Base
		
	mount_uploader :video, AvatarUploader
	
	validates :nombre, :presence => true
	
	belongs_to :proyecto
end
