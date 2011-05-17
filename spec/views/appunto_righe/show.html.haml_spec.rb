require 'spec_helper'

describe "appunto_righe/show.html.haml" do
  before(:each) do
    @appunto_riga = assign(:appunto_riga, stub_model(AppuntoRiga,
      :libro_id => 1,
      :quantita => 1,
      :prezzo => "9.99",
      :sconto => "9.99",
      :consegnato => false,
      :pagato => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
