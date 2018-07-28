class CartController < ApplicationController
    
    # add item id to cart
    def add
       id = params[:id]
       
       if session[:cart] then
          cart = session[:cart]
        else
          session[:cart] = {}
          cart = session[:cart]
       end
    
        if cart[id] then
          cart[id] = cart[id] + 1
        else
          cart[id] = 1
        end 
       
       redirect_to :action => :index
           
    end
    
    # remove all items from cart
    def clear
        session[:cart] = {}
        redirect_to :action => :index
    end
    
    # get cart
    def index 
        if session[:cart] == nil
            session[:cart]  = {}
        end      
        
        @cart = session[:cart] 
    end
    
    # remove an item from the cart
    def remove
        id = params[:id]
        cart = session[:cart]
        
        cart.delete id
        
        redirect_to :action => :index
    end
    
    
  def orderCreate
    
    @user = User.find(current_user.id)
    
    @order = @user.orders.build(:order_date => DateTime.now, :status => 'Pending')
    
    @order.save
    
    
    @cart = session[:cart] || {}
    
    @cart.each do | id, quantity |
      
      item = Item.find_by_id(id)
      
      @orderitem = @order.orderitems.build(:item_id => item.id, :title => item.name, :description => item.description, :quantity => quantity, :price => item.price)
    
    
    @orderitem.save
    
  end
    
   @orders = Order.last
    
   @orderitems = Orderitem.where(order_id: Order.last)
    
  end  
end
