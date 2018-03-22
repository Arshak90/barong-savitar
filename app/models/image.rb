class Image < ApplicationRecord
  mount_uploader :upload, UploadUploader

  belongs_to :document

  validates :document_id, :upload, presence: true
  validates :upload, length: { maximum: 10.megabytes }
end


# == Schema Information
# Schema version: 20180227160402
#
# Table name: images
#
#  id          :integer          not null, primary key
#  document_id :integer
#  upload      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_images_on_document_id  (document_id)
#
# Foreign Keys
#
#  fk_rails_...  (document_id => documents.id)
#
