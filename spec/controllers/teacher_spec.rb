require 'spec_helper'

describe TeachersController do
  describe 'Teachers options' do
    # before(:each) do
    #  @pass = mock('pass')
    #  @pass.stub!(:password => '1234', :group=> 12)
    #end
    it 'Only logged in user can see the page' do
      session = nil
      get :choose_classes
      response.should redirect_to root_path
    end
    it 'Teacher must see only classes he teach' do
      session[:manager]=false
      @name = mock('name')
      @name.stub!("Reuven")
      Teacher.stub_chain(:select, :where, :first, :name).and_return(@name)
      Teacher.stub_chain(:select, :where, :where)
      Teacher.stub_chain(:select, :where, :where)
      Manager.stub_chain(:select, :where, :first, :deadline)
      get :choose_classes
      #response.should redirect_to "/teachers/123/choose_classes"
    end
  end
end
