class MoviesController < ApplicationController

    before_action :require_signin, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]

    def index
        case params[:filter]
        when "upcoming"
          @movies = Movie.upcoming
        when "recent"
          @movies = Movie.recent
        else
          @movies = Movie.released
        end
    end

    def show
        @movie = Movie.find(params[:id])
        @fans = @movie.fans
        @genres = @movie.genres
        if current_user
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
        end
    end

    def edit
        @movie = Movie.find(params[:id]) 
    end

    def update
        @movie = Movie.find(params[:id])
        if @movie.update(movie_params)
            redirect_to @movie, notice: "Movie succesfully updated!"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            redirect_to @movie, notice: "Movie succesfully created!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy

        redirect_to movies_path, status: :see_other, notice: "Movie succesfully deleted!"
    end

    private
        def movie_params
            movie_params = 
            params.require(:movie).
                permit(:title, :description, :rating, :total_gross,
                    :released_on, :image_file_name, :director, :duration, genre_ids: [])
        end

end
