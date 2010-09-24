class CreateFilms < ActiveRecord::Migration
  def self.up
    create_table :films do |t|
      t.string :film_type
      t.string :title
      t.text :description
      t.string :director
      t.string :year
      t.string :color
      t.string :film_length
      t.string :languages
      t.string :film_thumb_file_name
      t.string :film_thumb_content_type
      t.string :film_thumb_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :films
  end
end
