module ReviewsHelper
    def average_reviews(movie)
       if movie.average_stars.zero?
            content_tag(:strong, "No reviews")
       else
            pluralize(number_with_precision(movie.average_stars, precision: 1), "Star")
       end

    end
end
