require 'spec_helper'

describe "classi/new.html.haml" do
  before(:each) do
    assign(:classe, stub_model(Classe).as_new_record)
  end

  it "renders new classe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => classi_path, :method => "post" do
    end
  end
end
