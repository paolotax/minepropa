require 'spec_helper'

describe StampeController do

  describe "GET 'sovrapacchi_adozioni'" do
    it "should be successful" do
      get 'sovrapacchi_adozioni'
      response.should be_success
    end
  end

end
