require_relative '../spec_helper'

describe ReUser::Role do
  it "is initialized with a name" do
    role = ReUser::Role.new :admin
    role.name.should === :admin

    role = ReUser::Role.new :user
    role.name.should === :user
  end

  it 'permissions are added and checked with #can and #can?' do
    role = ReUser::Role.new :admin
    role.can :read

    role.can?(:read).should be_true
  end
end
