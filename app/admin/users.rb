ActiveAdmin.register User do

  permit_params :email, :name, :encrypted_password

end
