class Foto < ActiveRecord::Base
	mount_uploader :imagen, AvatarUploader   
	
	validates :nombre, :presence => true
#	validates :tipo, :presence => true
	
	belongs_to :proyecto
end
