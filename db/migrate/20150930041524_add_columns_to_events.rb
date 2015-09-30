class AddColumnsToEvents < ActiveRecord::Migration
  def change

    add_column :events, :attendees_count, :integer, :default => 0
    add_column :events, :last_registered_at, :datetime
    
  end
end
