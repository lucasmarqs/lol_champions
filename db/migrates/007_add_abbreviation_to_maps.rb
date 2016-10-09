Sequel.migration do
  change do
    add_column :maps, :abbreviation, String

    run <<~SQL
      UPDATE maps SET abbreviation = 'U'
    SQL

    alter_table :maps do
      set_column_not_null :abbreviation
    end
  end
end
