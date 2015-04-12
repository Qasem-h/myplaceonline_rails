class HealthController < ApplicationController
  skip_authorization_check

  def index
    @initialCategoryList = Myp.categories_for_current_user(current_user, Myp.categories[:health]).to_json
  end
end