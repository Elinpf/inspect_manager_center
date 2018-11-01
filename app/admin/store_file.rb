ActiveAdmin.register StoreFile do
    #t.string "locate"
    #t.date "inspect_time"
    #t.string "path"
    #t.integer "version"
    #t.integer "user_id"
    #t.datetime "created_at", null: false
    #t.datetime "updated_at", null: false
    #t.string "client"
    #t.string "parser_path"
    #t.string "slug"
    #t.string "title"
    #t.boolean "recently", default: true
    #t.integer "devices_number"
    #t.index ["slug"], name: "index_store_files_on_slug", unique: true
    #t.index ["user_id"], name: "index_store_files_on_user_id"
  permit_params :client, :locate, :inspect_time, :version

  index do 
    selectable_column
    column :client, label: '客户'
    column :locate, label: '地市'
    column :inspect_time, label: '巡检时间'
    column :version
    column :devices_number, label: '设备数量'
    actions
  end

  filter :client, label: '客户'
  filter :locate, label: '地市'
  filter :inspect_time, as: :date_range, label: '巡检时间'
  filter :recently, as: :check_boxes, label: '最新', collection: {recently: true}

end

