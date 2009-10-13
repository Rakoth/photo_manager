#def describe_without_authentication model, actions = []
#	actions = (%w(new edit create update destroy) + actions).uniq
#
#	describe "without authentication" do
#		describe_get_actions :model => model, :member => [:show], :collection => [:index]
#
#		actions.each do |action|
#			describe action do
#				before { get action }
#				redirect 'login_path'
#				error
#			end
#		end
#	end
#end

def describe_without_authentication model, params = {}
	params[:accessible_member] ||= []
	params[:accessible_collection] ||= []
	params[:protected] ||= []

	unless params[:skip_defaults]
		params[:accessible_member] << :show
		params[:accessible_collection] << :index
		params[:protected] += %w(new edit create update destroy)
	end

	describe "without authentication" do
		describe_get_actions :model => model, :member => params[:accessible_member], :collection => params[:accessible_collection]

		params[:protected].each do |action|
			describe action do
				before { get action }
				redirect 'login_path'
				error
			end
		end
	end
end
