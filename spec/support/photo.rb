def photo args = {}
	p = Factory.build(:photo, args)
	p.stub!(:save_attached_files).and_return(true)
	p.save
	p
end