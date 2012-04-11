class Article < ActiveRecord::Base
  acts_as_publishable
  
  has_friendly_id :title, :use_slug => true
  
  default_scope :order => "date DESC, updated_at DESC"
  
  before_update :sanitize_html
  
  def sanitize_html
    doc = Hpricot self.content
    doc.search("[@style]").each do |e|
      e.remove_attribute("style")
    end
    self.content = doc.html
  end
end
