def all_activities
    @activities = Activity.get_activities_list( params[:popular], params[:all])
		# if params[:popular] == 'yes'
		# 	#if user checks "popular"
		# 	#organize all activities into descending order according to heart_count:
		# 	@activities = Activity.order(heart_count: :desc)
		# elsif params[:all] == 'yes'
		# 	#if user checks "all"
		# 	@activities = Activity.all
		elsif params[:activity] != nil
			#if user checks other boxes
			@activities = [] #store filtered results
			categories = params[:activity][:category] #array of checked categories
			categories.each do |c|
				activity = Activity.all.where('category like ?', "%#{c}%")
				if activity != []
					#"if activity" doesn't work because "where" returns empty record []
					@activities << activity
				end
				@activities.flatten! #from[1,2,[3,4]] to [1,2,3,4]
				@activities = @activities.uniq #delete duplicates
			end
		else
			#if user checks no boxes
			@activities = Activity.all
		end
	end