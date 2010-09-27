class AddDraftToFilms < ActiveRecord::Migration
  def self.up
    add_column :films, :draft, :boolean, :default => false
  end

  def self.down
    remove_column :films, :draft
  end
end
