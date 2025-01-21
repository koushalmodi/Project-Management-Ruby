class ProfilesController < ApplicationController
  before_action :find_user 
  before_action :load_profile, except: [:create]
  
  def create
    profile = current_user.build_profile(profile_params)
    if profile.save
      render json: ProfileSerializer.new(profile).serializable_hash
    else
      render json: profile.errors, status: :unprocessable_entity
    end
  end

  def update
    if @profile.update(profile_params)
      render json: ProfileSerializer.new(@profile).serializable_hash
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: ProfileSerializer.new(@profile).serializable_hash
  end

  private

  def load_profile
    @profile = current_user.profile
    return render json: {errors: {message:"profile not present"}}, status: :unprocessable_entity unless @profile.present?
  end

  def profile_params
    params.permit([:first_name, :last_name, :prefix, :role, :profile_image])
  end

end
