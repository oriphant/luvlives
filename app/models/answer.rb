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
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :voteable

  def total_vote
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end
  
end
