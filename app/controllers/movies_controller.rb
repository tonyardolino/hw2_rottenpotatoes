class MoviesController < ApplicationController

  def similar_movie
    @movie = Movie.find(params[:id])
    unless @movie.director == ''
      @movies = Movie.find_all_by_director(@movie.director)
    else
      flash[:warning] = "'#{@movie.title}' has no director info"
      redirect_to movies_path
    end
  end

  def search_tmdb
    @movies = Movie.find_in_tmdb(params[:search_terms])
    if @movies == [] 
      flash[:warning] = "'#{params[:search_terms]}' was not found in TMDb."
      redirect_to movies_path(:sort_order => session[:sort_order], :ratings => session[:ratings])
    end
  end

  def movies_with_filters
    @movies = Movie.with_good_reviews(params[:threshold])
    %w(for_kids with_many_fans recently_reviewed).each do |filter|
      @movies = @movies.send(filter) if params[filter]
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    begin
      @movie = Movie.find(id) # look up movie by unique ID
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = 'The Movie ID you tried to access does not exist'
      redirect_to movies_path(:sort_order => session[:sort_order], :ratings => session[:ratings])
    end
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:order => :title}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:order => :release_date}, 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}
    
    if @selected_ratings == {}
      @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    end
    
    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      flash.keep
      redirect_to movies_path(:sort => sort, :ratings => @selected_ratings) and return
    end
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, ordering)
  end

  def new
    # default: render 'new' template
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(params[:movie])
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
#     redirect_to movies_path
      redirect_to movie_path(@movie)
    else
      render 'new'
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    if @movie.update_attributes(params[:movie])
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    else
      render 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
