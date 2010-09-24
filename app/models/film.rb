class Film < ActiveRecord::Base
  FILM_TYPES = ["Directorial", "Editorial"]
  
  include ValidatesAsImage
  
  has_attached_file :film_thumb, :styles => { :large => "300x300>",
                                        :thumb => "80x80>" }
  
  validates_attachment_presence :film_thumb
  validates_as_image :film_thumb
end
