class SessionsController < Devise::SessionsController
  respond_to :json
  before_action :authenticate_user!, only: :destroy
end
