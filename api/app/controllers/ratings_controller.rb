class RatingsController < ActionController::Base
    skip_before_action :verify_authenticity_token
    rescue_from Exception, :with => :generic_json_error

    def create
        f_name = params[:voter]['first_name'] # we should probably be using strong params
        l_name = params[:voter]['last_name']

        # check if the voter has already voted
        user_vote = UserVote.where(first_name: f_name, last_name: l_name)
        render json: {error: 'you have already voted'} if user_vote.any?
        return if user_vote.any?

        # add a vote to the rating
        Rating.vote(params[:name], f_name, l_name)

        # register that the user has now voted
        UserVote.create!(first_name: f_name, last_name: l_name, voted_for: params[:name])

        render json: {status: 'ok'}.to_json
    end

    def index
        render json: Rating.all.to_json
    end

    def show
        render json: Rating.where(name: params[:name]).first.to_json
    end

    private
    def generic_json_error(error)
        render json: {error: error.message}
    end
end

