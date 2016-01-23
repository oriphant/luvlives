class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.integer :views
      t.boolean :anonymous #, default: false #, null: false
      t.integer :shared
      t.boolean :public #, default: true #, null: false
      t.string :genderlimit
      t.string :agelimit

      t.timestamps null: false
    end
  end
end
