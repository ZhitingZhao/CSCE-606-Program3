class Movie < ActiveRecord::Base
    def self.others_by_same_director(id)
        movie = Movie.find(id)
        if movie.director.nil? || movie.director.empty?
            'missing director'
        else
            Movie.where(['director = :director and title != :title',{director: movie.director, title: movie.title }])
        end

    rescue ActiveRecord::RecordNotFound
        #"record not found"
    end
end
