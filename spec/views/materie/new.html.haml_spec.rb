require 'spec_helper'

describe "materie/new.html.haml" do
  before(:each) do
    assign(:materia, stub_model(Materia,
      :materia => "MyString"
    ).as_new_record)
  end

  it "renders new materia form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => materie_path, :method => "post" do
      assert_select "input#materia_materia", :name => "materia[materia]"
    end
  end
end
