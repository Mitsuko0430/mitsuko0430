class PatientTagRelation < ApplicationRecord
  belongs_to :patient
  belongs_to :tag
end
