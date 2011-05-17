require 'spec_helper'

describe "appunto_righe/new.html.haml" do
  before(:each) do
    assign(:appunto_riga, stub_model(AppuntoRiga,
      :libro_id => 1,
      :quantita => 1,
      :prezzo => "9.99",
      :sconto => "9.99",
      :consegnato => false,
      :pagato => false
    ).as_new_record)
  end

  it "renders new appunto_riga form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => appunto_righe_path, :method => "post" do
      assert_select "input#appunto_riga_libro_id", :name => "appunto_riga[libro_id]"
      assert_select "input#appunto_riga_quantita", :name => "appunto_riga[quantita]"
      assert_select "input#appunto_riga_prezzo", :name => "appunto_riga[prezzo]"
      assert_select "input#appunto_riga_sconto", :name => "appunto_riga[sconto]"
      assert_select "input#appunto_riga_consegnato", :name => "appunto_riga[consegnato]"
      assert_select "input#appunto_riga_pagato", :name => "appunto_riga[pagato]"
    end
  end
end
