require 'spec_helper'

describe "classi/index.html.haml" do
  before(:each) do
    assign(:classi, [
      stub_model(Classe),
      stub_model(Classe)
    ])
  end

  it "renders a list of classi" do
    render
  end
end
