class AddPolyRelationToTags < ActiveRecord::Migration[6.1]
  def up
    rename_table :article_tags, :associated_tags if table_exists?(:article_tags)
    rename_column :associated_tags, :article_id, :association_id if column_exists?(:associated_tags, :article_id)
    change_table :associated_tags do |t|
      t.references :tagged_on, polymorphic: true
    end
  end

  def down
    change_table :associated_tags do |t|
      t.remove_references :tagged_on, polymorphic: true
    end
  end
end
