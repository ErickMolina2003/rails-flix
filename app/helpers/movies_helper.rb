module MoviesHelper

    def total_gross(movie)
        number_to_currency(movie.total_gross, precision: 0)
    end

    def date_format(movie)
        movie.released_on.strftime("%B %d at %I:%M %P")
    end

    def year_of(movie)
        movie.released_on.year
    end

end
