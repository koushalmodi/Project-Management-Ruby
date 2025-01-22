class ProjectsController < ApplicationController
  before_action :find_user 
  before_action :load_project, except: [:create, :index]

  def index
    @projects = current_user.projects
    authorize @projects
    render json: ProjectSerializer.new(@projects).serializable_hash
  end
  
  def create
    project = current_user.projects.new(project_params)
    authorize project
    if params[:documents].present?
      project.documents.attach(params[:documents]) 
    end
    if project.save
      render json: ProjectSerializer.new(project).serializable_hash
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @project
    if @project.update(project_params)
      if params[:documents].present?
        @project.documents.attach(params[:documents])
        @project.save  
      end
      render json: ProjectSerializer.new(@project).serializable_hash
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: ProjectSerializer.new(@project).serializable_hash
  end

  def destroy
    authorize @project
    if @project.destroy
      render json: {message:"Project destroy successfully"}, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  private

  def load_project
    @project = current_user.projects.find_by(id:params[:id])
    return render json: {errors: {message:"project not present"}}, status: :unprocessable_entity unless @project.present?
  end

  def project_params
    params.permit([:name, :state, :astimated_cost, :start_date, :end_date, :logo, documents: []])
  end

end
