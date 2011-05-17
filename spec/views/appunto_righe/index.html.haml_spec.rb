require 'spec_helper'

describe "appunto_righe/index.html.haml" do
  before(:each) do
    assign(:appunto_righe, [
      stub_model(AppuntoRiga,
        :libro_id => 1,
        :quantita => 1,
        :prezzo => "9.99",
        :sconto => "9.99",
        :consegnato => false,
        :pagato => false
      ),
      stub_model(AppuntoRiga,
        :libro_id => 1,
        :quantita => 1,
        :prezzo => "9.99",
        :sconto => "9.99",
        :consegnato => false,
        :pagato => false
      )
    ])
  end

  it "renders a list of appunto_righe" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
