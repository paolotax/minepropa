require 'spec_helper'

describe "libri/show.html.haml" do
  before(:each) do
    @libro = assign(:libro, stub_model(Libro,
      :titolo => "Titolo",
      :copertina => "9.99",
      :categoria_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Titolo/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
