class Rating < ApplicationRecord

    def self.vote(name, f_name, l_name)
        rating = Rating.where(name: name).first_or_create
        rating.votes += 1
        rating.voters.push("#{f_name} #{l_name}")
        rating.save!
    end
end
