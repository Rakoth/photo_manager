require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
	fixtures :photos, :comments
  before do
		@it = Comment.new
		@it.stub!(:spam? => false, :ham! => "Thank you", :spam! => "Thank you")
  end

  it "should create a new instance given valid attributes" do
    @it.update_attributes(
			:author => "value for author",
			:author_email => "test@mail.ru",
			:content => "value for body",
			:photo => photos(:one)
		)
		@it.should_not be_a_new_record
  end

	it "should not create new comment given invalid attributes" do
		@invalid_attributes = {
      :author => nil,
      :author_email => "testmail.ru",
      :content => nil,
      :photo_id => nil
    }

		@it.update_attributes(@invalid_attributes)
		@it.should be_new_record
		@it.should have(2).error_on(:author)
		@it.should have(1).error_on(:author_email)
		@it.should have(1).error_on(:content)
		@it.should have(1).error_on(:photo)
	end

	it "should automatically add http to site url upon saving" do
		{'example.com' => 'http://example.com',
			'http://example.com' => 'http://example.com',
			'https://example.com' => 'https://example.com',
			'' => '' }.each do |before, after|
			@it.author_url = before
			@it.save_without_validation
			@it.author_url.should == after
		end
	end

  it "should set request based attributes" do
    @it.request = stub(:remote_ip => 'ip', :env => { 'HTTP_USER_AGENT' => 'agent', 'HTTP_REFERER' => 'referrer' })
    @it.user_ip.should == 'ip'
    @it.user_agent.should == 'agent'
    @it.referrer.should == 'referrer'
  end

	it "should set spam feild on create" do
		@it.save_without_validation
		@it.looks_like_spam?.should == false
	end

	it "should set spam feild on create" do
		@it.stub!(:spam? => true)
		@it.save_without_validation
		@it.looks_like_spam?.should == true
	end

	describe "gravatar_options" do
		before{@it.author_email = 'test@mail.ru'}

		it "should return oprions for gravatar" do
			@it.gravatar_options[:protocol].should == 'http://'
			@it.gravatar_options[:controller].should == 'avatar.php'
			@it.gravatar_options[:host].should == 'www.gravatar.com'
			@it.gravatar_options[:only_path].should == false
			@it.gravatar_options[:gravatar_id].should == Digest::MD5.hexdigest('test@mail.ru')
		end

		it "should include diven options for gravatar options" do
			@it.gravatar_options(:foo => :bar)[:foo].should == :bar
		end
	end

	describe "mark_as_spam!" do
		before do
			@it = comments(:one)
			@it.stub!(:spam! => true)
		end
		it "should mark comment as spam with delayed job" do
			@it.should_receive(:send_later).with(:spam!)
			@it.mark_as_spam!
			@it.should be_looks_like_spam
		end
	end

	describe "mark_as_ham!" do
		before do
			@it = comments(:one)
			@it.stub!(:ham! => true)
		end
		it "should mark comment as ham with delayed job" do
			@it.should_receive(:send_later).with(:ham!)
			@it.mark_as_ham!
			@it.should_not be_looks_like_spam
		end
	end

	describe "self.delete_spam!" do
		it "should delete all spam comments" do
			comments(:one).mark_as_spam!
			Comment.delete_spam!
			Comment.count(:conditions => {:spam => true}).should == 0
		end
	end

	describe "unwatched" do
		before do
			Comment.delete_all
			3.times { Factory.create :comment }
			3.times { Factory.create :comment, :view_at => Time.now }
		end

		it "should return all new orders" do
			Comment.unwatched.count.should == 3
		end

		it "should return only new orders" do
			Comment.unwatched.each do |comment|
				comment.view_at.should be_nil
			end
		end
	end
end
