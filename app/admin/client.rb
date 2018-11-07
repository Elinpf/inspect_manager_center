ActiveAdmin.register Client do
  permit_params :name, :city_id
  menu label: '客户', priority: 3

  index do
    selectable_column
    column :name
    column :city
    actions
  end
  remove_filter :created_at
  remove_filter :updated_at
end

