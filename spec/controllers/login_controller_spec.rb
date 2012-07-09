require 'spec_helper'

describe LoginController do

  describe "Check session Teacher and Manager" do
    it "checking session[:manager]" do
      
      response.should true
    end
  end
  describe "Check DB users" do
    it "if db if life" do
      teacher = Teacher.all.first
      response.should teacher
    end
  end
  describe "Check cookies" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  end
  describe "Check Authentication" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  end
  describe "Check manager create a teacher" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  end

end
