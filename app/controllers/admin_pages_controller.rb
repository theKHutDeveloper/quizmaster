# The controller for Administration Rights
class AdminPagesController < ApplicationController
  before_action :require_admin, only: [:index]

  def index; end
end
