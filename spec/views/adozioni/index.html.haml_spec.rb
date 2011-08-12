require 'spec_helper'

describe "adozioni/index.html.haml" do
  before(:each) do
    assign(:adozioni, [
      stub_model(Adozione),
      stub_model(Adozione)
    ])
  end

  it "renders a list of adozioni" do
    render
  end
end
