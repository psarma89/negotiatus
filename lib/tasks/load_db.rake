namespace :load_db do
  desc "drop, create, and migrate db"
  task create: [:environment, 'db:drop', 'db:create', 'db:migrate'] do

  end

  desc "seed the db with sample data"
  task seed: ['load_db:create'] do
  end

end
