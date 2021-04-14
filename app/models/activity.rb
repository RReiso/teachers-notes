class Activity < ApplicationRecord
	belongs_to :user
	has_many :comments

	private

	def self.increase_heart_count(activity)
		#first "like":
		!activity.heart_count ? 1 : activity.heart_count + 1
	end

	def self.get_all_activities(popular, all)
		if popular == 'yes'
			#if user checks "popular"
			#organize all activities into descending order according to heart_count:
			Activity.order(heart_count: :desc)
		elsif all == 'yes'
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
