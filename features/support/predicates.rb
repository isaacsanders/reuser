module Roles
  def role?
    instance_of? ReUser::Role
  end
end

World(Roles)
