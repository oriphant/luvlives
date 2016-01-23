# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  title       :string
#  body        :text
#  user_id     :integer
#  views       :integer
#  anonymous   :boolean
#  shared      :integer
#  public      :boolean
#  genderlimit :boolean
#  agelimit    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  before_create :set_defaults # does not allow you to change value in creating.
  default_scope { order('created_at DESC') }
  
  private
  def set_defaults
    # self.public = true
    # self.genderlimit = 'none'
    # self.agelimit = 'none'
    # self.anonymous = false
    self.views = 0
    self.shared = 0
  end
end
