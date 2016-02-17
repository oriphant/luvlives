# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :text
#  user_id     :integer
#  question_id :integer
#  views       :integer
#  helpful     :boolean
#  sharedcount :integer
#  rank        :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes

  default_scope { order(vote_count: :desc, created_at: :desc) }

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
  	votes.sum(:value)
  end

  def increment
    self.views ||= 0
    self.views += 1
    self.save
  end

end

