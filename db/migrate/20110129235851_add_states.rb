class AddStates < ActiveRecord::Migration
  def self.up
    add_column :articles, :state, :string, :default => 'hidden'
    add_column :albums, :state, :string, :default => 'hidden'
    add_column :films, :state, :string, :default => 'hidden'
  end

  def self.down
    remove_column :films, :state 
    remove_column :albums, :state
    remove_column :articles, :state
  end
end