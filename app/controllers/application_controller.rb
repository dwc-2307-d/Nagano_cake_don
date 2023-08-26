class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_search

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:last_name,
                                             :first_name,
                                             :last_name_kana,
                                             :first_name_kana,
                                             :address,
                                             :post_code,
                                             :telephone_number,
                                             :email,
                                             :is_deleted
                                             ])
  end

  private

  def initialize_search
    @q = Item.ransack(params[:q])
  end

end
