class Patient < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    has_many :comments, dependent: :destroy
    #tweetsテーブルから中間テーブルに対する関連付け
    has_many :patient_tag_relations, dependent: :destroy
    #tweetsテーブルから中間テーブルを介してTagsテーブルへの関連付け
    has_many :tags, through: :patient_tag_relations, dependent: :destroy
    mount_uploader :image, ImageUploader
end