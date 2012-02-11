class Proyecto < ActiveRecord::Base
	validates :nombre, :presence => true
	
	has_many :fotos
	has_many :videos
end
