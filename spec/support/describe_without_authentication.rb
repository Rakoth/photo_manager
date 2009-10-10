def describe_without_authentication model, actions = []
	actions = (%w(new edit create update destroy) + actions).uniq
	
	describe "without authentication" do
		describe_get_actions :model => model, :member => [:show], :collection => [:index]
		
		actions.each do |action|
			describe action do
				before { get action }
				redirect 'login_path'
				error
			end
		end
	end
end