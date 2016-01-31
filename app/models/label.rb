class Label<ActiveRecord::Base 
	has_many :labelings

	has_many :questions, through: :labelings, source: :labelable, source_type: :Question

	def self.update_labels(label_string)
		return Label.none if label_string.blank?

		label_string.split(",").map do |label|
			Label.find_or_create_by(name: label.strip)
		end
	end

	# def self.ranking
	# 	Label.find(Labeling.group(:label_id).order('count_id DESC').limit(5).count(:id).keys[0]).name.titleize
	# 	a = Labeling.group(:label_id).order('count_id DESC').limit(5).count(:id)
	# end
end