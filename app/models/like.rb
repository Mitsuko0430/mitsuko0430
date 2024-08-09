class Like < ApplicationRecord
  belongs_to :patient
  belongs_to :user
  validates_uniqueness_of :patient_id, scope: :user_id
end
