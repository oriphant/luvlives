class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.integer :views, :default => 0
      t.boolean :anonymous, default: false #, null: false
      t.integer :shared, :default => 0
      t.boolean :public, default: true #, null: false
      t.string :genderlimit #, :default => "none"
      t.string :agelimit #, :default => "none"

      t.timestamps null: false
    end
  end
end
