class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name, :null => false, :limit => 100
      t.string :keywords, :limit => 255
      t.text :description
      t.string :cover
      
      t.integer :photos_count, :null => false, :default => 0

      t.timestamps
    end
  end
end
