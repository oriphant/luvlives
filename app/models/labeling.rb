# == Schema Information
#
# Table name: labelings
#
#  id             :integer          not null, primary key
#  label_id       :integer
#  labelable_id   :integer
#  labelable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Labeling<ActiveRecord::Base 

belongs_to :labelable, polymorphic: true 
belongs_to :label

def self.top_five
	Labeling.group(:label_id).order('count_id DESC').limit(5)
end

def self.top(key)
	self.top_five.count(:id).keys[key]
end

end
