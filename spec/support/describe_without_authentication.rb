def describe_without_authentication model, actions = []
	actions = (%w(new edit create update destroy) + actions).uniq
	
	describe "without authentication" do
		describe_get_actions :model => model, :member => [:show], :collection => [:index]
		%w(get post put delete).each do |method|
			actions.each do |action|
				describe "#{method.upcase} '#{action}'" do
					before do
						send(method.to_sym, action)
						model.stub!(:find).and_return(model.new)
					end
					redirect
					error
				end
			end
		end
	end
end