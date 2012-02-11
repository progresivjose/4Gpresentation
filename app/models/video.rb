class Video < ActiveRecord::Base
	validates :nombre, :presence => true
	
	belongs_to :proyecto
end
