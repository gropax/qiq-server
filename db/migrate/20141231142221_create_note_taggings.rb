class CreateNoteTaggings < ActiveRecord::Migration
  def change
    create_table :note_taggings do |t|
      t.belongs_to :note, index: true
      t.belongs_to :tag, index: true

      t.timestamps
    end
  end
end
