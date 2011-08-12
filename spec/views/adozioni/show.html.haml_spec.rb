require 'spec_helper'

describe "adozioni/show.html.haml" do
  before(:each) do
    @adozione = assign(:adozione, stub_model(Adozione))
  end

  it "renders attributes in <p>" do
    render
  end
end
