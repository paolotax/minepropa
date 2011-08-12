require 'spec_helper'

describe "adozioni/edit.html.haml" do
  before(:each) do
    @adozione = assign(:adozione, stub_model(Adozione))
  end

  it "renders the edit adozione form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => adozione_path(@adozione), :method => "post" do
    end
  end
end
