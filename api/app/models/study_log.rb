# frozen_string_literal: true

class StudyLog < ApplicationRecord
  has_one :stamp
  has_one :keyword, through: :stamp
end
