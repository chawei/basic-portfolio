class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table "albums", :force => true do |t|
      t.string   "album_cover_title",        :default => ""
      t.string   "full_title"
      t.string   "title"
      t.text     "description"
      t.integer  "position"
      t.integer  "album_cover_photo_id"
      t.string   "album_cover_file_name"
      t.string   "album_cover_content_type"
      t.integer  "album_cover_file_size"
      t.datetime "album_cover_updated_at"
      
      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
