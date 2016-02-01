# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  url        :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :user
   has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  has_many :votes, as: :voteable
end
