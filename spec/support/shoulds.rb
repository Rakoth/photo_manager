def success
	it "should be success" do
		response.should be_success
	end
end

def template name
	it "should render template for '#{name}'" do
		response.should render_template(name)
	end
end

def redirect url = nil
	it "should be redirect" do
		if url.nil?
			response.should be_redirect
		else
			response.should redirect_to(eval(url))
		end
	end
end

def notice message = nil
	flash_message :notice, message
end

def error message = nil
	flash_message :error, message
end

def flash_message type, message = nil
	it "should set flash[:#{type}] message" do
		if message.nil?
			flash[type].should_not be_nil
		else
			flash[type].should == message
		end
	end
end

def assign variable, value = nil
	it "should assign '#{variable}'" do
		if value.nil?
			assigns[variable].should_not be_nil
		else
			assigns[variable].should == eval(value)
		end
	end
end

def build model
	it "should not create a new '#{model}'" do
		assigns[model].should be_a_new_record
	end
end

def create model
	it "should create a new '#{model}'" do
		assigns[model].should_not be_a_new_record
	end
end
