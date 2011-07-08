require 'spec_helper'

describe "fatture/new.html.haml" do
  before(:each) do
    assign(:fattura, stub_model(Fattura,
      :numero => 1,
      :data => "",
      :scuola_id => "",
      :user_id => "",
      :causale_id => "",
      :dettaglio_righe => false
    ).as_new_record)
  end

  it "renders new fattura form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => fatture_path, :method => "post" do
      assert_select "input#fattura_numero", :name => "fattura[numero]"
      assert_select "input#fattura_data", :name => "fattura[data]"
      assert_select "input#fattura_scuola_id", :name => "fattura[scuola_id]"
      assert_select "input#fattura_user_id", :name => "fattura[user_id]"
      assert_select "input#fattura_causale_id", :name => "fattura[causale_id]"
      assert_select "input#fattura_dettaglio_righe", :name => "fattura[dettaglio_righe]"
    end
  end
end
