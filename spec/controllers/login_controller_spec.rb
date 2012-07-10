require 'spec_helper'

describe LoginController do
  describe 'Login page to Grade-jce 2012' do
    before(:each) do
      @pass = mock('pass')
      @pass.stub!(:password => '1234', :group=> 12)
    end
    it 'When I login	to teacher acount it should chek pass at db aind redirect' do
      Teacher.stub_chain(:where, :first).and_return(@pass)
      post :auth, {:user => 123, :Password=>'1234'}
      response.should redirect_to "/teachers/123/choose_classes"
    end
    it 'When I login	to manager acount it should chek pass at db aind redirect' do
      Manager.stub_chain(:where, :first).and_return(@pass)
      post :auth, {:user => 123, :Password=>'1234'}
      response.should redirect_to "/managers/options"
    end
    it 'When I try login with wrong pass/id it should redirect to root' do
      Teacher.stub_chain(:where, :first).and_return(@pass)
      Manager.stub_chain(:where, :first).and_return(@pass)
      post :auth, {:user => 123, :Password=>'wrong password'}
      response.should redirect_to "/"
    end
  end
  describe 'Logout from the system' do
    it 'When I press logout it should route to login page' do
      get :logout
      response.should redirect_to "/"
    end
  end
end
