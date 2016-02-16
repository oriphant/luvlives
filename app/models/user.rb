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
#  views                  :integer
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
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :omniauthable
         # , :omniauth_providers => [:facebook, :google_oauth2]
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

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #   # where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     user.name = auth.info.name
  #     # user.website = auth.info.website # Not working
  #     # user.bio = auth.info.user_about_me # Not working
  #     # user.bio = auth.extra.raw_info.bio # Not working
  #     # user.city = auth.info.location #Not working
  #     # user.facebook = auth.info.urls #Not working
  #     # user.gender = auth.info.gender
  #     user.remote_avatar_url = auth.info.image
  #   end
  # end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
          name:auth.extra.raw_info.name,
          provider:auth.provider,
          uid:auth.uid,
          email:auth.info.email,
          password:Devise.friendly_token[0,20],
          remote_avatar_url:auth.info.image
        )
      end
       
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
          name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
          remote_avatar_url: data["image"],
          gender: access_token.extra.raw_info.gender
        )
      end
   end
  end

end
