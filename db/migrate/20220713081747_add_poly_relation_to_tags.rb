class AddPolyRelationToTags < ActiveRecord::Migration[6.1]
  def up
    change_table :tags do |t|
      t.references :tagged_on, polymorphic: true
    end
  end

  def down
    change_table :tags do |t|
      t.remove_references :tagged_on, polymorphic: true
    end
  end
end
