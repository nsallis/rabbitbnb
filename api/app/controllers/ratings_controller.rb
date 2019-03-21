class RatingsController < ActionController::Base
skip_before_action :verify_authenticity_token
    def create
        # check if the voter has already voted
        user_vote = UserVote.where(first_name: params[:voter]["first_name"], last_name: params[:voter]["last_name"])
        render json: {error: "you have already voted"} if user_vote.any?
        return if user_vote.any?

!
        rating = Rating.where(name: params[:name]).first_or_create
        puts "rating was: #{rating.to_json}"
        rating.votes += 1
        rating.save!
        puts "rating now: #{rating.to_json}"

        # register that the user has now voted
        user_vote = UserVote.create(first_name: params[:voter]["first_name"], last_name: params[:voter]["last_name"], voted_for: params[:name])
        user_vote.save
        render json: {status: "ok"}.to_json
    end

    def index
        render json: Rating.all.to_json
    end

    def show
        render json: Rating.where(name: params[:name]).first.to_json
    end
end

