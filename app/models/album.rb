class Album < ActiveRecord::Base
  include ValidatesAsImage
  
  has_friendly_id :title, :use_slug => true
  
  acts_as_list
  acts_as_publishable
  default_scope :order => 'position'
  
  validates_presence_of :title

  has_many :photos, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :photos
  
  validates_as_image :album_cover
  
  has_attached_file :album_cover, 
                    :styles => { :small => { :geometry => "185x185#", 
                                             :processors => [:cropper]},
                                 :medium => { :geometry => "300x300>" } }
  
  # Cropping                               
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_cover, :if => :cropping?
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def album_cover_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(album_cover.path(style))
  end
  
  private
  
    def reprocess_cover
      album_cover.reprocess!
    end
end