require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do
	describe_get_actions :actions => [:about_me]
end