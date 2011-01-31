class Article < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
  
  default_scope :order => "date DESC"
  scope :published, where(:state => 'published')
  
  state_machine :state, :initial => :hidden do
    event :publish do
      transition [:published, :hidden] => [:published]
    end
    
    event :hide do
      transition [:published, :hidden] => [:hidden]
    end
  end
  
  def toggle_published
    hidden? ? publish : hide
  end
end
