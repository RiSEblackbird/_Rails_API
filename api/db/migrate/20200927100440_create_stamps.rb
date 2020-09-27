class CreateStamps < ActiveRecord::Migration[6.0]
  def change
    create_table :stamps do |t|
      t.integer :keyword_id
      t.integer :study_log_id

      t.timestamps
    end
  end
end
