class Page < ActiveRecord::Base
  has_friendly_id :unique_name
  
  validates_presence_of :unique_name
  
  def self.all_custom_pages
    return [self.page('bio'), self.page('cv'), self.page('contact')]
  end
  
  def self.page(unique_name)
    return nil if unique_name.blank?
    unless page = Page.find_by_unique_name(unique_name)
      page = Page.create(:unique_name => unique_name,
                         :title => unique_name.humanize,
                         :content => 'Please edit me')
    end
    return page
  end
end
