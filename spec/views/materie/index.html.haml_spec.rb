require 'spec_helper'

describe "materie/index.html.haml" do
  before(:each) do
    assign(:materie, [
      stub_model(Materia,
        :materia => "Materia"
      ),
      stub_model(Materia,
        :materia => "Materia"
      )
    ])
  end

  it "renders a list of materie" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Materia".to_s, :count => 2
  end
end
