# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  value      :integer
#  user_id    :integer
#  answer_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer

  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }

  after_save :update_vote_count

  private
  def update_vote_count
	  if value_changed?
	  	answer.vote_count -= value_was || 0 # If user changeing vote this line accounts for the old value and removes it if it exists or is zero
	  	answer.vote_count += value # Add the new value to the vote count
	  	answer.update_attributes(vote_count: answer.vote_count)
	  end
	end

end
