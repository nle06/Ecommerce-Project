class CreateTaxRates < ActiveRecord::Migration[7.1]
  def change
    create_table :tax_rates do |t|
      t.string :region
      t.decimal :rate

      t.timestamps
    end
  end
end
