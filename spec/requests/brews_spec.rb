require 'spec_helper'

describe "Brews" do
  describe "GET /brews" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get brews_path
      response.status.should be(200)
    end
    
    # it "shows a javascript alert", :js => true do
    #   visit brews_path
    #   click_link "hello"
    #   page.should have_content("Hai!")
    # end
    
  end
end
