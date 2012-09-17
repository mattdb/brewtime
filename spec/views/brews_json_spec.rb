# Normally I'm opposed to view specs, but for json built with rabl, it actually makes sense.
# Rspec controller tests by default don't render templates, which also means rabl templates.
# rather than turn on view rendering for entire controllers, it makes sense to test the rabl
# templates separately and test the controller's variable assignment to assure we get what 
# we're planning on from the controller.

require 'spec_helper'

describe 'brews/index.rabl' do
  let(:brew) { create(:brew_with_steps) }
  # let(:brew_json) {
  #   {
  #     name: brew.name,
  #     brewed: brew.brewed
  #   }.to_json
  # }
  before do
    @rendered = Rabl.render([brew], 'brews/index', view_path: 'app/views')
  end
  
  it "should have one brew" do
    @rendered.should have_json_size(1)
  end
  it "should have brew's name" do
    @rendered.should have_json_path("0/brew/name")
  end
  it "should have steps virtual attributes" do
    @rendered.should have_json_path("0/brew/steps/0/step/soonest_end")
  end
  
end