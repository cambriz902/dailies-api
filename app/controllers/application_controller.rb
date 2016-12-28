class ApplicationController < ActionController::API
  around_action :set_time_zone, if: :current_user
  include Authenticable

  private

  def set_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end
end