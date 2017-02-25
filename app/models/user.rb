class User < ApplicationRecord
  has_secure_password
  has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  validates :email, presence: true, uniqueness: true
  def to_s
    email
  end

  def unread_messages
    received_messages.where(read_at: nil)
  end

  def image_or_default
    image.presence || "http://loremflickr.com/320/245/#{name.gsub(' ',' ')}"
  end

end
