require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
	fixtures :photos, :comments
  before do
		@comment = Comment.new
		@comment.stub!(:spam? => false, :ham! => "Thank you", :spam! => "Thank you")
  end

  it "should create a new instance given valid attributes" do
    @comment.update_attributes(
			:author => "value for author",
			:author_email => "test@mail.ru",
			:content => "value for body",
			:photo => photos(:one)
		)
		@comment.should_not be_a_new_record
  end

	it "should not create new comment given invalid attributes" do
		@invalid_attributes = {
      :author => nil,
      :author_email => "testmail.ru",
      :content => nil,
      :photo_id => nil
    }

		@comment.update_attributes(@invalid_attributes)
		@comment.should be_new_record
		@comment.should have(2).error_on(:author)
		@comment.should have(1).error_on(:author_email)
		@comment.should have(1).error_on(:content)
		@comment.should have(1).error_on(:photo)
	end

	it "should automatically add http to site url upon saving" do
		{'example.com' => 'http://example.com',
			'http://example.com' => 'http://example.com',
			'https://example.com' => 'https://example.com',
			'' => '' }.each do |before, after|
			@comment.author_url = before
			@comment.save_without_validation
			@comment.author_url.should == after
		end
	end

  it "should set request based attributes" do
    @comment.request = stub(:remote_ip => 'ip', :env => { 'HTTP_USER_AGENT' => 'agent', 'HTTP_REFERER' => 'referrer' })
    @comment.user_ip.should == 'ip'
    @comment.user_agent.should == 'agent'
    @comment.referrer.should == 'referrer'
  end

	it "should set spam feild on create" do
		@comment.save_without_validation
		@comment.looks_like_spam?.should == false
	end

	it "should set spam feild on create" do
		@comment.stub!(:spam? => true)
		@comment.save_without_validation
		@comment.looks_like_spam?.should == true
	end

	describe "gravatar_options" do
		before{@comment.author_email = 'test@mail.ru'}

		it "should return oprions for gravatar" do
			@comment.gravatar_options[:protocol].should == 'http://'
			@comment.gravatar_options[:controller].should == 'avatar.php'
			@comment.gravatar_options[:host].should == 'www.gravatar.com'
			@comment.gravatar_options[:only_path].should == false
			@comment.gravatar_options[:gravatar_id].should == Digest::MD5.hexdigest('test@mail.ru')
		end

		it "should include diven options for gravatar options" do
			@comment.gravatar_options(:foo => :bar)[:foo].should == :bar
		end
	end

	describe "mark_as_spam!" do
		before do
			@comment = comments(:one)
			@comment.stub!(:spam! => true)
		end
		it "should mark comment as spam with delayed job" do
			@comment.should_receive(:send_later).with(:spam!)
			@comment.mark_as_spam!
			@comment.should be_looks_like_spam
		end
	end

	describe "mark_as_ham!" do
		before do
			@comment = comments(:one)
			@comment.stub!(:ham! => true)
		end
		it "should mark comment as ham with delayed job" do
			@comment.should_receive(:send_later).with(:ham!)
			@comment.mark_as_ham!
			@comment.should_not be_looks_like_spam
		end
	end

	describe "self.delete_spam!" do
		it "should delete all spam comments" do
			comments(:one).mark_as_spam!
			Comment.delete_spam!
			Comment.count(:conditions => {:spam => true}).should == 0
		end
	end
end
