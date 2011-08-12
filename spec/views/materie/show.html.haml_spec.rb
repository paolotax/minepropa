require 'spec_helper'

describe "materie/show.html.haml" do
  before(:each) do
    @materia = assign(:materia, stub_model(Materia,
      :materia => "Materia"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Materia/)
  end
end
