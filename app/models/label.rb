class Label<ActiveRecord::Base 
	has_many :labelings

	has_many :questions, through: :labelings, source: :labelable, source_type: :Question

	has_many :answers, through: :labelings, source: :labelable, source_type: :Answer
end