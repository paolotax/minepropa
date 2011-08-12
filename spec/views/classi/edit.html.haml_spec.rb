require 'spec_helper'

describe "classi/edit.html.haml" do
  before(:each) do
    @classe = assign(:classe, stub_model(Classe))
  end

  it "renders the edit classe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => classe_path(@classe), :method => "post" do
    end
  end
end
