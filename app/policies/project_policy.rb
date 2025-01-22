class ProjectPolicy < Struct.new(:user, :project)
  
  def index?
    user.lead?
  end

  def create?
    user.lead?
  end

  def update?
    user.lead?
  end

  def destroy?
    user.lead?
  end

end
