require 'spec_helper'

describe MoviesController do
  describe 'edit page for appropriate Movie' do
    it 'When I go to the edit page for the Movie, it should be loaded' do
      mock = mock('Movie')
      Movie.should_receive(:find).with('13').and_return(mock)
      get :edit, {:id => '13'}
      response.should be_success
    end
    it 'And I fill in "Director" with "Ridley Scott", And  I press "Update Movie Info", it should save the director' do
      mock = mock('Movie')
      mock.stub!(:update_attributes!)
      mock.stub!(:title)
      mock.stub!(:director)
      mock.stub!(:director)
      
      mock2 = mock('Movie')
      
      Movie.should_receive(:find).with('13').and_return(mock)
      mock.should_receive(:update_attributes!)
      post :update, {:id => '13', :movie => mock2 }
    end
    it 'When I follow "Find Movies With Same Director", I should be on the Similar Movies page for the Movie' do
      mock = mock('Movie')
      mock.stub!(:director).and_return('mock director')
      
      similarMocks = [mock('Movie'), mock('Movie')]
      
      Movie.should_receive(:find).with('13').and_return(mock)
      Movie.should_receive(:find_all_by_director).with(mock.director).and_return(similarMocks)
      get :similar, {:id => '13'}
    end
    it 'should show Movie by id' do
      mock = mock('Movie')
      Movie.should_receive(:find).with('13').and_return(mock)
      get :show, {:id => '13'}
    end
    it 'should redirect to index if movie does not have a director' do
      mock = mock('Movie')
      mock.stub!(:director).and_return(nil)
      mock.stub!(:title).and_return(nil)
      
      Movie.should_receive(:find).with('13').and_return(mock)
      get :similar, {:id => '13'}
      response.should redirect_to(movies_path)
    end
    it 'should be possible to create movie' do
      movie = mock('Movie')
      movie.stub!(:title)
      
      Movie.should_receive(:create!).and_return(movie)
      post :create, {:movie => movie}
      response.should redirect_to(movies_path)
    end
    it 'should be possible to destroy movie' do
      movie = mock('Movie')
      movie.stub!(:title)
      
      Movie.should_receive(:find).with('13').and_return(movie)
      movie.should_receive(:destroy)
      post :destroy, {:id => '13'}
      response.should redirect_to(movies_path)
    end
    it 'should redirect if sort order has been changed' do
      session[:sort] = 'release_date'
      get :index, {:sort => 'title'}
      response.should redirect_to(movies_path(:sort => 'title'))
    end
    it 'should be possible to order by release date' do
      get :index, {:sort => 'release_date'}
      response.should redirect_to(movies_path(:sort => 'release_date'))
    end
    it 'should redirect if selected ratings are changed' do
      get :index, {:ratings => {:G => 1}}
      response.should redirect_to(movies_path(:ratings => {:G => 1}))
    end
    it 'should call database to get movies' do
      Movie.should_receive(:find_all_by_rating)
      get :index
    end
  end
end
