class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
        can :manage, [User, EbBill, CourierBill, PaymentsBill, BillingBill, ClothsBill, Enquiry, ServiceBill, TicketBill]
        can [:read,:update, :create], AdminUser
        can :destroy, AdminUser do |u|
            u != user
        end
        can :read, ActiveAdmin::Page, name: "Dashboard"
    elsif user
        can [:index, :create, :search, :export], EbBill
        can [:update, :edit, :print], EbBill do |bill|
            bill.user == user
        end
        can [:index, :create, :search, :export], CourierBill
        can [:update, :edit, :print], CourierBill do |bill|
            bill.user == user
        end
        can [:index, :create, :search, :export], PaymentsBill
        can [:update, :edit, :print], PaymentsBill do |bill|
            bill.user == user
        end
        can [:index, :create, :search, :export], ClothsBill
        can [:update, :edit, :print], ClothsBill do |bill|
            bill.user == user
        end
        can [:index, :create, :search, :export], ServiceBill
        can [:update, :edit, :print], ServiceBill do |bill|
            bill.user == user
        end
        can [:index, :create, :search, :export], TicketBill
        can [:update, :edit, :print], TicketBill do |bill|
            bill.user == user
        end
        can [:index, :create, :search, :export], Enquiry
        can [:update, :edit, :print], Enquiry do |bill|
            bill.user == user
        end
        can [:index, :create, :search, :export], BillingBill
        can [:update, :edit, :print], BillingBill do |bill|
            bill.user == user
        end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
