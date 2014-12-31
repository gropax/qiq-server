class CreateBuffers < ActiveRecord::Migration
  def change
    create_table :buffers do |t|
      t.string :name

      t.timestamps
    end
  end
end
