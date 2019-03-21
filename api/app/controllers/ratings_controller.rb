class RatingsController < ActionController::Base
skip_before_action :verify_authenticity_token
    def create
        puts "here"
        rating = Rating.where(name: params[:name]).first_or_create
            puts "rating was: #{rating.to_json}"
            rating.votes += 1
            rating.save!
            puts "rating now: #{rating.to_json}"
        render json: {status: "ok"}.to_json
    end

    def index
        render json: Rating.all.to_json
    end

    def show
        render json: Rating.where(name: params[:name]).first.to_json
    end
end

