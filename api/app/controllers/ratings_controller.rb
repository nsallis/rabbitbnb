class RatingsController < ActionController::Base
skip_before_action :verify_authenticity_token
    def create
        f_name = params[:voter]["first_name"]
        l_name = params[:voter]["last_name"]

        # check if the voter has already voted
        user_vote = UserVote.where(first_name: f_name, last_name: l_name)
        render json: {error: "you have already voted"} if user_vote.any?
        return if user_vote.any?

        rating = Rating.where(name: params[:name]).first_or_create
        rating.votes += 1
        rating.voters.push("#{f_name} #{l_name}")
        rating.save!

        # register that the user has now voted
        user_vote = UserVote.create(first_name: f_name, last_name: l_name, voted_for: params[:name])
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

