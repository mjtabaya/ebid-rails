class Auction < ApplicationRecord
  has_many :bid_entries, :dependent => :destroy
  belongs_to :user, :dependent => :destroy
  default_scope -> { order(date_auctioned: :desc) }
  mount_uploader :hero_banner, PictureUploader
  validates :user_id, :date_auctioned, :status, presence: true
  enum status: %i[pending ongoing completed]
  validates :status, inclusion: { in: status.keys }

  def self.status_options
    status.map { |k, _v| [k.humanize.capitalize, k] }
  end
end
