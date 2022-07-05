class AddEditionCounterToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :edition_counter, :int, default: 0
  end
end
