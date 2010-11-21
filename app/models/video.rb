class Video < ActiveRecord::Base
  belongs_to :film
  has_attached_file :video_data
  
  def self.cleanup
    self.find_all_by_film_id(nil).each { |v| v.destroy }
  end
end
