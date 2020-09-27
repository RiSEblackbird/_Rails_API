class CreateStamps < ActiveRecord::Migration[6.0]
  def change
    create_table :stamps do |t|
      t.belongs_to :keyword
      t.belongs_to :study_log
      t.integer :keyword_id
      t.integer :study_log_id

      t.timestamps
    end
  end
end
