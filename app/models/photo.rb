class Photo < ActiveRecord::Base
  include ValidatesAsImage
  
  acts_as_list
  default_scope :order => 'position'
  
  belongs_to :imageable, :polymorphic => true
  
  has_attached_file :data, :styles => { :large => "730x438>",
                                        :medium => "453x264>",
                                        :small => "185x185>",
                                        :thumb => "84x54#" }
  
  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 5.megabytes
  validates_as_image :data
  
  def album
    debugger
    if self.imageable_type == "Album"
      return Album.find(self.imageable_id)
    else
      nil
    end
  end

end
