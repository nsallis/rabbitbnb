class RatingsController < ActionController::Base
skip_before_action :verify_authenticity_token
    def create
        puts "params: #{params.to_json}"
        render json: {status: "ok"}.to_json
    end
end

