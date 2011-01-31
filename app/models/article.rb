class Article < ActiveRecord::Base
  acts_as_publishable
  
  has_friendly_id :title, :use_slug => true
  
  default_scope :order => "date DESC"
end
