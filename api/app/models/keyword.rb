# frozen_string_literal: true

class Keyword < ApplicationRecord
  has_many :stamps
  has_many :study_logs, through: :stamps
end
