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
end
