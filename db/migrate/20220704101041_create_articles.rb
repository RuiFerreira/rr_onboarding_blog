class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :status, default: 0
      t.integer :user_id
      t.timestamps
    end
  end
end
