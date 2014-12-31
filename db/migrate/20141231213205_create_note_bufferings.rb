class CreateNoteBufferings < ActiveRecord::Migration
  def change
    create_table :note_bufferings do |t|
      t.belongs_to :note, index: true
      t.belongs_to :buffer, index: true

      t.timestamps
    end
  end
end
