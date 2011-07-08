require 'spec_helper'

describe "fatture/index.html.haml" do
  before(:each) do
    assign(:fatture, [
      stub_model(Fattura,
        :numero => 1,
        :data => "",
        :scuola_id => "",
        :user_id => "",
        :causale_id => "",
        :dettaglio_righe => false
      ),
      stub_model(Fattura,
        :numero => 1,
        :data => "",
        :scuola_id => "",
        :user_id => "",
        :causale_id => "",
        :dettaglio_righe => false
      )
    ])
  end

  it "renders a list of fatture" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
