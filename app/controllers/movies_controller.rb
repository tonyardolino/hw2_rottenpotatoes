class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    flash.keep
    session[:ratings] = params[:ratings] if params[:ratings]
    session[:sort_order] = params[:sort_order] if params[:sort_order]
#    debugger
    if !params[:ratings] || !params[:sort_order]
      redirect_to movies_path(:sort_order => session[:sort_order], :ratings => session[:ratings])
    end
    if session[:ratings]
        @movies = Movie.where("rating IN (?)", session[:ratings].keys).order(session[:sort_order])
    else session[:sort_order]
        @movies = Movie.scoped(:order => session[:sort_order])
    end
  end

  def new
    # default: render 'new' template
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(params[:movie])
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
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
