class SiteController < ApplicationController

  def index
    
  end
  
  def search
    @movies = Movie.find(:all, :conditions => ['MATCH(name) AGAINST (?)', params[:q]])
    
    respond_to do |format|
      if @movies.nil?
        format.html {render :action => 'search_empty'}
      else
        format.html
      end
    end
  end
  
  def movie
    @movie = Movie.find_by_id(params[:id])
    
    respond_to do |format|
      if @movie.nil?
        format.html {redirect_to :action => 'index'}
      else
        format.html
      end
    end
    
  end
  
end
