require 'spec_helper'

describe "classi/show.html.haml" do
  before(:each) do
    @classe = assign(:classe, stub_model(Classe))
  end

  it "renders attributes in <p>" do
    render
  end
end
