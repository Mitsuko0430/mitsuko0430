class CreatePatientTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_tag_relations do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
