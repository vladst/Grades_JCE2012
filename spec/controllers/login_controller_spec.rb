require 'spec_helper'

describe LoginController do
  describe 'Login page to Grade-jce 2012' do
   it 'When I login	to teacher acount it should create and save the coockies'
    mock = mock('Teacher')
    Teacher.sess
    get :edit, {:id => '13'}
    response.should be_success
   end
  end
end
