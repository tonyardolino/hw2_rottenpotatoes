require 'spec_helper'

describe MoviesController do
  describe 'Find Movies With Same Director', :type => :controller do
    it 'should call the controller method similar_movie with id parameter' do
      fake_results = mock('Movie', director: 'George Lucas')
      Movie.should_receive(:find).with('1').and_return(fake_results)
      get :similar_movie, {:id => 1}
    end
    it 'should return Movie when called' do
      fake_results = mock('Movie', director: 'George Lucas')
      Movie.stub(:find).and_return(fake_results)
      get :similar_movie, {:id => 1}
      assigns(:movie).should == fake_results
      #response.should render_template('search_tmdb')
    end
    it 'should make the director search results available to that template' do
      fake_results = mock('Movie', director: 'George Lucas')
      Movie.stub(:find).and_return(fake_results)
      Movie.should_receive(:find_all_by_director).with('George Lucas')
      get :similar_movie, {:id => 1}
    end
    it 'should make the director search results available to that template' do
      fake_results = mock('Movie', director: 'George Lucas')
      Movie.stub(:find).and_return(fake_results)
      Movie.stub(:find_all_by_director).and_return(fake_results)
      get :similar_movie, {:id => 1}
      assigns(:movies).should == fake_results
    end
  end
end
