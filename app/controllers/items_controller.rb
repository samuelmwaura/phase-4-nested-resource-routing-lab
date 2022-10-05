class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_item_not_found

  def index
    if params[:user_id] #Checks if the user for which the items should be found has been specified
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
      render json: items, include: :user
  end


  def show  #This will work even for nested routes since the Id value is the same
    render json: Item.find(params[:id]), include: :user
  end

  def create
   if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.create(item_params)
      #user.items << Item.create(item_params) - This is another way to create an item related to a given user but you wont be able to assign the create item to a variable inorder to render
   else
     item = Item.create(item_params)
   end
   render json: item , status: :created
  end

  private
  def render_item_not_found
    render json: {error: "Record not found!"}, status: :not_found
  end

  def item_params
    params.permit(:name,:description, :price)
  end

end
