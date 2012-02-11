class Foto < ActiveRecord::Base
	image_accessor :imagen   
	
	validates :nombre, :presence => true
	validates :tipo, :presence => true
	
	belongs_to :proyecto
end
