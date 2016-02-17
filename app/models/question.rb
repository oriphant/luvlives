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
require 'elasticsearch/model'

class Question < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  has_many :answers
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  default_scope { order('created_at DESC') }
  
  def self.popular(ranking)
    Question.order("views DESC").limit(5).find(ranking)
  end  

  def increment
    self.views ||= 0
    self.views += 1
    self.save
  end

  after_save :update_labelrank

  private
  # ~~~ Update Label Ranking System After Question Save - Start ~~~
  def update_labelrank    
    @rankings = Labeling.group(:label_id).order('count_id DESC').count(:id) # Creates an array from labeling with frequency of label_id tags
    @rankings.each_with_index do |(i, y), x| # i = value i.e. label_id / y = key i.e. frequency / x = index counter
      Label.where(id: i).update_all(rank: x, frequency: y)
    end
  end
  # ~~~ Update Label Ranking System After Question Save - End ~~~
  
end

# Answer.import # Added from Elasticsearch for auto sync model with Elasticsearch
