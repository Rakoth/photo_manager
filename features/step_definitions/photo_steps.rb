Then /^I should see photo image with "([^\"]*)" style$/ do |style|
  request.should have_tag('img[src=?]', Photo.first.image.url(style))
end
