class CreateRevenueInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :revenue_infos do |t|
      t.datetime :trade_date
      t.decimal :revenue
      t.references :product

      t.timestamps
    end
  end
end
