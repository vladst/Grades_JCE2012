require 'spec_helper'

describe LoginController do
  describe 'Login page to Grade-jce 2012' do
    before(:each) do
      @pass = mock('pass')
      @pass.stub!(:password => '1234')
      @pass.stub(:group)
    end
    it 'When I login	to teacher acount it should chek pass at db aind redirect' do
      Teacher.stub_chain(:where, :first).and_return(@pass)
      post :auth, {:user => 123, :Password=>'1234'}
      response.should redirect_to "/teachers/123/choose_classes"
    end
    it 'When I login	to manager acount it should chek pass at db aind redirect' do
      Manager.stub_chain(:where, :first).and_return(@pass)
      post :auth, {:user => 123, :Password=>'1234'}
      response.should redirect_to "/managers/123/choose_classes"
   end
  end
end
