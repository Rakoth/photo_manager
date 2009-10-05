##
# генерирует проверки для переданных действий на
#		success
#		template
#		assign (если передана модель и действия через массивы :member & :collection)
# использование
#		describe_get_actions :model => Photo
#			равносильно describe_get_actions :model => Photo, :member => [:new, :show, :edit], :collection => [:index]
#		describe_get_actions :actions => [:about_us, :rules]
##
def describe_get_actions options = {}
	params = {
		:member => [:new, :show, :edit],
		:collection => [:index]
	}.merge options

	actions = params[:actions] || params[:member] + params[:collection]
	actions.each do |action|
		describe "GET #{action}" do
			before do
				params[:model].stub!(:find).and_return(params[:model].new) unless params[:model].nil?
				get action
			end

			success
			template action

			unless params[:model].nil?
				model_name = params[:model].class_name.downcase
				assign_name = (params[:collection].include?(action) ? model_name.pluralize : model_name)
				
				assign assign_name
			end
		end
	end
end