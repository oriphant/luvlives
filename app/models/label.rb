# == Schema Information
#
# Table name: labels
#
#  id         :integer          not null, primary key
#  name       :string
#  rank       :integer
#  frequency  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Label<ActiveRecord::Base 
	has_many :labelings
	has_many :questions, through: :labelings, source: :labelable, source_type: :Question

	def self.update_labels(label_string)
		return Label.none if label_string.blank?

		label_string.split(",").map do |label|
			Label.find_or_create_by(name: label.strip)
		end
	end
 
end
