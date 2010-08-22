class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table "photos", :force => true do |t|
      t.string   "title",             :default => ""
      t.string   "name"
      t.text     "description"
      t.integer  "imageable_id"
      t.string   "imageable_type"
      t.string   "data_file_name"
      t.string   "data_content_type"
      t.string   "data_file_size"
      t.integer  "position"
      
      t.timestamps
    end

    add_index "photos", ["imageable_id", "imageable_type"], :name => "index_photos_on_imageable_id_and_imageable_type"
  end

  def self.down
    drop_table :photos
  end
end
