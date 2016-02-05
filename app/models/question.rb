# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  title       :string
#  body        :text
#  user_id     :integer
#  views       :integer          default(0)
#  anonymous   :boolean          default(FALSE)
#  shared      :integer          default(0)
#  public      :boolean          default(TRUE)
#  genderlimit :string
#  agelimit    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  default_scope { order('created_at DESC') }
  
  def increment
    self.views ||= 0
    self.views += 1
    self.save
  end
  
  def self.popular(ranking)
    Question.order("views DESC").limit(5).find(ranking)
  end  

  after_save :update_labelrank

  private
  def update_labelrank    
    # (0..Label.all.count-1).each do |i|
    #   Label.where(id: Labeling.group(:label_id).order('count_id DESC').limit(5).count(:id).keys[i]).update_all(rank: i, frequency: Labeling.group(:label_id).order('count_id DESC').count(:id).values[i])
    # end
    @rankings = Labeling.group(:label_id).order('count_id DESC').count(:id)
    
    @rankings.each_with_index do |(i, y), x|
      Label.where(id: i).update_all(rank: x, frequency: y)
    end

  end

end
