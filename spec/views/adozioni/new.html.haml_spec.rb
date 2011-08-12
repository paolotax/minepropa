require 'spec_helper'

describe "adozioni/new.html.haml" do
  before(:each) do
    assign(:adozione, stub_model(Adozione).as_new_record)
  end

  it "renders new adozione form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => adozioni_path, :method => "post" do
    end
  end
end
