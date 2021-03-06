class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.integer :views
      t.boolean :helpful
      t.integer :sharedcount
      t.integer :vote_count, default: 0
      
      t.timestamps null: false
    end
  end
end
