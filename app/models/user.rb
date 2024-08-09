class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :patients, dependent: :destroy 
  has_many :likes, dependent: :destroy
  has_many :liked_patients, through: :likes, source: :patient
  has_many :comments, dependent: :destroy
  validates :name, presence: true 
  validates :profile, length: { maximum: 200 } 

  def already_liked?(patient)
    self.likes.exists?(patient_id: patient.id)
  end

  mount_uploader :image, ImageUploader
end