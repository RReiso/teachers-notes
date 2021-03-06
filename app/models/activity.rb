class Activity < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy

	private

	def self.increase_heart_count(activity)
		activity.heart_count = activity.heart_count + 1
	end

	def self.get_all_activities(popular, all)
		if popular == 'popular'
			#if user checks "popular"
			#organize all activities into descending order according to heart_count:
			Activity.order(heart_count: :desc)
		elsif all == 'all'
			#if user checks "all"
			Activity.all
		end
	end

	def self.get_activities_list_by_activity_category(categories)
		activities = [] #store filtered results
		categories.each do |c|
			activity = Activity.all.where('category like ?', "%#{c}%")
			if activity != []
				#"if activity" doesn't work because "where" returns empty record []
				activities << activity
			end
			activities.flatten! #from[1,2,[3,4]] to [1,2,3,4]
			activities = activities.uniq #delete duplicates
		end
		return activities
	end
end
