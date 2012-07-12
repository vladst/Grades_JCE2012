require 'spec_helper'

describe TeachersController do
  describe 'Teachers options' do
    # before(:each) do
    #  @pass = mock('pass')
    #  @pass.stub!(:password => '1234', :group=> 12)
    #end
    it 'Only logged in user can see the page' do
      session = mock ("sesion")
      session.stub(:[]).with(:manager).and_return(nil)
      get :choose_classes
      response.should redirect_to root_path
    end
    it 'Teacher must see only classes he teach' do
      session = mock ("sesion")
      session.stub(:[]).with(:manager).and_return(false)
      session.stub(:[]).with(:id).and_return(2345)
      get :choose_classes
      @pass = mock('pass')
      Teacher.stub_chain(:select, :where, :first, :name).and_return(@pass)
      #post :auth, {:user => 123, :Password=>'1234'}
      #response.should redirect_to "/teachers/123/choose_classes"
    end
  end
end
