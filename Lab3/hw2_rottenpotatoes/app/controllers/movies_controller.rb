class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.ratings

    # If there are parameters add them to the session
    if params[:sort]
      session[:sort] = params[:sort]
    end

    if params[:ratings]
      session[:ratings] = params[:ratings]
    end
    
    if session[:sort] == nil
      @sort = ''
    else
      @sort = session[:sort]
    end

    if session[:ratings].class.name.include?('Hash')
      @ratings = session[:ratings].keys
    else
      if session[:ratings] == nil
        @ratings = @all_ratings
      else
        @ratings = session[:ratings]
      end
    end

    if session[:sort] == 'title'
      @title_header = 'hilite'
    elsif session[:sort] == 'release_date DESC'
      @release_date_header = 'hilite'
    end

    @movies = Movie.where(:rating => @ratings).order(@sort)

    redirect_to movies_path(:sort => @sort, :ratings => @ratings) unless (params[:sort] || params[:ratings])
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end
