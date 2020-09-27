class CreateKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :keywords do |t|
      t.string :word, null: false
      t.text :memo

      t.timestamps
    end
  end
end
