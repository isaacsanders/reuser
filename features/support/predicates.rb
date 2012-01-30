module Roles
  def role?
    kind_of? ReUser::Role
  end
end

World(Roles)
