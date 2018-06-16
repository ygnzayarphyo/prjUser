class AccountsController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :index]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  # GET /accounts
  # GET /accounts.json
  def index
    @account = Account.all.paginate(page: params[:page])
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = Account.find(params[:id])
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit

  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    @account.admin=false #for default admin false value
    respond_to do |format|

      if @account.save
        log_in @account
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    Account.find_by(id: params[:id]).destroy
    redirect_to "/accounts/", notice: "User deleted."
  end

  # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        redirect_to login_url, alert:"Please log in."
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = Account.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:name, :email, :passsword)

    end

    # Confirms an admin user.
    def admin_user
      if !current_user.admin?
        redirect_to("/login", alert: "please Login as Admin.") unless @account.admin?
      end
    end

end
