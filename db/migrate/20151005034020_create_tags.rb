class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :taggings do |t|
      t.integer :event_id, :index => true
      t.integer :tag_id, :index => true
      t.timestamps null: false
    end    
  end
end
