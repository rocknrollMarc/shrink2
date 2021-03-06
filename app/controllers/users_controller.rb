class UsersController < ResourceApplicationController
  layout "users"

  before_filter :require_user
  before_filter :establish_all_models, :only => [:index, :show, :update_role]
  before_filter :establish_all_roles, :only => [:index, :create, :show, :update_role]
  before_filter :establish_parents_via_params, :only => [:new, :create, :update_role]
  before_filter :establish_model_via_id_param, :only => [:show, :edit, :update, :update_role, :update_password, :destroy]

  filter_access_to :index
  filter_access_to :all, :attribute_check => true, :load_method => Proc.new { @user }

  set_create_errors_area_dom_id "new_project_errors"

  def index
    # Intentionally blank
  end

  def create
    super
    establish_all_models
  end

  def update_role
    @current_user_demoted = current_user == @user && @user.demotion?(@role)
    current_user.role = @role if current_user == @user
    @user.role = @role
    update
  end

  # TODO Alias action that includes filters
  alias_method :update_password, :update

  private
  def establish_all_models
    @users = Shrink::User.order("login asc")
  end

  def establish_all_roles
    @roles = Shrink::Role.order("name asc")
  end

end
