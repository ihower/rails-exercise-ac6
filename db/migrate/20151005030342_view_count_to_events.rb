class ViewCountToEvents < ActiveRecord::Migration
  def change

    add_column :events, :views_count, :integer, :default => 0 
  end
end
