class Film < ActiveRecord::Base
  acts_as_publishable
  
  FILM_TYPES = ["Directorial", "Editorial"]
  
  has_friendly_id :title
  include ValidatesAsImage
  
  has_attached_file :film_thumb, :styles => { :large => "800x450#",
                                              :preview => "700x450>",
                                              :medium => "370x210#",
                                              :thumb => "80x80>" }
  
  #validates_attachment_presence :film_thumb
  validates_as_image :film_thumb
  
  has_one :video
  has_attached_file :film_video

  scope :public, :conditions => { :draft => false }
  
  after_create :remove_redundant_videos
  
  def remove_redundant_videos
    Video.cleanup
  end
end
