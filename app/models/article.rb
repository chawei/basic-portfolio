class Article < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
  
  default_scope :order => "date DESC"
end
