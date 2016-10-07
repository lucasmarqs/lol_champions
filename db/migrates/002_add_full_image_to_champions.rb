Sequel.migration do
  change do
    add_column :champions, :full_image, String
  end
end
