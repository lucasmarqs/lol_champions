Sequel.migration do
  change do
    alter_table :items do
      set_column_allow_null :name
      set_column_allow_null :description      
    end
  end
end
