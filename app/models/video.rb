class Video < ActiveRecord::Base
  belongs_to :film
  has_attached_file :video_data
end
