class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :html, :json

  def create
    super do |resource|
      if request.format.json?
        render json: {
          message: "Signed in successfully.",
          data: current_user
        }, status: :ok and return
      end
    end
  end

  def destroy
    super do
      if request.format.json?
        head :no_content
      end
    end
  end

  private

  def respond_with(resource, _opts = {})
    respond_to do |format|
      format.html { super } # Will render the default Devise HTML response
      format.json {
        render json: {
          message: "Signed in successfully.",
          data: current_user
        }, status: :ok
      }
    end
  end

  # def respond_to_on_destroy
  #   if request.format.json?
  #     head :no_content
  #   else
  #     super
  #   end
  # end
end
