require 'spec_helper'

describe "libri/edit.html.haml" do
  before(:each) do
    @libro = assign(:libro, stub_model(Libro,
      :titolo => "MyString",
      :copertina => "9.99",
      :categoria_id => 1
    ))
  end

  it "renders the edit libro form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => libro_path(@libro), :method => "post" do
      assert_select "input#libro_titolo", :name => "libro[titolo]"
      assert_select "input#libro_copertina", :name => "libro[copertina]"
      assert_select "input#libro_categoria_id", :name => "libro[categoria_id]"
    end
  end
end
