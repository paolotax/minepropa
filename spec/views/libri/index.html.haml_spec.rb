require 'spec_helper'

describe "libri/index.html.haml" do
  before(:each) do
    assign(:libri, [
      stub_model(Libro,
        :titolo => "Titolo",
        :copertina => "9.99",
        :categoria_id => 1
      ),
      stub_model(Libro,
        :titolo => "Titolo",
        :copertina => "9.99",
        :categoria_id => 1
      )
    ])
  end

  it "renders a list of libri" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Titolo".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
