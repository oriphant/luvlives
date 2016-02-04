# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  status                 :string           default("user")
#  bio                    :text
#  city                   :string
#  state                  :string
#  gender                 :string
#  age                    :integer
#  facebook               :string
#  twitter                :string
#  linkedin               :string
#  website                :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :questions
  has_many :answers
  has_many :posts
  has_many :votes
  mount_uploader :avatar, AvatarUploader

  def admin?
    status == 'admin'
  end
 
  def moderator?
    status == 'moderator'
  end

  def increment
    self.views ||= 0
    self.views += 1
    self.save
  end

end
