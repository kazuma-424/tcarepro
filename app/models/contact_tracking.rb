class ContactTracking < ApplicationRecord
  belongs_to :sender
  belongs_to :customer
  belongs_to :inquiry
  belongs_to :worker, optional: true

  validates :code, uniqueness: true, presence: true
  validates :status, presence: true, inclusion: { in: %w(送信済 送信不可 営業NG) }

  scope :latest, ->(sender_id){
    where(id: ContactTracking.select('max(id) as id').where(sender_id: sender_id).group(:customer_id))
  }

  def success?
    status == '送信済'
  end
end
