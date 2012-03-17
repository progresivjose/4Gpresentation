class Disco < ActiveRecord::Base
	has_many :pistas
	mount_uploader :muestra, AudioUploader
#	mount_uploader :audio_mp3, AvatarUploader
	mount_uploader :imagen, AvatarUploader
	
	
	accepts_nested_attributes_for :pistas, :reject_if => lambda { |a| a[:nombre].blank? }, :allow_destroy => true
end
