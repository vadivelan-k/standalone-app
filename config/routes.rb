Billz::Application.routes.draw do

  root :to => 'home#index'

  devise_for :users

  match 'home', :via => [:get], :to => 'users#index'
  match 'user/root' => redirect('/home') # setup user_root_path so devise will redirect user to /home after user login
  
  resources :firms do
    resources :clients do
      resources :matters
    end
    resources :time_entries
    resources :expense_entries
    resources :invoices
    resources :payments
  end
  
  match 'firms/:firm_id/clients/:client_id/new_matters_form', :via => [:get], :to => 'matters#new_form'
  
  # ===== edit invoice form routes
  # hold item
  match 'firms/:firm_id/invoices/:invoice_id/time_entries/:id/hold', :to => 'time_entries#hold'
  match 'firms/:firm_id/invoices/:invoice_id/expense_entries/:id/hold', :to => 'expense_entries#hold'
  # add item
  match 'firms/:firm_id/invoices/:invoice_id/time_entries/new', :to => "time_entries#new_from_invoice"
  match 'firms/:firm_id/invoices/:invoice_id/expense_entries/new', :to => "expense_entries#new_from_invoice"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
