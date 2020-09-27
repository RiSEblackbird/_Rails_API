class CreateStudyLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :study_logs do |t|
      t.text :body, null: false

      t.timestamps
    end
  end
end
