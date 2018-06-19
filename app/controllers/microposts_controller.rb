class MicropostsController < ApplicationController
  before_action :logged_in?, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]
  def create
    @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
          flash[:notice] = "Micropost created!"
          redirect_to root_url
        else
          @feed_items=[]
          redirect_to root_url
        end
  end
  def destroy
    @micropost.destroy
    flash[:notice]="Micropost delete successful!!"
    redirect_to request.referrer || root_url
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content,:picture)
    end
    def correct_user
      @micropost=current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
