class Stamp < ApplicationRecord
  belongs_to :keyword
  belongs_to :study_log
end