class Film < ActiveRecord::Base
  FILM_TYPES = ["Directorial", "Editorial"]
  
  has_friendly_id :title
  include ValidatesAsImage
  
  has_attached_file :film_thumb, :styles => { :large => "800x450#",
                                              :preview => "700x450>",
                                              :medium => "370x210#",
                                              :thumb => "80x80>" }
  
  validates_attachment_presence :film_thumb
  validates_as_image :film_thumb
  
  has_attached_file :film_video

  named_scope :public, :conditions => { :draft => false }
end
