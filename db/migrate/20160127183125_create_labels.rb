class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
    	t.string :name
    	t.integer :rank
    	t.integer :frequency
    	t.timestamps null: false
    end
  end
end
