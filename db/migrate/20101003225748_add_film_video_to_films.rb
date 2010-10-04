class AddFilmVideoToFilms < ActiveRecord::Migration
  def self.up
    add_column :films, :film_video_file_name, :string
    add_column :films, :film_video_content_type, :string
    add_column :films, :film_video_file_size, :string 
  end

  def self.down
    remove_column :films, :film_video_file_name
    remove_column :films, :film_video_content_type
    remove_column :films, :film_video_file_size
  end
end
