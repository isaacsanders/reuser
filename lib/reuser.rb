require_relative "./reuser/role"

module ReUser
  def roles
    []
  end

  def role name
    ReUser::Role.new
  end
end
