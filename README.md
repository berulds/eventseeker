<!-- PUNDIT  -->


# step ONE
# rails generate pundit:policy NAMEOFTABLE #(for every table that need ofc)


# step TWO
#   authorize @ in the method definition  controller
# def show
#   authorize @tablename # Add this line
# end


# step THREE
# app/policies/restaurant_policy.rb
# class NAMEOFTABLEPolicy < ApplicationPolicy
#   # [...]
#   def show?
#     true
#   end
# end






# step FOUR
# Policy
# app/policies/restaurant_policy.rb
# class  nameoftablePolicy < ApplicationPolicy
#   # [...]
#   def update?
#     record.user == user
#     # record: the restaurant passed to the `authorize` method in controller
#     # user: the `current_user` signed in with Devise
#   end

#   def destroy?
#     record.user == user
#   end
# end

# View
# Hide the links for unauthorized users:

# <!-- app/views/restaurants/show.html.erb -->
# <!-- [...] -->
# <% if policy(@restaurant).edit? %>
#   <%= link_to "Edit this restaurant", edit_restaurant_path(@restaurant) %> |
# <% end %>

# step FIVE
# https://kitt.lewagon.com/camps/1290/lectures/05-Rails%2F10-Airbnb-Ajax-in-Rails
