namespace :load_db do
  desc "drop, create, and migrate db"
  task create: [:environment, 'db:reset', 'db:drop', 'db:create', 'db:migrate'] do
    puts "DB succesfully dropped, created, and migrated"
  end

  desc "seed the db with sample data"
  task seed: ['load_db:create', 'db:seed'] do
    puts "DB succesfully seeded with temp data: #{Vendor.all.count} Companies, #{Buyer.all.count} Buyers, #{Order.all.count} Orders."
  end

end
