require 'spec_helper'

describe "materie/edit.html.haml" do
  before(:each) do
    @materia = assign(:materia, stub_model(Materia,
      :materia => "MyString"
    ))
  end

  it "renders the edit materia form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => materia_path(@materia), :method => "post" do
      assert_select "input#materia_materia", :name => "materia[materia]"
    end
  end
end
