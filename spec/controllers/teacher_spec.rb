require 'spec_helper'

describe TeachersController do
	describe 'Teachers options' do
		it 'Only logged in user can see the page' do
			session = nil
			get :choose_classes
			response.should redirect_to root_path
		end
		it 'Teacher must see only classes he teach' do
			session[:manager]=false
			
      Teacher.stub(:possible_classes)
			Manager.stub_chain(:select, :where, :first, :deadline)
			get :choose_classes
			#response.should redirect_to "/teachers/123/choose_classes"
		end
	end
	describe "Manager change teachers" do
		it 'manager can see only teachers of his group' do
			session[:manager]=true
			session[:group]=1
			teachers=mock("tMock")
			teachers.stub!(:group=>123)
			Teacher.stub(:where).and_return(teachers)
			get :index
		end
		it 'only managers can see teachers' do
			session[:manager]=false
			get :index
			response.should redirect_to root_path
		end

   	it 'Manager can add class to teacher' do
   		session[:manager]=true
   		session[:group]=1
   		@teach = mock('teacherMock')
   		@teach.stub!(:teacher_id=>123, :name=>"Reuven", :password=>"1234")
   		subj=mock('subjMock')
   		subj.stub!(:subject=>"History")
   		gclas=mock('gclasMock')
   		gclas.stub!(:gclass=>"7a")
		 	Teacher.stub_chain(:where, :first).and_return(@teach)
		 	Teacher.stub(:new)
		 	Subject.stub_chain(:all, :map).and_return(subj)
		 	Gclass.stub_chain(:all, :map).and_return(gclas)
		 	get :add_class, {:id => 123}
		 	response.code.should eq("200")
   end
   it 'Manager can add new teacher' do
      session[:manager]=true
      subj=mock('subjMock')
   		subj.stub!(:subject=>"History")
   		gclas=mock('gclasMock')
   		gclas.stub!(:gclass=>"7a")
      Teacher.stub!(:new)
      Subject.stub_chain(:all, :map).and_return(subj)
		 	Gclass.stub_chain(:all, :map).and_return(gclas)
		 	get :new
   end
	end
end

