# frozen_string_literal: true

class CreateStamps < ActiveRecord::Migration[6.0]
  def change
    create_table :stamps do |t|
      t.belongs_to :keyword
      t.belongs_to :study_log

      t.timestamps
    end
  end
end
