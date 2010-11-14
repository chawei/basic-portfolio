class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.integer :film_id
      t.string :associate_id
      t.string :video_data_file_name
      t.string :video_data_content_type
      t.string :video_data_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
